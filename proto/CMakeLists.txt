#
# Copyright (C) 2024 Renesas Electronics Corporation.
# Copyright (C) 2024 EPAM Systems, Inc.
#
# SPDX-License-Identifier: Apache-2.0
#

# ######################################################################################################################
# Functions
# ######################################################################################################################

function(create_core_api_lib TARGET_NAME PROTO_FILES)
    message(STATUS "Generating ${TARGET_NAME} target")

    add_library(${TARGET_NAME} OBJECT ${PROTO_FILES})
    target_link_libraries(${TARGET_NAME} PUBLIC protobuf::libprotobuf gRPC::grpc++)
    target_include_directories(${TARGET_NAME} PUBLIC "$<BUILD_INTERFACE:${PROTO_DST_DIR}>")

    protobuf_generate(TARGET ${TARGET_NAME} IMPORT_DIRS ${PROTO_SRC_DIR} PROTOC_OUT_DIR "${PROTO_DST_DIR}")

    protobuf_generate(
        TARGET
        ${TARGET_NAME}
        LANGUAGE
        grpc
        GENERATE_EXTENSIONS
        ${GENERATE_EXTENSIONS}
        PLUGIN
        "protoc-gen-grpc=${_GRPC_CPP_PLUGIN_EXECUTABLE}"
        IMPORT_DIRS
        ${PROTO_SRC_DIR}
        PROTOC_OUT_DIR
        "${PROTO_DST_DIR}"
    )
endfunction()

# ######################################################################################################################
# Targets
# ######################################################################################################################

if(WITH_IAM_API)
    set(IAM_PROTO_FILES "${PROTO_SRC_DIR}/common/v1/common.proto" "${PROTO_SRC_DIR}/iamanager/v5/iamanager.proto"
                        "${PROTO_SRC_DIR}/iamanager/version.proto"
    )

    create_core_api_lib(aoscoreapi-gen-iam "${IAM_PROTO_FILES}")
endif()

if(WITH_SM_API)
    set(SM_PROTO_FILES "${PROTO_SRC_DIR}/common/v1/common.proto"
                       "${PROTO_SRC_DIR}/servicemanager/v4/servicemanager.proto"
    )

    create_core_api_lib(aoscoreapi-gen-sm "${SM_PROTO_FILES}")
endif()
