# Copyright (C) 2024 Renesas Electronics Corporation.
# Copyright (C) 2024 EPAM Systems, Inc.
#
# SPDX-License-Identifier: Apache-2.0
#

# ######################################################################################################################
# Targets
# ######################################################################################################################

add_library(aosprotocol INTERFACE)

target_include_directories(aosprotocol INTERFACE ${CMAKE_CURRENT_SOURCE_DIR})
