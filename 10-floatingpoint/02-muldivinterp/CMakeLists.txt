cmake_minimum_required(VERSION 3.13)

set(PICO_BOARD pico2 CACHE STRING "Board type")

include(pico_sdk_import.cmake)
project(muldivinterp C CXX ASM)

set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)

pico_sdk_init()

include_directories(${CMAKE_SOURCE_DIR})

add_executable(muldivinterp
  snippets.S
)

pico_enable_stdio_uart(muldivinterp 1)
pico_enable_stdio_usb(muldivinterp 0)

pico_add_extra_outputs(muldivinterp)

target_link_libraries(muldivinterp pico_stdlib)
