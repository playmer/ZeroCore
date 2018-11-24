################################################################################
# Author: Joshua Shlemmer
# Copyright 2017, DigiPen Institute of Technology
################################################################################

################################################################################
# ZeroEditor
################################################################################
if(${ZERO_BUILD_ZeroEditor})
    add_subdirectory(ZeroEditor)

    set(Zero_OptionalTarget_ZeroEditor ZeroEditor)
endif()

################################################################################
# ZeroLauncher
################################################################################
# actually deal wth the options inside that folder since there are two projects
add_subdirectory(ZeroLauncher)


################################################################################
# BrowserSubProcess
################################################################################
if(${ZERO_BUILD_BrowserSubProcess})
    add_subdirectory(BrowserSubProcess)

    set(Zero_OptionalTarget_BrowserSubProcess BrowserSubProcess)
endif()


################################################################################
# set the output directories for all of our targets
################################################################################
zero_multitarget_output_directories(
                      ${Zero_OptionalTarget_ZeroEditor}
                      ${Zero_OptionalTarget_ZeroLauncher} 
                      ${Zero_OptionalTarget_ZeroLauncherSharedLibrary}
                      ${Zero_OptionalTarget_BrowserSubProcess}
                      LIBRARY_DIRECTORY ${zero_library_dir}
                      RUNTIME_DIRECTORY ${zero_binary_dir}
)

################################################################################
# set flags and definitions
################################################################################

if (${CMAKE_CXX_COMPILER_ID} STREQUAL MSVC OR (CMAKE_GENERATOR_TOOLSET STREQUAL "LLVM-vs2014"))

    zero_multitarget_compile_options(
        ${Zero_OptionalTarget_ZeroEditor}
        ${Zero_OptionalTarget_ZeroLauncher}
        PRIVATE
         
        PUBLIC
        "-D \"_UNICODE\"" 
        "-D \"UNICODE\""
        "-D \"CURL_STATICLIB\" "
        "-D \"WIN32\" "
        "-D \"_CRT_SECURE_NO_WARNINGS\" "
        "-D \"ZeroExportDll\" "
        PRIVATE
        ${common_flags}

    )

    target_compile_options(
        ${Zero_OptionalTarget_ZeroLauncherSharedLibrary}
        PRIVATE
         
        PUBLIC
        PRIVATE
        ${common_flags}
        "-D \"_UNICODE\"" 
        "-D \"UNICODE\""
        "-D \"CURL_STATICLIB\"" 
        "-D \"WIN32\"" 
        "-D \"_WINDOWS\"" 
        "-D \"_USRDLL\"" 
        "-D \"ZeroLauncherSharedLibrary_EXPORTS\"" 
        "-D \"_WINDLL\"" 
        "-D \"_CRT_SECURE_NO_WARNINGS\"" 
        "-D \"ZeroExportDll\"" 
    )

    # have to set flags for BrowserSubProcess seperatly because it has very different settings
    zero_multitarget_compile_options(
        ${Zero_OptionalTarget_BrowserSubProcess}
        PRIVATE
        PUBLIC
        PRIVATE
        $<$<CONFIG:Debug>:-GS>
        $<$<CONFIG:Release>:-MP>
        $<$<CONFIG:Release>:-GS->
        $<$<CONFIG:Release>:-GL>

        -analyze-
        -W3 
        -wd"4302"
        -wd"4305"
        -Zc:wchar_t

        $<$<CONFIG:Debug>:-Zi>
        $<$<CONFIG:Release>:-Zi>
        $<$<CONFIG:Debug>:-Gm>
        $<$<CONFIG:Release>:-Gm->
        $<$<CONFIG:Debug>:-Od>
        $<$<CONFIG:Release>:-O2>

        -Zc:inline 
        -fp:precise 
        -errorReport:prompt 
        -Zc:forScope 
        -GR- 
        -Gd
        $<$<CONFIG:Release>:-arch:SSE2>
        -Oy-
        $<$<CONFIG:Debug>:-MDd>
        $<$<CONFIG:Release>:-Oi>
        $<$<CONFIG:Release>:-MT>
        -EHsc 
        $<$<CONFIG:Release>:-Gy>

        -nologo

        $<$<CONFIG:Release>:-"D \"NDEBUG\"">
        $<$<CONFIG:Release>:-"D \"VLD\"">
    )
    
    # set the correct subsystems for executable targets, and set stack size for the editor
    set_target_properties(
        ${Zero_OptionalTarget_ZeroEditor} 
        PROPERTIES 
        LINK_FLAGS "/SUBSYSTEM:WINDOWS /STACK:8388608 /DEBUG ${common_linker_flags}"
    )

    set_target_properties(
        ${Zero_OptionalTarget_ZeroLauncher} 
        ${Zero_OptionalTarget_ZeroEditor} 
        ${Zero_OptionalTarget_ZeroLauncherSharedLibrary} 
        PROPERTIES 
        LINK_FLAGS_RELEASE "/LTCG"
    )
    
    set_target_properties(
        ${Zero_OptionalTarget_ZeroLauncher} 
        ${Zero_OptionalTarget_ZeroLauncherSharedLibrary} 
        ${Zero_OptionalTarget_BrowserSubProcess}
        PROPERTIES 
        LINK_FLAGS "/SUBSYSTEM:WINDOWS /DEBUG ${common_linker_flags}"
    )
else()
    zero_multitarget_compile_options(
        ${Zero_OptionalTarget_ZeroEditor}
        ${Zero_OptionalTarget_ZeroLauncher}
        ${Zero_OptionalTarget_BrowserSubProcess}
        PRIVATE
        PUBLIC
        PRIVATE
        ${common_flags}
    )
    set_target_properties(
        ${Zero_OptionalTarget_ZeroEditor}
        ${Zero_OptionalTarget_ZeroLauncher}
        ${Zero_OptionalTarget_BrowserSubProcess}
        PROPERTIES
        LINK_FLAGS "${common_linker_flags}"
    )
endif()

if (${platform} STREQUAL "Emscripten")
    set_target_properties(
        ${Zero_OptionalTarget_ZeroEditor}
        PROPERTIES SUFFIX ".html"
        LINK_FLAGS "--embed-file \"${zero_build_out}/ZeroEditorFileSystem.zip\"@/FileSystem.zip"
    )
    set_target_properties(
        ${Zero_OptionalTarget_ZeroLauncher}
        PROPERTIES SUFFIX ".html"
        LINK_FLAGS "--embed-file \"${zero_build_out}/ZeroLauncherFileSystem.zip\"@/FileSystem.zip"
    )
endif()
