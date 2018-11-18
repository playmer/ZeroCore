################################################################################
# Author: Joshua Shlemmer
# Copyright 2017, DigiPen Institute of Technology
################################################################################

if(NOT ${ZERO_BUILD_Content} AND
   NOT ${ZERO_BUILD_Engine} AND
   NOT ${ZERO_BUILD_Graphics} AND
   NOT ${ZERO_BUILD_Networking} AND
   NOT ${ZERO_BUILD_Physics} AND
   NOT ${ZERO_BUILD_Sound} AND
   NOT ${ZERO_BUILD_Startup} AND
   NOT ${ZERO_BUILD_ZilchScript})
   set(ZERO_NO_SYSTEMS ON)
else()
    set(ZERO_NO_SYSTEMS OFF)
endif()



################################################################################
# Content
################################################################################
if(${ZERO_BUILD_Content})
    add_subdirectory(Content)

    set(Zero_OptionalTarget_Content Content)
endif()

################################################################################
# Engine
################################################################################
if(${ZERO_BUILD_Engine})
    
    add_subdirectory(Engine)
    
    set(Zero_OptionalTarget_Engine Engine)
endif()

################################################################################
# Graphics
################################################################################
if(${ZERO_BUILD_Graphics})
    add_subdirectory(Graphics)

    set(Zero_OptionalTarget_Graphics Graphics)
endif()

################################################################################
# Networking
################################################################################
if(${ZERO_BUILD_Networking})
    add_subdirectory(Networking)

    set(Zero_OptionalTarget_Networking Networking)
endif()

################################################################################
# Physics
################################################################################
if(${ZERO_BUILD_Physics})
    add_subdirectory(Physics)

    set(Zero_OptionalTarget_Physics Physics)
endif()

################################################################################
# Sound
################################################################################
if(${ZERO_BUILD_Sound})
    add_subdirectory(Sound)

    set(Zero_OptionalTarget_Sound Sound)
endif()

################################################################################
# Startup
################################################################################
if(${ZERO_BUILD_Startup})
    add_subdirectory(Startup)

    set(Zero_OptionalTarget_Startup Startup)
endif()

################################################################################
# ZilchScript
################################################################################
if(${ZERO_BUILD_ZilchScript})
    add_subdirectory(ZilchScript)

    set(Zero_OptionalTarget_ZilchScript ZilchScript)
endif()

if(NOT ${ZERO_NO_SYSTEMS})
    ################################################################################
    # set the output directories for all of our targets
    ################################################################################
    zero_multitarget_output_directories(
        ${Zero_OptionalTarget_Content}
        ${Zero_OptionalTarget_Engine}
        ${Zero_OptionalTarget_Graphics}
        ${Zero_OptionalTarget_Networking}
        ${Zero_OptionalTarget_Physics}
        ${Zero_OptionalTarget_Sound}
        ${Zero_OptionalTarget_Startup}
        ${Zero_OptionalTarget_ZilchScript}
        LIBRARY_DIRECTORY ${zero_library_dir}
        RUNTIME_DIRECTORY ${zero_binary_dir}
    )
    ################################################################################
    # Specify any additional target options such as pdb locations
    ################################################################################

    if (${CMAKE_CXX_COMPILER_ID} STREQUAL MSVC OR (CMAKE_GENERATOR_TOOLSET STREQUAL "LLVM-vs2014"))
        zero_multitarget_output_settings(
            ${Zero_OptionalTarget_Content}
            ${Zero_OptionalTarget_Engine}
            ${Zero_OptionalTarget_Graphics}
            ${Zero_OptionalTarget_Physics}
            ${Zero_OptionalTarget_Sound}
            ${Zero_OptionalTarget_Startup}
            ${Zero_OptionalTarget_ZilchScript}
            ${Zero_OptionalTarget_Networking}
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
    endif()

    ################################################################################
    # set flags and definitions
    ################################################################################
    if (${CMAKE_CXX_COMPILER_ID} STREQUAL MSVC OR (CMAKE_GENERATOR_TOOLSET STREQUAL "LLVM-vs2014"))

        zero_multitarget_compile_options( 
            ${Zero_OptionalTarget_Content}
            ${Zero_OptionalTarget_Engine}
            ${Zero_OptionalTarget_Graphics}
            ${Zero_OptionalTarget_Networking}
            ${Zero_OptionalTarget_Physics}
            ${Zero_OptionalTarget_Sound}
            ${Zero_OptionalTarget_Startup}
            ${Zero_OptionalTarget_ZilchScript}

            PUBLIC
            -wd"4305"

            PRIVATE
            ${common_flags}
            "-D \"CURL_STATICLIB\"" 
            "-D \"WIN32\"" 
            "-D \"_CRT_SECURE_NO_WARNINGS\"" 
            "-D \"ZeroExportDll\"" 
            
        )

        zero_multitarget_compile_options( 
            PUBLIC
            PRIVATE
            "-D \"_UNICODE\"" 
            "-D \"UNICODE\""
        )
        #common_library_flags
        set_target_properties(
            ${Zero_OptionalTarget_Content}
            ${Zero_OptionalTarget_Engine}
            ${Zero_OptionalTarget_Graphics}
            ${Zero_OptionalTarget_Networking}
            ${Zero_OptionalTarget_Physics}
            ${Zero_OptionalTarget_Sound}
            ${Zero_OptionalTarget_Startup}
            PROPERTIES
            STATIC_LIBRARY_FLAGS ${common_library_flags}
            STATIC_LIBRARY_FLAGS_RELEASE "/LTCG"
        )
    else()
        zero_multitarget_compile_options(
            ${Zero_OptionalTarget_Content}
            ${Zero_OptionalTarget_Engine}
            ${Zero_OptionalTarget_Graphics}
            ${Zero_OptionalTarget_Networking}
            ${Zero_OptionalTarget_Physics}
            ${Zero_OptionalTarget_Sound}
            ${Zero_OptionalTarget_Startup}
            ${Zero_OptionalTarget_ZilchScript}
            PRIVATE
            PUBLIC
            PRIVATE
            ${common_flags}
        )
        set_target_properties(
            ${Zero_OptionalTarget_Content}
            ${Zero_OptionalTarget_Engine}
            ${Zero_OptionalTarget_Graphics}
            ${Zero_OptionalTarget_Networking}
            ${Zero_OptionalTarget_Physics}
            ${Zero_OptionalTarget_Sound}
            ${Zero_OptionalTarget_Startup}
            ${Zero_OptionalTarget_ZilchScript}
            PROPERTIES
            LINK_FLAGS "${common_linker_flags}"
        )
    endif()
endif()
