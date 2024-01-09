/**
 * @file    mcu.cpp
 * @author  Oleg E. Vorobiov <isnullxbh(at)gmail.com>
 * @date    29.12.2023
 */

#include <mcu-simulator/mcu.hpp>

#include <iostream>

namespace mcu
{

auto Mcu::state() const noexcept -> const State&
{
    return _state;
}

void Mcu::setMode(Mode mode)
{
    _state.mode = mode;
    std::cout << "Mode changed to " << (mode == Mode::Local ? "local" : "remote") << std::endl;
}

void Mcu::setRelay1State(RelayState state)
{
    _state.relay1_state = state;
    std::cout << "Relay (1) state changed to " << (state == RelayState::On ? "on" : "off") << std::endl;
}

void Mcu::setRelay1LightSensorDependencyMode(LightSensorDependency mode)
{
    _state.relay1_lsd = mode;
    std::cout << "Relay (1) mode changed to ";
    switch (mode)
    {
        case LightSensorDependency::Disabled:
            std::cout << "disabled";
            break;

        case LightSensorDependency::Direct:
            std::cout << "direct";
            break;

        case LightSensorDependency::Inverse:
            std::cout << "inverse";
            break;
    }
    std::cout << std::endl;
}

void Mcu::setRelay2State(RelayState state)
{
    _state.relay2_state = state;
    std::cout << "Relay (2) state changed to " << (state == RelayState::On ? "on" : "off") << std::endl;
}

void Mcu::setRelay2LightSensorDependencyMode(LightSensorDependency mode)
{
    _state.relay2_lsd = mode;
    std::cout << "Relay (2) mode changed to ";
    switch (mode)
    {
        case LightSensorDependency::Disabled:
            std::cout << "disabled";
        break;

        case LightSensorDependency::Direct:
            std::cout << "direct";
        break;

        case LightSensorDependency::Inverse:
            std::cout << "inverse";
        break;
    }
    std::cout << std::endl;
}

void Mcu::setLedStripState(LedStripState state)
{
    _state.led_strip_state = state;
    std::cout << "LED strip state changed to ";
    switch (state)
    {
        case LedStripState::Disabled:
            std::cout << "disabled";
            break;

        case LedStripState::CoolWhite:
            std::cout << "cool white";
            break;

        case LedStripState::ModerateWhite:
            std::cout << "moderate white";
            break;

        case LedStripState::WarmWhite:
            std::cout << "warm white";
            break;
    }
    std::cout << std::endl;
}

void Mcu::setLedStripLightSensorDependencyMode(LightSensorDependency mode)
{
    _state.led_strip_lsd = mode;
    std::cout << "LED strip mode changed to ";
    switch (mode)
    {
        case LightSensorDependency::Disabled:
            std::cout << "disabled";
            break;

        case LightSensorDependency::Direct:
            std::cout << "direct";
            break;

        case LightSensorDependency::Inverse:
            std::cout << "inverse";
            break;
    }
    std::cout << std::endl;
}

auto Mcu::get() -> Mcu&
{
    static Mcu instance;
    return instance;
}

} // namespace mcu
