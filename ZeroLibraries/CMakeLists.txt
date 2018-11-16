################################################################################
# Author: Joshua Shlemmer
# Copyright 2017, DigiPen Institute of Technology
################################################################################
# get our parent directory
get_filename_component(ParentDirectory ${CMAKE_CURRENT_SOURCE_DIR} DIRECTORY)

# get our current directory
set(CurrentDirectory ${CMAKE_CURRENT_LIST_DIR})

if (NOT ${ZERO_BUILD_Common} AND
    NOT ${ZERO_BUILD_Dash} AND
    NOT ${ZERO_BUILD_Geometry} AND
    NOT ${ZERO_BUILD_Meta} AND
    NOT ${ZERO_BUILD_Platform} AND
    NOT ${ZERO_BUILD_Serialization} AND
    NOT ${ZERO_BUILD_SpatialPartition} AND
    NOT ${ZERO_BUILD_Support} AND
    NOT ${ZERO_BUILD_Zilch})
    set(ZERO_NO_CORE_LIBRARIES ON)
endif()

################################################################################
# Common
################################################################################
if (${ZERO_BUILD_Common})
    add_library(Common "") 

    set_target_properties(Common PROPERTIES FOLDER "ZeroLibraries")

    include(Common/CMakeLists.txt)

    target_include_directories(Common
        PUBLIC 
            ${CurrentDirectory}/Common
            ${CurrentDirectory}
    )
    
    set(Zero_OptionalTarget_Common Common)
endif()

################################################################################
# Platform
################################################################################
# platform is going to define its own target
if (${ZERO_BUILD_Platform})
    add_subdirectory(Platform)
endif()

################################################################################
# Dash
################################################################################
if (${ZERO_BUILD_Dash})
    add_library(Dash "")

    set_target_properties(Dash PROPERTIES FOLDER "ZeroLibraries")

    include(Dash/CMakeLists.txt)

    target_include_directories(Dash
    PUBLIC
        ${CurrentDirectory}/Dash 
        ${CurrentDirectory}
    )

    target_link_libraries(Dash
                        PUBLIC
                        Common
                        Zilch                      
                        Geometry
    ) 
    
    set(Zero_OptionalTarget_Dash Dash)
endif()

################################################################################
# Geometry
################################################################################
if (${ZERO_BUILD_Geometry})
    add_library(Geometry "")

    set_target_properties(Geometry PROPERTIES FOLDER "ZeroLibraries")

    include(Geometry/CMakeLists.txt)

    target_include_directories(Geometry
    PUBLIC
        ${CurrentDirectory}/Geometry 
        ${CurrentDirectory}
    )

    target_link_libraries(Geometry
                        PUBLIC
                        Common
                        Zilch
    ) 
    
    set(Zero_OptionalTarget_Geometry Geometry)
endif()

################################################################################
# Zilch
################################################################################
if (${ZERO_BUILD_Zilch})
    add_library(Zilch "")

    set_target_properties(Zilch PROPERTIES FOLDER "ZeroLibraries")

    include(Zilch/CMakeLists.txt)

    target_include_directories(Zilch
    PUBLIC
        ${CurrentDirectory}/Zilch/Project
        ${CurrentDirectory}/Zilch/Project/Zilch
        ${VLD_INCLUDE_DIRS}
        ${CurrentDirectory}
    )

    target_link_libraries(Zilch
                        PUBLIC
                        Common
                        ${VLD_LIBRARIES}
    )
    
    set(Zero_OptionalTarget_Zilch Zilch)
endif()

################################################################################
# Meta
################################################################################
if (${ZERO_BUILD_Meta})
    add_library(Meta "")

    set_target_properties(Meta PROPERTIES FOLDER "ZeroLibraries")

    include(Meta/CMakeLists.txt)

    target_include_directories(Meta
    PUBLIC
        ${CurrentDirectory}/Meta 
        ${CurrentDirectory}
    )

    target_link_libraries(Meta
                        PUBLIC
                        Zilch
    )
    
    set(Zero_OptionalTarget_Meta Meta)
endif()

################################################################################
# Serialization
################################################################################
if (${ZERO_BUILD_Serialization})
    add_library(Serialization "")

    set_target_properties(Serialization PROPERTIES FOLDER "ZeroLibraries")

    include(Serialization/CMakeLists.txt)

    target_include_directories(Serialization
    PUBLIC
        ${CurrentDirectory}/Serialization 
        ${CurrentDirectory}
    )

    target_link_libraries(Serialization
                        PUBLIC
                        Common
                        Geometry
    )
    
    set(Zero_OptionalTarget_Serialization Serialization)
endif()


################################################################################
# SpatialPartition
################################################################################
if (${ZERO_BUILD_Common})
    add_library(SpatialPartition  "")

    set_target_properties(SpatialPartition PROPERTIES FOLDER "ZeroLibraries")

    include(SpatialPartition/CMakeLists.txt)

    target_include_directories(SpatialPartition
    PUBLIC
        ${CurrentDirectory}/SpatialPartition 
        ${CurrentDirectory}
    )

    target_link_libraries(SpatialPartition
                        PUBLIC
                        Zilch
    )
    
    set(Zero_OptionalTarget_SpatialPartition SpatialPartition)
endif()


################################################################################
# Support
################################################################################
if (${ZERO_BUILD_Support})
    add_library(Support "")

    set_target_properties(Support PROPERTIES FOLDER "ZeroLibraries")

    include(Support/CMakeLists.txt)

    target_include_directories(Support
    PUBLIC
        ${CurrentDirectory}/Support
        ${CurrentDirectory}
    )

    target_link_libraries(Support
                        PUBLIC
                        Common
                        ${ZLibStatic}
                        ${LibpngStatic}
    )
    
    set(Zero_OptionalTarget_Support Support)
endif()

if (${ZERO_NO_CORE_LIBRARIES})
    ################################################################################
    # set the output directories for all of our targets
    ################################################################################
    zero_multitarget_output_directories(
        ${Zero_OptionalTarget_Common}
        ${Zero_OptionalTarget_Dash}
        ${Zero_OptionalTarget_Geometry}
        ${Zero_OptionalTarget_Meta}
        ${Zero_OptionalTarget_Serialization}
        ${Zero_OptionalTarget_SpatialPartition}
        ${Zero_OptionalTarget_Support}
        ${Zero_OptionalTarget_Zilch}
        LIBRARY_DIRECTORY ${zero_library_dir}
        RUNTIME_DIRECTORY ${zero_binary_dir}
    )

    ################################################################################
    # Specify any additional target options such as pdb locations
    ################################################################################

    if (${CMAKE_CXX_COMPILER_ID} STREQUAL MSVC OR (CMAKE_GENERATOR_TOOLSET STREQUAL "LLVM-vs2014"))
        zero_multitarget_output_settings(
            ${Zero_OptionalTarget_Common}
            ${Zero_OptionalTarget_Dash}
            ${Zero_OptionalTarget_Geometry}
            ${Zero_OptionalTarget_Meta}
            ${Zero_OptionalTarget_Serialization}
            ${Zero_OptionalTarget_SpatialPartition}
            ${Zero_OptionalTarget_Support}
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
        
        if (${ZERO_BUILD_Zilch})
            zero_multitarget_output_settings(
                Zilch 
                CONFIGS ${supported_configs}
                BASEPATH ${zero_build_out}
                PLATFORM ${platform}
                CONFIG ${configuration}
                BITS ${bit}
                TOOLSET ${CMAKE_VS_PLATFORM_TOOLSET}
                PRECOMPILED_HEADER_NAME "Zilch.hpp"
                PRECOMPILED_SOURCE_NAME "Zilch.cpp"
                TARGET_SUBFOLDER "Zilch/Project"
            )
        endif()
    endif()

    ################################################################################
    # set flags and definitions
    ################################################################################
    if (${CMAKE_CXX_COMPILER_ID} STREQUAL MSVC OR (CMAKE_GENERATOR_TOOLSET STREQUAL "LLVM-vs2014"))
        zero_multitarget_compile_options(  
            ${Zero_OptionalTarget_Common} 
            ${Zero_OptionalTarget_Dash} 
            ${Zero_OptionalTarget_Geometry}
            ${Zero_OptionalTarget_Meta} 
            ${Zero_OptionalTarget_Serialization}
            ${Zero_OptionalTarget_SpatialPartition}
            ${Zero_OptionalTarget_Support}
            
            PRIVATE
            
            PUBLIC
                -GS -analyze-  -Zc:wchar_t
                
            PRIVATE
                -W3 -wd"4302"
                ${common_flags}
        )
        if (CMAKE_GENERATOR_TOOLSET STREQUAL "LLVM-vs2014")
            zero_multitarget_compile_options(  
                Zilch 
                PRIVATE

                PUBLIC
                    -GS -analyze-  -Zc:wchar_t

                PRIVATE
                $<$<CONFIG:Debug>:-GS>
                $<$<CONFIG:Release>:-GS->
                $<$<CONFIG:Release>:-GL>
                -analyze-
                -W3 
                -wd"4302"
                -Zc:wchar_t
                $<$<CONFIG:Debug>:-Od>
                $<$<CONFIG:Release>:-O2>
                -Zc:inline 
                -fp:fast 
                -errorReport:prompt 
                -WX 
                -Zc:forScope 
                -GR- 
                -Gd
                $<$<CONFIG:Release>:-arch:SSE2>
                -Oy-
                $<$<CONFIG:Debug>:-MDd>
                $<$<CONFIG:Release>:-Oi>
                $<$<CONFIG:Release>:-MT>
                -EHsc 
                -nologo
                -DDEBUG  
                "-D \"_CRT_SECURE_NO_WARNINGS\"" 
                "-Wno-unused-command-line-argument"
                "-Wno-undefined-inline"
                -FIZilch.hpp
            )
        else()
            zero_multitarget_compile_options(  
                Zilch 
                PRIVATE
                
                PUBLIC
                    -GS -analyze-  -Zc:wchar_t
                    
                PRIVATE
                    -W3 -wd"4302"
                    ${common_flags}
            )
        endif()
    else()
        zero_multitarget_compile_options(
            ${Zero_OptionalTarget_Common} 
            ${Zero_OptionalTarget_Dash} 
            ${Zero_OptionalTarget_Geometry}
            ${Zero_OptionalTarget_Meta} 
            ${Zero_OptionalTarget_Serialization}
            ${Zero_OptionalTarget_SpatialPartition}
            ${Zero_OptionalTarget_Support}
            ${Zero_OptionalTarget_Zilch}
            PRIVATE
            PUBLIC
            PRIVATE
            ${common_flags}
        )
        set_target_properties(
            ${Zero_OptionalTarget_Common}
            ${Zero_OptionalTarget_Dash}
            ${Zero_OptionalTarget_Geometry}
            ${Zero_OptionalTarget_Meta}
            ${Zero_OptionalTarget_Serialization}
            ${Zero_OptionalTarget_SpatialPartition}
            ${Zero_OptionalTarget_Support}
            ${Zero_OptionalTarget_Zilch}
            PROPERTIES
            LINK_FLAGS "${common_linker_flags}"
        )
    endif()

    ################################################################################
    # Set linker flags
    ################################################################################
    if (${CMAKE_CXX_COMPILER_ID} STREQUAL MSVC OR (CMAKE_GENERATOR_TOOLSET STREQUAL "LLVM-vs2014"))
        # set the correct subsystems for executable targets, and set stack size for the editor
        set_target_properties(
            ${Zero_OptionalTarget_Common}
            ${Zero_OptionalTarget_Dash}
            ${Zero_OptionalTarget_Geometry}
            ${Zero_OptionalTarget_Meta}
            ${Zero_OptionalTarget_Serialization}
            ${Zero_OptionalTarget_SpatialPartition}
            ${Zero_OptionalTarget_Support}
            ${Zero_OptionalTarget_Zilch}
            PROPERTIES 
            STATIC_LIBRARY_FLAGS "${common_library_flags}"
            STATIC_LIBRARY_FLAGS_RELEASE "/LTCG"
        )
    endif()
endif()

################################################################################
# Group source into folders
################################################################################
if(${ZERO_BUILD_Common})
    zero_subfolder_source_group(${zero_core_path} ZeroLibraries Common "")
endif()

if(${ZERO_BUILD_Dash})
    zero_subfolder_source_group(${zero_core_path} ZeroLibraries Dash "")
endif()

if(${ZERO_BUILD_Geometry})
    zero_subfolder_source_group(${zero_core_path} ZeroLibraries Geometry "")
endif()

if(${ZERO_BUILD_Meta})
    zero_subfolder_source_group(${zero_core_path} ZeroLibraries Meta "")
endif()

if(${ZERO_BUILD_Serialization})
    zero_subfolder_source_group(${zero_core_path} ZeroLibraries Serialization "")
endif()

if(${ZERO_BUILD_SpatialPartition})
    zero_subfolder_source_group(${zero_core_path} ZeroLibraries SpatialPartition "")
endif()

if(${ZERO_BUILD_Support})
    zero_subfolder_source_group(${zero_core_path} ZeroLibraries Support "")
endif()
    
if(${ZERO_BUILD_Zilch})
    zero_subfolder_source_group(${zero_core_path} ZeroLibraries Zilch "")
endif()
