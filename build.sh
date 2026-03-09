#!/bin/bash

set +x
set -euo pipefail

print_next_step() {
    echo
    echo "====================================="
    echo "  $1"
    echo "====================================="
    echo
}

print_usage() {
    echo
    echo "Usage: ./build.sh <command> [options]"
    echo
    echo "Commands:"
    echo "  build                      builds target"
    echo
    echo "Options:"
    echo "  --clean                    cleans build artifacts before building"
    echo "  --parallel <N>             specifies number of parallel jobs for build (default: all available cores)"
    echo "  --build-type <type>        specifies build type (default: Debug, other options: Release, RelWithDebInfo, MinSizeRel)"
    echo
}

error_with_usage() {
    echo >&2 "ERROR: $1"
    echo

    print_usage

    exit 1
}

clean_build() {
    print_next_step "Clean artifacts"

    rm -rf ./build/
}

conan_setup() {
    print_next_step "Setting up conan default profile"

    conan profile detect --force

    print_next_step "Generate conan toolchain"

    conan install ./conan/ --output-folder build --settings=build_type="$ARG_BUILD_TYPE" --build=missing
}

build_project() {
    print_next_step "Run cmake configure"

    cmake -S . -B build \
        -DCMAKE_TOOLCHAIN_FILE=./conan_toolchain.cmake \
        -DCMAKE_BUILD_TYPE="$ARG_BUILD_TYPE" \
        -DWITH_AOS_PROTOCOL=ON \
        -DWITH_IAM_API=ON \
        -DWITH_SM_API=ON


    print_next_step "Run build"

    cmake --build ./build/ --config "$ARG_BUILD_TYPE" --parallel "$ARG_PARALLEL_JOBS"

    echo
    echo "Build succeeded!"
}

parse_arguments() {
    while [[ $# -gt 0 ]]; do
        case $1 in
        --clean)
            ARG_CLEAN_FLAG=true
            shift
            ;;

        --parallel)
            ARG_PARALLEL_JOBS="$2"
            shift 2
            ;;

        --build-type)
            ARG_BUILD_TYPE="$2"
            shift 2
            ;;

        *)
            error_with_usage "Unknown option: $1"
            ;;
        esac
    done
}

build_target() {
    if [ "$ARG_CLEAN_FLAG" == "true" ]; then
        clean_build
    fi

    conan_setup
    build_project
}

#=======================================================================================================================

if [ $# -lt 1 ]; then
    error_with_usage "Missing command"
fi

command="$1"
shift

ARG_CLEAN_FLAG=false
ARG_PARALLEL_JOBS=$(nproc)
ARG_BUILD_TYPE="Debug"

case "$command" in
build)
    parse_arguments "$@"
    build_target
    ;;

*)
    error_with_usage "Unknown command: $command"
    ;;
esac
