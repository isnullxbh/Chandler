/**
 * @file    base_types.hpp
 * @author  Oleg E. Vorobiov <isnullxbh(at)gmail.com>
 * @date    29.12.2023
 */

#pragma once

#include <cstdint>

namespace mcu
{

enum class Mode : std::uint8_t
{
    Local  = 0x00,
    Remote = 0x01
};

enum class RelayState : std::uint8_t
{
    On  = 0x01,
    Off = 0x00
};

enum class LightSensorDependency : std::uint8_t
{
    Disabled = 0x00,
    Direct   = 0x01,
    Inverse  = 0x02
};

enum class LedStripState
{
    Disabled      = 0x00,
    CoolWhite     = 0x01,
    ModerateWhite = 0x02,
    WarmWhite     = 0x03
};

} // namespace mcu
