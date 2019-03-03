################################################################################
# Generated using Joshua T. Fisher's 'CMake Builder'.
# Link: https://github.com/playmer/CmakeBuilder 
################################################################################
add_executable(BrowserSubProcess "")

set_target_properties(BrowserSubProcess PROPERTIES FOLDER "Projects")

target_sources(BrowserSubProcess
  PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}/main.cpp
)

target_include_directories(BrowserSubProcess
    PUBLIC 
        ${CurrentDirectory}   
        ${CurrentDirectory}/../
)
target_link_libraries(BrowserSubProcess
                      PUBLIC
                      Common
                      Platform
                      ${FreetypeStatic}
                      ${ZLibStatic}
                      ${LibpngStatic}
                      ${CEFStatic}
)

zero_multitarget_output_settings(
    BrowserSubProcess
    CONFIGS ${supported_configs}
    BASEPATH ${zero_build_out}
    PLATFORM ${platform}
    CONFIG ${configuration}
    BITS ${bit}
    TOOLSET ${CMAKE_VS_PLATFORM_TOOLSET}
    PRECOMPILED_HEADER_NAME ""
    PRECOMPILED_SOURCE_NAME ""
    TARGET_SUBFOLDER
)

#zero_subfolder_source_group(${zero_core_path} Projects BrowserSubProcess "")
zero_source_group(${CMAKE_CURRENT_LIST_DIR} BrowserSubProcess "")
#zero_subfolder_source_group_ignore_target_folder(${zero_core_path} Projects BrowserSubProcess "${zero_core_path}/Projects")


add_custom_command(
    TARGET BrowserSubProcess POST_BUILD
    # executes "cmake -E copy_directory
    COMMAND ${CMAKE_COMMAND} -E copy_directory  
    # input folder
    ${zero_binary_dir}/BrowserSubProcess                                  
    #output folder
    ${zero_binary_dir}/ZeroEditor
)

if (${CEF_exists})
    zero_multitarget_copy_folders_to_target_output_directories(
        BrowserSubProcess
        OUTPUT_DIRECTORY ${zero_binary_dir}
        FOLDERS_TO_COPY 
        ${aZeroCoreDirectory}/External/CEF/bin
    )
endif()
