# Copyright (C) 2024 Renesas Electronics Corporation.
# Copyright (C) 2024 EPAM Systems, Inc.
#
# SPDX-License-Identifier: Apache-2.0
#

# ######################################################################################################################
# Target
# ######################################################################################################################

set(TARGET ${TARGET_PREFIX}_protocol)

add_library(${TARGET} INTERFACE)
add_library("${TARGET_NAMESPACE}::protocol" ALIAS ${TARGET})

target_include_directories(${TARGET} INTERFACE ${CMAKE_CURRENT_SOURCE_DIR})
