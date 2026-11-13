cmake_minimum_required(VERSION 3.16)

project(hackrf_tools LANGUAGES C)

find_package(PkgConfig REQUIRED)

set(TOOLS_BIN_DIR "${CMAKE_CURRENT_SOURCE_DIR}/bin")
set(TOOLS hackrf_spiflash)

pkg_check_modules(DEPENDANCIES REQUIRED IMPORTED_TARGET
    libhackrf
)

foreach(tool_name ${TOOLS})

    add_executable(${tool_name} "${tool_name}.c")
    target_link_libraries(${tool_name} PRIVATE PkgConfig::DEPENDANCIES)
    install(TARGETS ${tools_name} RUNTIME DESTINATION ${TOOLS_BIN_DIR})

endforeach(tool_name)