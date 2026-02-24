const sdl = @cImport(@cInclude("SDL3/SDL.h"));

pub fn main() !void {
    if (!sdl.SDL_Init(sdl.SDL_INIT_VIDEO))
        @panic("failed to initialize sdl3");

    var next_ns = sdl.SDL_GetTicksNS() + 16666667;

    while (true) {
        const start_ns = sdl.SDL_GetTicksNS();

        // logic

        const now = sdl.SDL_GetTicksNS();
        const loop_ns = now - start_ns;
        if (loop_ns > 16666667)
            @panic("loop time exceeded 16666667 ns");

        next_ns += 16666667;
        if (now < next_ns)
            sdl.SDL_DelayNS(next_ns - now);
    }
}
