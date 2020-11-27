cmake_minimum_required(VERSION 3.14)

set(XMOS_TOOLS_PATH $ENV{XMOS_TOOL_PATH}/bin)
set(APP_NAME "app_vfe_freertos")

# **********************
# Setup XMOS toolchain
# **********************
if(NOT DEFINED ENV{VOICE_FRONT_END_PATH})
    message(FATAL_ERROR "VOICE_FRONT_END_PATH environment variable not defined")
    # some more commands
endif()
include("$ENV{VOICE_FRONT_END_PATH}/cmake_utils/xmos_toolchain.cmake")

#**********************
# Project
#**********************
# Disable in-source build.
if("${CMAKE_SOURCE_DIR}" STREQUAL "${CMAKE_BINARY_DIR}")
    message(FATAL_ERROR "In-source build is not allowed! Please specify a build folder.\n\tex:cmake -B build")
endif()


## Define project
project(${APP_NAME} VERSION 0.1.0)

## Enable languages for project
enable_language(CXX XC C ASM)

#**********************
# Build flags
#**********************
add_executable(${APP_NAME})


set(APP_COMPILER_FLAGS
        "-D__XS2A__"
        "-Os"
        "-g"
        "-report"
        "-fxscope"
        "-mcmodel=small"
        "${CMAKE_CURRENT_SOURCE_DIR}/src/config.xscope"
        "-target=XCORE-AI-EXPLORER"
        "-D__suppression_conf_h_exists__=1"
        )

set(APP_SRCS
        ./src/main.xc
        ./src/test.c
        ./src/IntQueueTimer/IntQueueTimer.c
        ./src/partest/partest.c
        ./src/regtest/regtest.c
        ./src/main.xc
        ./src/partest/mab_led_driver.xc
        ./src/regtest/prvRegisterCheck_asm1.S
        ./src/regtest/prvRegisterCheck_asm2.S
        )

set(APP_INCLUDES
        "src"
        "api"
        "src/IntQueueTimer"
    )

include("$ENV{VOICE_FRONT_END_PATH}/cmake_utils/vfe.cmake")
include("../freertos.cmake")

set_target_properties(${APP_NAME} PROPERTIES OUTPUT_NAME "${APP_NAME}.xe")

target_compile_options(${APP_NAME} PRIVATE ${APP_COMPILER_FLAGS})

target_include_directories(${APP_NAME}
  PRIVATE ${APP_INCLUDES}
  # PRIVATE ${VFE_INCLUDES_ALL}
  PRIVATE ${FREERTOS_INCLUDES_ALL}
)

target_sources(${APP_NAME}
    PRIVATE ${APP_SRCS}
    # PRIVATE ${VFE_SRCS_ALL}
    PRIVATE ${FREERTOS_SRCS}
    )

target_link_options(${APP_NAME} PRIVATE ${APP_COMPILER_FLAGS})


## Set any additional flags only for C++
set(CMAKE_CXX_FLAGS  "-std=c++11")

## Register the application
#XMOS_REGISTER_APP()
