# cc_toolchains_kylin

[English](#english) | [中文](#chinese)

<a name="english"></a>

A Bazel C++ toolchain configuration explicitly designed for the **Kylin** operating system (Linux x86_64).

## Overview

This project provides a custom Bazel toolchain that wraps the system GCC. It is specifically configured to address compatibility issues on Kylin systems, such as:
- **Legacy Glibc Support**: Targets environments with `glibc 2.23`.
- **Flag Filtering**: Automatically removes or downgrades unsupported C++ standard flags (e.g., `-std=c++20`) via a wrapper script, ensuring builds succeed on older GCC versions commonly found on Kylin.

## Installation

Add the following to your `MODULE.bazel` to use this toolchain:

```starlark
bazel_dep(name = "cc_toolchains_kylin", version = "0.0.1")

git_override(
    module_name = "cc_toolchains_kylin",
    commit = "a7b387cc1bc0b98ae69a372eee1f93f8cd45a672", # Check for the latest commit hash
    remote = "https://github.com/kekxv/cc_toolchains_kylin.git",
)
```

## Usage

### Platforms

The toolchain defines a platform target `//platforms:kylin` (aliased as `//:kylin` in the root) which applies the following constraints:
- `@platforms//os:linux`
- `@platforms//cpu:x86_64`
- `//platforms:glibc_2_23`

It also sets execution properties:
```json
{
    "OSFamily": "kylin-v10"
}
```

### Running Examples

An example project is included in the `examples/` directory. To run it:

```bash
cd examples
bazel run //src:main
```

### rules_foreign_cc Compatibility

If you are using `rules_foreign_cc` (e.g., for CMake builds) and encounter errors regarding compiler checks, you may need to force the compiler check to pass by adding the following cache entries:

```starlark
cache_entries = {
    "CMAKE_C_COMPILER_WORKS": "TRUE",
    "CMAKE_CXX_COMPILER_WORKS": "TRUE",
},
```

## Directory Structure

- `toolchain/kylin`: Contains the core toolchain definitions and the GCC wrapper script.
- `platforms`: Defines the platform constraints (e.g., glibc version).
- `examples`: A standalone workspace demonstrating how to use the toolchain.

---

<a name="chinese"></a>

# 中文说明

专为 **麒麟 (Kylin)** 操作系统 (Linux x86_64) 设计的 Bazel C++ 工具链配置。

## 概述

本项目提供了一个自定义的 Bazel 工具链，它封装了系统的 GCC。专为解决麒麟系统上的兼容性问题而配置，例如：
- **旧版 Glibc 支持**: 针对具有 `glibc 2.23` 的环境。
- **标志过滤**: 通过包装脚本自动移除或降级不支持的 C++ 标准标志（例如 `-std=c++20`），确保在麒麟系统上常见的旧版 GCC 上构建成功。

## 安装

在 `MODULE.bazel` 中添加以下内容以使用此工具链：

```starlark
bazel_dep(name = "cc_toolchains_kylin", version = "0.0.1")

git_override(
    module_name = "cc_toolchains_kylin",
    commit = "a7b387cc1bc0b98ae69a372eee1f93f8cd45a672", # 请检查并使用最新的 commit hash
    remote = "https://github.com/kekxv/cc_toolchains_kylin.git",
)
```

## 使用

### 平台 (Platforms)

工具链定义了一个平台目标 `//platforms:kylin`（在根目录下别名为 `//:kylin`），它应用了以下约束：
- `@platforms//os:linux`
- `@platforms//cpu:x86_64`
- `//platforms:glibc_2_23`

它还设置了执行属性：
```json
{
    "OSFamily": "kylin-v10"
}
```

### 运行示例

`examples/` 目录下包含一个示例项目。运行方法：

```bash
cd examples
bazel run //src:main
```

### rules_foreign_cc 兼容性

如果您使用 `rules_foreign_cc`（例如用于 CMake 构建）并遇到编译器检查错误，您可能需要添加以下缓存条目来强制通过编译器检查：

```starlark
cache_entries = {
    "CMAKE_C_COMPILER_WORKS": "TRUE",
    "CMAKE_CXX_COMPILER_WORKS": "TRUE",
},
```

## 目录结构

- `toolchain/kylin`: 包含核心工具链定义和 GCC 包装脚本。
- `platforms`: 定义平台约束（例如 glibc 版本）。
- `examples`: 一个独立的 workspace，演示如何使用该工具链。
