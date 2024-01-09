add_executable(mcu-simulator main.cpp)

target_include_directories(mcu-simulator
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/../include
        ${ASIO_INCLUDE_DIR})

target_sources(mcu-simulator
    PRIVATE
        main.cpp
        mcu-simulator/mcu.cpp
        mcu-simulator/server.cpp)
