const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const heap_module = b.createModule(.{
        .root_source_file = b.path("src/heap/heap.zig"),
        .target = target,
        .optimize = optimize,
    });

    const game_module = b.createModule(.{
        .root_source_file = b.path("src/game/main.zig"),
        .target = target,
        .optimize = optimize,
    });

    game_module.addImport("heap", heap_module);

    const exe = b.addExecutable(.{
        .name = "game",
        .root_module = game_module,
    });

    exe.linkLibC();
    exe.linkSystemLibrary("mimalloc");
    exe.linkSystemLibrary("SDL3");

    b.installArtifact(exe);

    const run_exe = b.addRunArtifact(exe);

    const run_step = b.step("run", "run the game");
    run_step.dependOn(&run_exe.step);
}
