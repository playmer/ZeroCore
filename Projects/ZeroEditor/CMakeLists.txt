################################################################################
# Generated using Joshua T. Fisher's 'CMake Builder'.
# Link: https://github.com/playmer/CmakeBuilder 
################################################################################
add_executable(ZeroEditor "")

set_target_properties(ZeroEditor PROPERTIES FOLDER "Projects")

target_sources(ZeroEditor
  PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}/Main.cpp
    ${CMAKE_CURRENT_LIST_DIR}/Precompiled.cpp
    ${CMAKE_CURRENT_LIST_DIR}/Precompiled.hpp
    ${CMAKE_CURRENT_LIST_DIR}/Startup.cpp
    ${CMAKE_CURRENT_LIST_DIR}/ZeroCrashCallbacks.cpp
    ${CMAKE_CURRENT_LIST_DIR}/ZeroCrashCallbacks.hpp
)


set(platformSpecificSource)

# get the rc file so we get icons on windows builds
if (${platform} STREQUAL "Windows")
    set(platformSpecificSource
        ${zero_platform_data}/ZeroEditor/ZeroEditor.rc
        ${zero_platform_data}/ZeroEditor/Resource.h
    )
endif()

target_sources(ZeroEditor
    PRIVATE
    ${platformSpecificSource}
)

target_include_directories(ZeroEditor
PUBLIC
    ${Source_Root}
    ${CMAKE_CURRENT_LIST_DIR} 
    ${CMAKE_CURRENT_LIST_DIR}/../
)

target_link_libraries(ZeroEditor
                      PUBLIC
                      Common
                      Gameplay
                      SpatialPartition
                      CodeTranslator
                      ZilchShaders
                      Serialization
                      Support
                      Engine 
                      Geometry 
                      Widget 
                      Editor 
                      ZilchScript 
                      Networking 
                      Meta 
                      Physics 
                      Sound 
                      Platform 
                      Content 
                      Dash 
                      UiWidget
                      Startup
                      Zilch
                      Graphics
                      ${OpusStatic}
                      ${FreetypeStatic}
                      ${ZLibStatic}
)

if(NOT use_spirv_shared_library)
target_link_libraries(ZeroEditor
                      PUBLIC
                      SPIRV-Tools
                      SPIRV-Tools-opt
                      )
endif()

add_dependencies(ZeroEditor
    BrowserSubProcess
)

zero_subfolder_source_group_ignore_target_folder(${zero_core_path} Projects ZeroEditor "${zero_core_path}/Projects")
#zero_source_group(${CMAKE_CURRENT_LIST_DIR} ZeroEditor "")


################################################################################
# Post build steps
################################################################################
copy_multiple_shared_objects(
    ZeroEditor
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
      ZeroEditor
      OUTPUT_DIRECTORY ${zero_binary_dir}
      SHARED_OBJECT_LOCATIONS
      ${SpirVToolsSharedPath}
  )
endif()

if("${platform}" STREQUAL "Emscripten")
    message("should be calling zip directory for ZeroEditor")
    multitarget_zip_directory(
        ZeroEditor 
        FOLDERS_TO_ZIP
        "Resources/Loading"
        "Resources/FragmentCore"
        "Resources/ZeroCore"
        "Resources/Editor"
        "Resources/EditorUi"
        "Resources/UiWidget"
        "PrebuiltZeroContent"
        "Tools/SpriteVersion.txt"
        "Data/ColorSchemes"
        "Data/Fallback"
        "Data/Licenses"
        "Data/ZilchFragmentSettings"
        "Data/*.*"
        OUTPUT_FILE
        "BuildOutput/ZeroEditorFileSystem.zip"
    )
endif()

#function(create_build_info aTarget aSourceDir aBuildOutDir aOutputLocation)
create_build_info(
    ZeroEditor
    ${CurrentDirectory}/ZeroEditor
    ${zero_core_path}
    ${zero_binary_dir}
    ${zero_binary_dir}
)

#function(CreatePluginDirectory aTarget aZeroCoreDir aBuildOutputDirectory aOS aplatformShortName)
editor_post_build_step(
    ZeroEditor
    ${zero_core_path}
    ${zero_library_dir}
    ${zero_binary_dir}
    ${platform}
    ${bit}
)

if (${CEF_exists})
    zero_multitarget_copy_folders_to_target_output_directories(
        ZeroEditor
        OUTPUT_DIRECTORY ${zero_binary_dir}
        FOLDERS_TO_COPY 
        ${aZeroCoreDirectory}/External/CEF/bin
    )
endif()
