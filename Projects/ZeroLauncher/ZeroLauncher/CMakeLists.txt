################################################################################
# Generated using Joshua T. Fisher's 'CMake Builder'.
# Link: https://github.com/playmer/CmakeBuilder 
################################################################################
# get our current directory
set(CurrentDirectory ${CMAKE_CURRENT_LIST_DIR})

add_executable(ZeroLauncher "")

set_target_properties(ZeroLauncher PROPERTIES FOLDER "Projects")

set(platformSpecificSource)

# get the rc file so we get icons on windows builds
if (${platform} STREQUAL "Windows")
    set(platformSpecificSource
    ${zero_platform_data}/ZeroLauncher/ZeroLauncher.rc
    ${zero_platform_data}/ZeroLauncher/Resource.h
    )
endif()

target_sources(ZeroLauncher
  PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}/Main.cpp
    ${CMAKE_CURRENT_LIST_DIR}/Precompiled.cpp
    ${CMAKE_CURRENT_LIST_DIR}/Precompiled.hpp
    ${platformSpecificSource}
)

target_include_directories(ZeroLauncher 
    PUBLIC 
        ${CurrentDirectory}/../..
        ${CurrentDirectory}
        ${CurrentDirectory}/../ZeroLauncherSharedLibrary
)

target_link_libraries(ZeroLauncher
                      PUBLIC
                      Common
                      Gameplay
                      SpatialPartition 
                      ZilchShaders
                      Serialization 
                      Support 
                      Geometry 
                      Widget 
                      Editor 
                      ZilchScript 
                      Graphics 
                      Networking 
                      Meta 
                      Engine 
                      Physics 
                      Sound 
                      Startup 
                      Platform 
                      Content 
                      Dash 
                      Zilch 
                      UiWidget 
                      CodeTranslator
) 


add_dependencies(ZeroLauncher
    ZeroLauncherSharedLibrary
)

zero_subfolder_source_group_ignore_target_folder(${zero_core_path} Projects ZeroLauncher "${zero_core_path}/Projects")
#zero_source_group(${CMAKE_CURRENT_LIST_DIR} ZeroLauncher "")

################################################################################
# Post build steps
################################################################################
copy_multiple_shared_objects(
    ZeroLauncher
    OUTPUT_DIRECTORY ${zero_binary_dir}
    SHARED_OBJECT_LOCATIONS
    ## setup all dll locations
    ${AssimpSharedPath}
    ${CEFSharedPath}
    ${FreetypeSharedPath}
    ${GLEWSharedPath}
    ${MemoryDebuggerSharedPath}
    ${MemoryTrackerSharedPath}
    ${NvttSharedPath}
    ${PortAudioSharedPath}
    ${SDLSharedPath}
)

if(use_spirv_shared_library)
  copy_multiple_shared_objects(
      ZeroLauncher
      OUTPUT_DIRECTORY ${zero_binary_dir}
      SHARED_OBJECT_LOCATIONS
      ${SpirVToolsSharedPath}
  )
endif()

if("${platform}" STREQUAL "Emscripten")
    message("should be calling zip directory for ZeroLauncher")
    multitarget_zip_directory(
        ZeroLauncher 
        FOLDERS_TO_ZIP
        "Resources/Loading"
        "Resources/FragmentCore"
        "Resources/ZeroCore"
        "Resources/ZeroLauncherResources"
        "PrebuiltZeroContent"
        "Tools/SpriteVersion.txt"
        "Data/ColorSchemes"
        "Data/Fallback"
        "Data/Licenses"
        "Data/ZilchFragmentSettings"
        "Data/*.*"
        OUTPUT_FILE
        "BuildOutput/ZeroLauncherFileSystem.zip"
    )
endif()

launcher_post_build(
    ZeroLauncher 
    ${zero_core_path}
    ${CurrentDirectory}
    ${zero_binary_dir}
)

if (${CEF_exists})
    zero_multitarget_copy_folders_to_target_output_directories(
        ZeroLauncher
        OUTPUT_DIRECTORY ${zero_binary_dir}
        FOLDERS_TO_COPY 
        ${aZeroCoreDirectory}/External/CEF/bin
    )
endif()
