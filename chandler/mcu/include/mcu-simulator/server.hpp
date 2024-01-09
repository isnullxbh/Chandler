/**
 * @file    server.hpp
 * @author  Oleg E. Vorobiov <isnullxbh(at)gmail.com>
 * @date    29.12.2023
 */

#pragma once

#include <array>

#include <asio/io_context.hpp>
#include <asio/ip/udp.hpp>

namespace mcu
{

class Server
{
public:
    using StateData = std::array<char, 8>;

public:
    explicit Server(asio::io_context& ioc);

    void run(const asio::ip::udp::endpoint& endpoint);

private:
    void startReceive();
    void onReceived(const asio::error_code& ec, std::size_t bytes_transferred);
    void processCommand();
    void onSent(std::shared_ptr<StateData> data, const asio::error_code& ec, std::size_t bytes_transferred);

private:
    asio::ip::udp::socket   _socket;
    std::array<char, 512>   _buffer          {};
    asio::ip::udp::endpoint _remote_endpoint {};
};

} // namespace mcu
