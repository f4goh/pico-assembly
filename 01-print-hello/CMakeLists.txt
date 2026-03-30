cmake_minimum_required(VERSION 3.13)

# Import du SDK Pico
include(pico_sdk_import.cmake)

project(hello_asm C CXX ASM)

# Initialisation du SDK
pico_sdk_init()

# Ton programme assembleur
add_executable(hello_asm main.S)

# Lier avec la librairie standard (printf, stdio, etc.)
target_link_libraries(hello_asm
    pico_stdlib
)

# Activer sortie UART (important pour printf)
#pico_enable_stdio_uart(hello_asm 1)
#pico_enable_stdio_usb(hello_asm 0)

# Générer le .uf2
pico_add_extra_outputs(hello_asm)



