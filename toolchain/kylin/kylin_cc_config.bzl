# toolchain/cc_toolchain_config.bzl
load("@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl", "feature", "flag_group", "flag_set", "tool_path")

def _impl(ctx):
    tool_paths = [
        tool_path(
            name = "gcc",
            path = "wrapper/gcc.sh",
        ),
        tool_path(
            name = "ld",
            path = "/usr/bin/ld",
        ),
        tool_path(
            name = "ar",
            path = "/usr/bin/ar",
        ),
        tool_path(
            name = "cpp",
            path = "/usr/bin/cpp",
        ),
        tool_path(
            name = "gcov",
            path = "/usr/bin/gcov",
        ),
        tool_path(
            name = "nm",
            path = "/usr/bin/nm",
        ),
        tool_path(
            name = "objdump",
            path = "/usr/bin/objdump",
        ),
        tool_path(
            name = "strip",
            path = "/usr/bin/strip",
        ),
    ]
    default_link_flags_feature = feature(
        name = "default_link_flags",
        enabled = True,  # 默认开启
        flag_sets = [
            flag_set(
                actions = [
                    "c++-link-executable",
                    "c++-link-dynamic-library",
                    "c++-link-nodeps_dynamic_library",
                ],
                flag_groups = [
                    flag_group(
                        flags = [
                            "-lstdc++",
                            "-lm",
                        ],
                    ),
                ],
            ),
        ],
    )

    # 关键：告诉 Bazel 哪些是系统内置的头文件路径
    # 如果编译时报 "stdio.h not found" 或类似错误，需要根据你的系统调整这里
    cxx_builtin_include_directories = [
        "/usr/include",
        "/usr/local/include",
        "/usr/",
    ]

    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        features = [default_link_flags_feature],
        cxx_builtin_include_directories = cxx_builtin_include_directories,
        toolchain_identifier = "kylin-toolchain",
        host_system_name = "local",
        target_system_name = "local",
        target_cpu = "kylin-x86_64",
        target_libc = "unknown",
        compiler = "gcc",
        abi_version = "2.23",
        abi_libc_version = "2.23",
        tool_paths = tool_paths,
    )

cc_toolchain_config = rule(
    implementation = _impl,
    attrs = {},
    provides = [CcToolchainConfigInfo],
)
