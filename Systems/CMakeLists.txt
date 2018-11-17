################################################################################
# Author: Joshua Shlemmer
# Copyright 2017, DigiPen Institute of Technology
################################################################################
# get our current directory
set(CurrentDirectory ${CMAKE_CURRENT_LIST_DIR})

if(NOT ${ZERO_BUILD_Content} AND
   NOT ${ZERO_BUILD_Engine} AND
   NOT ${ZERO_BUILD_Graphics} AND
   NOT ${ZERO_BUILD_Networking} AND
   NOT ${ZERO_BUILD_Physics} AND
   NOT ${ZERO_BUILD_Sound} AND
   NOT ${ZERO_BUILD_Startup} AND
   NOT ${ZERO_BUILD_ZilchScript})
   set(ZERO_NO_SYSTEMS ON)
endif()


################################################################################
# Content
################################################################################
if(${ZERO_BUILD_Content})
    add_library(Content "")

    set_target_properties(Content PROPERTIES FOLDER "Systems")

    include(Content/CMakeLists.txt)

    target_include_directories(Content 
        PUBLIC 
            ${CurrentDirectory}/Content
            ${CurrentDirectory}
    )

    target_link_libraries(Content
        PUBLIC
        Common
        Zilch
        ${AssimpStatic}
        ${NvttStatic}
        ${OpusStatic}
    )

    set(Zero_OptionalTarget_Content Content)
endif()

################################################################################
# Content
################################################################################
if(${ZERO_BUILD_Content})
    add_library(Engine "")
    
    set_target_properties(Engine PROPERTIES FOLDER "Systems")

    include(Engine/CMakeLists.txt)

    target_include_directories(Engine 
        PUBLIC 
            ${CurrentDirectory}/Engine
            ${CurrentDirectory}
    )
    
    target_link_libraries(Engine
        PUBLIC
        Common
        Geometry
        Zilch
    )  
    
    add_custom_command(
        TARGET Engine PRE_BUILD    
        COMMAND ${CMAKE_COMMAND} 
        # options
        -DZERO_CORE_ROOT="${zero_core_path}"
        # command
        -P ${cmake_utilities_dir}/Update_Build_Version_Script.cmake
    )
    
    set(Zero_OptionalTarget_Engine Engine)
endif()
################################################################################
# Graphics
################################################################################
if(${ZERO_BUILD_Graphics})
    add_library(Graphics "")

    set_target_properties(Graphics PROPERTIES FOLDER "Systems")

    include(Graphics/CMakeLists.txt)

    target_include_directories(Graphics
        PUBLIC 
            ${CurrentDirectory}
    )
    
    target_link_libraries(Graphics
        PUBLIC
        Common
        Geometry
        ZilchShaders
        ${FreetypeStatic}
    ) 

    set(Zero_OptionalTarget_Graphics Graphics)
endif()
################################################################################
# Networking
################################################################################
if(${ZERO_BUILD_Networking})
    add_library(Networking "")

    set_target_properties(Networking PROPERTIES FOLDER "Systems")

    include(Networking/CMakeLists.txt)

    target_include_directories(Networking 
        PUBLIC 
            ${CurrentDirectory}/Networking
            ${CurrentDirectory}
    )

    target_link_libraries(Networking
        PUBLIC
        Common
        Geometry
    ) 

    set(Zero_OptionalTarget_Networking Networking)
endif()
################################################################################
# Physics
################################################################################
if(${ZERO_BUILD_Physics})
    add_library(Physics "")

    set_target_properties(Physics PROPERTIES FOLDER "Systems")

    include(Physics/CMakeLists.txt)

    target_include_directories(Physics 
    PUBLIC 
        ${CurrentDirectory}
    )

    target_link_libraries(Physics
        PUBLIC
        Zilch
    ) 

    set(Zero_OptionalTarget_Physics Physics)
endif()
################################################################################
# Sound
################################################################################
if(${ZERO_BUILD_Sound})
    add_library(Sound "")

    set_target_properties(Sound PROPERTIES FOLDER "Systems")

    include(Sound/CMakeLists.txt)

    target_include_directories(Sound 
    PUBLIC 
        ${CurrentDirectory}
    )

    target_link_libraries(Sound
        PUBLIC
        Common
        Geometry
        ${OpusStatic}
    ) 

    set(Zero_OptionalTarget_Sound Sound)
endif()
################################################################################
# Startup
################################################################################
if(${ZERO_BUILD_Startup})
    add_library(Startup "")

    set_target_properties(Startup PROPERTIES FOLDER "Systems")

    include(Startup/CMakeLists.txt)

    target_include_directories(Startup 
    PUBLIC 
        ${CurrentDirectory}
    )

    target_link_libraries(Startup
        PUBLIC
        Common
        Geometry
        Graphics
    ) 

    set(Zero_OptionalTarget_Startup Startup)
endif()
################################################################################
# ZilchScript
################################################################################
if(${ZERO_BUILD_ZilchScript})
    add_library(ZilchScript "")

    set_target_properties(ZilchScript PROPERTIES FOLDER "Systems")

    include(ZilchScript/CMakeLists.txt)

    target_include_directories(ZilchScript 
    PUBLIC 
        ${CurrentDirectory}
    )

    target_link_libraries(ZilchScript
        PUBLIC
        Common
        Geometry
        Editor
    ) 

    set(Zero_OptionalTarget_ZilchScript ZilchScript)
endif()

if(${ZERO_NO_SYSTEMS})
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

################################################################################
# Group source into folders
################################################################################
if(${ZERO_BUILD_Content})
    zero_subfolder_source_group(${zero_core_path} Extensions Content "")
endif()

if(${ZERO_BUILD_Engine})
    zero_subfolder_source_group(${zero_core_path} Extensions Engine "")
endif()

if(${ZERO_BUILD_Graphics})
    zero_subfolder_source_group(${zero_core_path} Extensions Graphics "")
endif()

if(${ZERO_BUILD_Networking})
    zero_subfolder_source_group(${zero_core_path} Extensions Networking "")
endif()

if(${ZERO_BUILD_Physics})
    zero_subfolder_source_group(${zero_core_path} Extensions Physics "")
endif()

if(${ZERO_BUILD_Sound})
    zero_subfolder_source_group(${zero_core_path} Extensions Sound "")
endif()

if(${ZERO_BUILD_Startup})
    zero_subfolder_source_group(${zero_core_path} Extensions Startup "")
endif()

if(${ZERO_BUILD_ZilchScript})
    zero_subfolder_source_group(${zero_core_path} Extensions ZilchScript "")
endif()
