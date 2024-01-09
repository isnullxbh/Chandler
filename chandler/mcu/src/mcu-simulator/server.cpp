/**
 * @file    server.cpp
 * @author  Oleg E. Vorobiov <isnullxbh(at)gmail.com>
 * @date    29.12.2023
 */

#include <mcu-simulator/server.hpp>

#include <functional>
#include <iostream>
#include <memory>

#include <mcu-simulator/mcu.hpp>
#include <mcu-simulator/message_type.hpp>

namespace mcu
{

Server::Server(asio::io_context& ioc)
    : _socket(ioc)
{}

void Server::run(const asio::ip::udp::endpoint& endpoint)
{
    _socket.open(endpoint.protocol());
    _socket.set_option(asio::ip::udp::socket::reuse_address(true));
    _socket.bind(endpoint);

    startReceive();
}

void Server::startReceive()
{
    _socket.async_receive_from(asio::buffer(_buffer),
        _remote_endpoint,
        std::bind_front(&Server::onReceived, this));
}

void Server::onReceived(const asio::error_code& ec, std::size_t /*bytes_transferred*/)
{
    if (!ec)
    {
        processCommand();
        const auto& state = Mcu::get().state();

        auto state_data = std::make_shared<StateData>(std::array {
            static_cast<char>(state.mode),            // 0
            static_cast<char>(state.relay1_state),    // 1
            static_cast<char>(state.relay2_state),    // 2
            static_cast<char>(state.relay1_lsd),      // 3
            static_cast<char>(state.relay2_lsd),      // 4
            static_cast<char>(state.led_strip_state), // 5
            static_cast<char>(state.led_strip_lsd),   // 6
            static_cast<char>(0x01)                   // 7
        });

        _socket.async_send_to(asio::buffer(*state_data), _remote_endpoint,
            std::bind_front(&Server::onSent, this, state_data));

        startReceive();
    }
}

void Server::processCommand()
{
    switch (static_cast<MessageType>(_buffer[0]))
    {
        case MessageType::SetMode:
            Mcu::get().setMode(static_cast<Mode>(_buffer[1]));
            break;

        case MessageType::SetRelay1State:
            Mcu::get().setRelay1State(static_cast<RelayState>(_buffer[1]));
            break;

        case MessageType::SetRelay2State:
            Mcu::get().setRelay2State(static_cast<RelayState>(_buffer[1]));
            break;

        case MessageType::SetLightSensorDependencyForRelay1:
            Mcu::get().setRelay1LightSensorDependencyMode(static_cast<LightSensorDependency>(_buffer[1]));
            break;

        case MessageType::SetLightSensorDependencyForRelay2:
            Mcu::get().setRelay2LightSensorDependencyMode(static_cast<LightSensorDependency>(_buffer[1]));
            break;

        case MessageType::SetLedStripState:
            Mcu::get().setLedStripState(static_cast<LedStripState>(_buffer[1]));
            break;

        case MessageType::SetLightSensorDependencyForLedStrip:
            Mcu::get().setLedStripLightSensorDependencyMode(static_cast<LightSensorDependency>(_buffer[1]));
            break;

        case MessageType::GetState:
        default:
            break;
    }
}

void Server::onSent(std::shared_ptr<StateData> /*data*/, const asio::error_code& ec, std::size_t /*bytes_transferred*/)
{
    if (ec)
    {
        std::cout << "An error occured while sending the response: " << ec.message() << std::endl;
    }
}

} // namespace mcu
