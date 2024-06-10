/*
 * Copyright (C) 2024 Renesas Electronics Corporation.
 * Copyright (C) 2024 EPAM Systems, Inc.
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#ifndef AOS_PROTOCOL_H_
#define AOS_PROTOCOL_H_

#include <stddef.h>
#include <stdint.h>

#pragma pack(push, 1)

/**
 * Aos low level protocol header.
 */
struct AosProtocolHeader {
    uint32_t mPort;
    uint32_t mDataSize;
    uint8_t mCheckSum[32];
};

/**
 * Aos protobuf header.
 */
struct AosProtobufHeader {
    char mMethodName[256];
    uint32_t mDataSize;
};

#pragma pack(pop)

#endif
