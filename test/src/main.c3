module test;

import std::io;
import glfw;
import gl;

fn void print_debug_info()
{
	int v_major, v_minor, v_rev;
	glfw::get_version(&v_major, &v_minor, &v_rev);

	io::printfn("GLFW version: %d.%d.%d", v_major, v_minor, v_rev);
	io::printfn("OpenGL vendor:   %s", (ZString)gl::get_string(0x1F00));
	io::printfn("OpenGL renderer: %s", (ZString)gl::get_string(0x1F01));
	io::printfn("OpenGL version:  %s", (ZString)gl::get_string(0x1F02));
}

fn int main(String[] args)
{
	if (!glfw::init())
	{
		io::printn("failed to init glfw!");
		return -1;
	}

	glfw::window_hint(glfw::CONTEXT_VERSION_MAJOR, 4);
	glfw::window_hint(glfw::CONTEXT_VERSION_MINOR, 1);
	glfw::window_hint(glfw::OPENGL_PROFILE, glfw::OPENGL_CORE_PROFILE);
	glfw::window_hint(glfw::OPENGL_FORWARD_COMPAT, glfw::TRUE);

	glfw::Window wnd = glfw::create_window(800, 500, "GLFW C3 Test", null, null);

	if (wnd == null)
	{
		io::printn("failed to create window!");
		return -1;
	}

	glfw::set_key_cb(wnd, fn void(Window wnd, Key key, int scancode, Action action, Mod mods)
	{
		String state;

    	switch (action)
		{
			case glfw::RELEASE:
				state = "released";
			case glfw::PRESS:
				state = "pressed";
			case glfw::REPEAT:
				state = "repeat";
			default:
		}

		io::printfn("key(%d) scancode(%d) state(%s) mods(%d)", key, scancode, state, mods);
	});

	glfw::make_context_current(wnd);

	if (!gl::load_gl_loader((gl::FnLoadProc)&glfw::get_proc_address))
	{
		io::printn("failed to load opengl functions!");
		return -1;
	}

	print_debug_info();

	while(!glfw::window_should_close(wnd))
	{
		gl::clear_color(0.2f, 0.0f, 0.3f, 1.0f);
		gl::clear(0x00004000);

		glfw::swap_buffers(wnd);
		glfw::poll_events();
	}

	glfw::destroy_window(wnd);
	glfw::terminate();
	return 0;
}
