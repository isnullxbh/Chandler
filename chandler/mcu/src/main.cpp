/**
 * @file    main.cpp
 * @author  Oleg E. Vorobiov <isnullxbh(at)gmail.com>
 * @date    29.12.2023
 */

#include <iostream>
#include <asio/io_context.hpp>
#include <mcu-simulator/server.hpp>

auto main(int argc, char** argv) -> int
{
    if (argc < 3)
    {
        std::cerr << "Arguments not specified: ./mcu-simulator <host> <port>" << std::endl;
        return EXIT_FAILURE;
    }

    try
    {
        const auto endpoint =
            asio::ip::udp::endpoint { asio::ip::address::from_string(argv[1]),
                                      static_cast<asio::ip::port_type>(std::stoul(argv[2])) };

        asio::io_context context {};
        mcu::Server server { context };
        server.run(endpoint);
        context.run();
    }
    catch (const std::exception& ex)
    {
        std::cerr << "An error occurred: " << ex.what() << std::endl;
        return EXIT_FAILURE;
    }

    return EXIT_SUCCESS;
}
