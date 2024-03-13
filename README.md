<div align="center">
  <img width="50%" src="./logo.svg">
  <h2><br>glfw bindings for the C3 programming language</h2>
</div>

<h3> Quickstart </h3>
Copy <a href="./glfw.c3l">glfw.c3l</a> in your 'libs' folder within your project structure. Ensure you add it to your
dependencies field in project.json:

```json 
"dependencies": [ "glfw" ]
```

<h3> Basic Window </h3>

```c
module app;

import std::io;
import glfw;

fn int main(String[] args)
{
    glfw::init();

    glfw::Window wnd = glfw::create_window(800, 600, "example", null, null);
    glfw::make_context_current(wnd);

    while (!glfw::window_should_close(wnd))
    {
        glfw::swap_buffers(wnd);
        glfw::poll_events();
    }

    glfw::destroy_window(wnd);
    glfw::terminate();
}
```
