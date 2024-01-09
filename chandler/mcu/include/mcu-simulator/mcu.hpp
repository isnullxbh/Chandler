/**
 * @file    mcu.hpp
 * @author  Oleg E. Vorobiov <isnullxbh(at)gmail.com>
 * @date    29.12.2023
 */

#pragma once

#include <mcu-simulator/base_types.hpp>

namespace mcu
{

class Mcu
{
public:
    struct State
    {
        Mode                    mode;
        RelayState              relay1_state;
        LightSensorDependency   relay1_lsd;
        RelayState              relay2_state;
        LightSensorDependency   relay2_lsd;
        LedStripState           led_strip_state;
        LightSensorDependency   led_strip_lsd;
    };

    auto state() const noexcept -> const State&;
    void setMode(Mode mode);
    void setRelay1State(RelayState state);
    void setRelay1LightSensorDependencyMode(LightSensorDependency mode);
    void setRelay2State(RelayState state);
    void setRelay2LightSensorDependencyMode(LightSensorDependency mode);
    void setLedStripState(LedStripState state);
    void setLedStripLightSensorDependencyMode(LightSensorDependency mode);

    static auto get() -> Mcu&;

private:
    State _state {};
};

} // namespace mcu
