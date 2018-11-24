################################################################################
# Author: Joshua Shlemmer
# Copyright 2017, DigiPen Institute of Technology
################################################################################
if(use_spirv_shared_library)
  set(SpirVToolsCompileOptions -DSPIRV_TOOLS_SHAREDLIB)
endif()

add_subdirectory(SpirV)

if (NOT ${ZERO_BUILD_CodeTranslator} AND
    NOT ${ZERO_BUILD_Editor} AND
    NOT ${ZERO_BUILD_Gameplay} AND
    NOT ${ZERO_BUILD_UiWidget} AND
    NOT ${ZERO_BUILD_Widget} AND
    NOT ${ZERO_BUILD_ZilchShaders})
    set(ZERO_NO_EXTENSIONS ON)
else()
    set(ZERO_NO_EXTENSIONS OFF)
endif()

################################################################################
# CodeTranslator
################################################################################
if(${ZERO_BUILD_CodeTranslator})
    add_subdirectory(CodeTranslator)

    set(Zero_OptionalTarget_CodeTranslator CodeTranslator)
endif()

################################################################################
# Editor
################################################################################
if(${ZERO_BUILD_Editor})
    add_subdirectory(Editor)

    set(Zero_OptionalTarget_Editor Editor)
endif()

################################################################################
# Gameplay
################################################################################
if(${ZERO_BUILD_Gameplay})
    add_subdirectory(Gameplay)

    set(Zero_OptionalTarget_Gameplay Gameplay)
endif()

################################################################################
# UiWidget
################################################################################
if(${ZERO_BUILD_UiWidget})
    add_subdirectory(UiWidget)

    set(Zero_OptionalTarget_UiWidget UiWidget)
endif()

################################################################################
# Widget
################################################################################
if(${ZERO_BUILD_Widget})
    add_subdirectory(Widget)

    set(Zero_OptionalTarget_Widget Widget)
endif()

################################################################################
# ZilchShaders
################################################################################
if(${ZERO_BUILD_ZilchShaders})
    add_subdirectory(ZilchShaders)
    
    set(Zero_OptionalTarget_ZilchShaders ZilchShaders)
endif()


# We might have no extensions on, so don't try setting any of this.
if (NOT ${ZERO_NO_EXTENSIONS})
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
endif()


