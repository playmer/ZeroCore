################################################################################
# Generated using Joshua T. Fisher's 'CMake Builder'.
# Link: https://github.com/playmer/CmakeBuilder 
################################################################################
add_library(ZilchScript "")

set_target_properties(ZilchScript PROPERTIES FOLDER "Systems")

target_sources(ZilchScript
  PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}/Precompiled.cpp
    ${CMAKE_CURRENT_LIST_DIR}/Precompiled.hpp
    ${CMAKE_CURRENT_LIST_DIR}/ZilchPlugin.cpp
    ${CMAKE_CURRENT_LIST_DIR}/ZilchPlugin.hpp
    ${CMAKE_CURRENT_LIST_DIR}/ZilchScript.cpp
    ${CMAKE_CURRENT_LIST_DIR}/ZilchScript.hpp
    ${CMAKE_CURRENT_LIST_DIR}/ZilchScriptStandard.cpp
    ${CMAKE_CURRENT_LIST_DIR}/ZilchScriptStandard.hpp
    ${CMAKE_CURRENT_LIST_DIR}/ZilchZero.cpp
    ${CMAKE_CURRENT_LIST_DIR}/ZilchZero.hpp
)

target_include_directories(ZilchScript 
PUBLIC 
    ${CMAKE_CURRENT_LIST_DIR}/../
)

target_link_libraries(ZilchScript
    PUBLIC
    Common
    Geometry
    Editor
) 

zero_multitarget_output_settings(
    ZilchScript
    CONFIGS ${supported_configs}
    BASEPATH ${zero_build_out}
    PLATFORM ${platform}
    CONFIG ${configuration}
    BITS ${bit}
    TOOLSET ${CMAKE_VS_PLATFORM_TOOLSET}
    PRECOMPILED_HEADER_NAME "Precompiled.hpp"
    PRECOMPILED_SOURCE_NAME "Precompiled.cpp"
    TARGET_SUBFOLDER
)

zero_source_group(${CMAKE_CURRENT_LIST_DIR} ZilchScript "")