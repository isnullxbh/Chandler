/**
 * @file    message_type.hpp
 * @author  Oleg E. Vorobiov <isnullxbh(at)gmail.com>
 * @date    29.12.2023
 */

#pragma once

#include <cstdint>

namespace mcu
{

enum class MessageType : std::uint8_t
{
    SetMode                             = 0x01,
    SetRelay1State                      = 0x02,
    SetRelay2State                      = 0x03,
    SetLightSensorDependencyForRelay1   = 0x04,
    SetLightSensorDependencyForRelay2   = 0x05,
    SetLedStripState                    = 0x06,
    SetLightSensorDependencyForLedStrip = 0x07,
    GetState                            = 0x08
};

} // namespace mcu
