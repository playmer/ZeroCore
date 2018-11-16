################################################################################
# Author: Joshua Shlemmer
# Copyright 2017, DigiPen Institute of Technology
################################################################################
# get our parent directory
get_filename_component(ParentDirectory ${CMAKE_CURRENT_SOURCE_DIR} DIRECTORY)

# get our current directory
set(CurrentDirectory ${CMAKE_CURRENT_LIST_DIR})

if(use_spirv_shared_library)
  set(SpirVToolsCompileOptions -DSPIRV_TOOLS_SHAREDLIB)
endif()

add_subdirectory(SpirV)

################################################################################
# CodeTranslator
################################################################################
if(${ZERO_BUILD_CodeTranslator})
    add_library(CodeTranslator "")
    set_target_properties(CodeTranslator PROPERTIES FOLDER "Extensions")
    include(CodeTranslator/CMakeLists.txt)
    target_include_directories(CodeTranslator 
        PUBLIC 
            ${CurrentDirectory}

    )

    target_link_libraries(CodeTranslator
                        PUBLIC
                        Engine
    )

    set(Zero_OptionalTarget_CodeTranslator CodeTranslator)
endif()

################################################################################
# Editor
################################################################################
if(${ZERO_BUILD_Editor})
    add_library(Editor "")
    set_target_properties(Editor         PROPERTIES FOLDER "Extensions")
    include(Editor/CMakeLists.txt)
    target_include_directories(Editor 
        PUBLIC 
            ${CurrentDirectory}/../ZeroLibraries/Zilch/Project    
            ${CurrentDirectory}/Widget
            ${CurrentDirectory}/Editor
            ${CurrentDirectory}/../Systems
            ${CurrentDirectory}/../ZeroLibraries
            ${CurrentDirectory}
    )

    target_link_libraries(Editor
                        PUBLIC
                        Common
    ) 

    set(Zero_OptionalTarget_Editor Editor)
endif()

################################################################################
# Gameplay
################################################################################
if(${ZERO_BUILD_Gameplay})
    add_library(Gameplay "")
    set_target_properties(Gameplay       PROPERTIES FOLDER "Extensions")
    include(Gameplay/CMakeLists.txt)
    target_include_directories(Gameplay
        PUBLIC 
            ${CurrentDirectory}
            Platform
            BrowserSubProcess
    )

    target_link_libraries(Gameplay
                        PUBLIC
                        Common
                        Zilch
                        Engine
                        ${CEFStatic}
    )

    set(Zero_OptionalTarget_Gameplay Gameplay)
endif()

################################################################################
# UiWidget
################################################################################
if(${ZERO_BUILD_UiWidget})
    add_library(UiWidget "")
    set_target_properties(UiWidget       PROPERTIES FOLDER "Extensions")
    include(UiWidget/CMakeLists.txt)
    target_include_directories(UiWidget 
        PUBLIC 
            ${CurrentDirectory}

    )

    target_link_libraries(UiWidget
                        PUBLIC
                        Engine
    ) 

    set(Zero_OptionalTarget_UiWidget UiWidget)
endif()

################################################################################
# Widget
################################################################################
if(${ZERO_BUILD_Widget})
    add_library(Widget "")
    set_target_properties(Widget         PROPERTIES FOLDER "Extensions")
    include(Widget/CMakeLists.txt)
    target_include_directories(Widget
        PUBLIC 
            ${CurrentDirectory}

    )
    target_link_libraries(Widget
                        PUBLIC
                        Engine
    ) 

    set(Zero_OptionalTarget_Widget Widget)
endif()

################################################################################
# ZilchShaders
################################################################################
if(${ZERO_BUILD_ZilchShaders})
    add_library(ZilchShaders "")
    set_target_properties(ZilchShaders   PROPERTIES FOLDER "Extensions")
    include(ZilchShaders/CMakeLists.txt)
    target_include_directories(ZilchShaders
        PUBLIC 
            ${CurrentDirectory}
            ${CurrentDirectory}/SpirV/SPIRV-Cross
            ${CurrentDirectory}/SpirV/SpirVFiles
            ${CurrentDirectory}/SpirV/SpirVFiles/external
            ${CurrentDirectory}/SpirV/SpirVFiles/external/SPIRV-Headers/include
            ${CurrentDirectory}/SpirV/SpirVFiles/include
            ${CurrentDirectory}/SpirV/SpirVFiles/include/spirv-tools
            ${CurrentDirectory}/SpirV/SpirVFiles/build
            ${CurrentDirectory}/SpirV/SpirVFiles/tools
            ${CurrentDirectory}/SpirV/SpirVFiles/source
    )
    target_link_libraries(ZilchShaders
                        PRIVATE
                        Common
                        Geometry
                        Zilch
                        SPIRV-Cross
                        SPIRV-Tools-opt
    ) 

    set(Zero_OptionalTarget_ZilchShaders ZilchShaders)
endif()

################################################################################
# set the output directories for all of our targets
################################################################################
zero_multitarget_output_directories(${Zero_OptionalTarget_CodeTranslator}
                      ${Zero_OptionalTarget_Editor}
                      ${Zero_OptionalTarget_Gameplay} 
                      ${Zero_OptionalTarget_UiWidget} 
                      ${Zero_OptionalTarget_Widget}
                      ${Zero_OptionalTarget_ZilchShaders}
                      LIBRARY_DIRECTORY ${zero_library_dir}
                      RUNTIME_DIRECTORY ${zero_binary_dir}
)

################################################################################
# Specify any additional target options such as pdb locations
################################################################################
if (${CMAKE_CXX_COMPILER_ID} STREQUAL MSVC OR (CMAKE_GENERATOR_TOOLSET STREQUAL "LLVM-vs2014"))
    zero_multitarget_output_settings(
        ${Zero_OptionalTarget_CodeTranslator}
        Editor
        Gameplay 
        UiWidget 
        Widget
        ZilchShaders
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
        ${Zero_OptionalTarget_CodeTranslator}
        ${Zero_OptionalTarget_Editor}
        ${Zero_OptionalTarget_Gameplay}
        ${Zero_OptionalTarget_UiWidget}
        ${Zero_OptionalTarget_Widget}
        ${Zero_OptionalTarget_ZilchShaders}
        PRIVATE 
        PUBLIC
            -GS -analyze-  -Zc:wchar_t
        PRIVATE
            -W3
            -wd"4302" 
            -wd"4305"
            -Gd
            -EHsc
            -Gm
            -GR-
            -fp:fast 
            -Zc:forScope 
            -Oy-
            -Od
            -Zc:inline
            -MDd
            -nologo
            -WX
            ${SpirVToolsCompileOptions}
            ${common_flags}
    )
else()
    zero_multitarget_compile_options(
        ${Zero_OptionalTarget_CodeTranslator}
        ${Zero_OptionalTarget_Editor}
        ${Zero_OptionalTarget_Gameplay}
        ${Zero_OptionalTarget_UiWidget}
        ${Zero_OptionalTarget_Widget}
        ${Zero_OptionalTarget_ZilchShaders}
        PRIVATE
        PUBLIC
        PRIVATE
        ${common_flags}
    )
    set_target_properties(
        ${Zero_OptionalTarget_CodeTranslator}
        ${Zero_OptionalTarget_Editor}
        ${Zero_OptionalTarget_Gameplay}
        ${Zero_OptionalTarget_UiWidget}
        ${Zero_OptionalTarget_Widget}
        ${Zero_OptionalTarget_ZilchShaders}
        PROPERTIES
        LINK_FLAGS ${common_linker_flags}
    )
endif()

################################################################################
# Set linker flags
################################################################################
if (${CMAKE_CXX_COMPILER_ID} STREQUAL MSVC OR (CMAKE_GENERATOR_TOOLSET STREQUAL "LLVM-vs2014"))
    # set the correct subsystems for executable targets, and set stack size for the editor
    set_target_properties(
        ${Zero_OptionalTarget_CodeTranslator}
        ${Zero_OptionalTarget_Editor}
        ${Zero_OptionalTarget_Gameplay}
        ${Zero_OptionalTarget_UiWidget}
        ${Zero_OptionalTarget_Widget}
        ${Zero_OptionalTarget_ZilchShaders}
        PROPERTIES 
        STATIC_LIBRARY_FLAGS "${common_library_flags}"
        STATIC_LIBRARY_FLAGS_RELEASE "/LTCG"
    )
endif()

################################################################################
# Group source into folders
################################################################################
# We require the ifs here due to adding in the precompiled header in a 
# multitarget function, we can't place this source group earlier due to that.
if(${ZERO_BUILD_CodeTranslator})
    zero_subfolder_source_group(${zero_core_path} Extensions CodeTranslator "")
endif()

if(${ZERO_BUILD_Editor})
    zero_subfolder_source_group(${zero_core_path} Extensions Editor "")
endif()

if(${ZERO_BUILD_Gameplay})
    zero_subfolder_source_group(${zero_core_path} Extensions Gameplay "")
endif()

if(${ZERO_BUILD_UiWidget})
    zero_subfolder_source_group(${zero_core_path} Extensions UiWidget "")
endif()

if(${ZERO_BUILD_Widget})
    zero_subfolder_source_group(${zero_core_path} Extensions Widget "")
endif()

if(${ZERO_BUILD_ZilchShaders})
    zero_subfolder_source_group(${zero_core_path} Extensions ZilchShaders "")
endif()

