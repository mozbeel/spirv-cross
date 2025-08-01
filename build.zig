const std = @import("std");

const spirv_cross_sources = &[_][]const u8{
    "main.cpp",
    "spirv_cfg.cpp",
    "spirv_cpp.cpp",
    "spirv_cross.cpp",
    "spirv_cross_c.cpp",
    "spirv_cross_parsed_ir.cpp",
    "spirv_cross_util.cpp",
    "spirv_glsl.cpp",
    "spirv_hlsl.cpp",
    "spirv_msl.cpp",
    "spirv_parser.cpp",
    "spirv_reflect.cpp",

};

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe_mod = b.addModule("spirv_cross", .{
        .target = target,
        .optimize = optimize,
    });

    const exe = b.addExecutable(.{
        .name = "spirv_cross",
        .root_module = exe_mod,
    });
    
    exe.addCSourceFiles(.{
        .flags = &.{
            "-DSPIRV_CROSS_C_API_GLSL",
            "-DSPIRV_CROSS_C_API_HLSL",
            "-DSPIRV_CROSS_C_API_MSL",
            "-DSPIRV_CROSS_C_API_CPP",
            "-DSPIRV_CROSS_C_API_REFLECT",
        },
        .files = spirv_cross_sources,
    });

    exe.addIncludePath(b.path("."));

    exe.linkLibC();
    exe.linkLibCpp();
    
    b.installArtifact(exe);
}
