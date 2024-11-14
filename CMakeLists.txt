#
# Copyright (C) 2024 Renesas Electronics Corporation.
# Copyright (C) 2024 EPAM Systems, Inc.
#
# SPDX-License-Identifier: Apache-2.0
#

cmake_minimum_required(VERSION 3.19)

# ##############################################################################
# Generate gRPC stubs
# ##############################################################################

project(aos_core_api)

# ##############################################################################
# Options
# ##############################################################################

option(WITH_IAM_API "build core api iam lib" ON)
option(WITH_SM_API "build core api sm lib" OFF)

message(STATUS)
message(STATUS "${CMAKE_PROJECT_NAME} configuration:")
message(STATUS "WITH_IAM_API            = ${WITH_IAM_API}")
message(STATUS "WITH_SM_API             = ${WITH_SM_API}")

# ##############################################################################
# Compiler flags
# ##############################################################################

add_compile_options(-fPIC -Wall -Werror -Wextra -Wpedantic)
set(CMAKE_CXX_STANDARD 17)

# ##############################################################################
# Dependencies
# ##############################################################################

find_package(gRPC CONFIG REQUIRED)
find_package(Protobuf REQUIRED)

set(PROTO_DST_DIR "${CMAKE_CURRENT_BINARY_DIR}/gen")
set(PROTO_SRC_DIR "${CMAKE_CURRENT_LIST_DIR}/proto")
set(GENERATE_EXTENSIONS ".grpc.pb.h" ".grpc.pb.cc")

file(MAKE_DIRECTORY ${PROTO_DST_DIR})

if(CMAKE_CROSSCOMPILING)
    find_program(_GRPC_CPP_PLUGIN_EXECUTABLE grpc_cpp_plugin)
else()
    set(_GRPC_CPP_PLUGIN_EXECUTABLE $<TARGET_FILE:gRPC::grpc_cpp_plugin>)
endif()

# ##############################################################################
# Targets
# ##############################################################################

add_subdirectory(proto)
