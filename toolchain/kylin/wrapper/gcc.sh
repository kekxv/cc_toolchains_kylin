#!/bin/bash

# 真正的 GCC 路径
REAL_GCC="/usr/bin/gcc"

# 定义新的参数数组
ARGS=()

# 遍历所有传入的参数
for arg in "$@"; do
    case "$arg" in
        # 匹配想要去掉的参数
        -std=c++20)
            # 可以在这里打印日志，方便调试
            # echo "Warning: Removing unsupported flag -std=c++20" >&2

            # 如果你的 GCC 较老，可能需要把它降级为支持的最高版本，比如 -std=c++17
            # 如果仅仅是去掉，什么都不做即可
            # ARGS+=("-std=c++17")
            ;;

        # 也可以同时过滤其他不支持的 flag，例如：
        -std=c++2a)
            ;;

        *)
            # 其他参数原样保留
            ARGS+=("$arg")
            ;;
    esac
done

# 执行真正的 GCC，并传入过滤后的参数
# exec 能够替换当前 shell 进程，保留 PID，对 Bazel 更友好
exec "$REAL_GCC" "${ARGS[@]}"