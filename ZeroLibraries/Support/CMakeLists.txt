################################################################################
# Generated using Joshua T. Fisher's 'CMake Builder'.
# Link: https://github.com/playmer/CmakeBuilder 
################################################################################
add_library(Support "")

set_target_properties(Support PROPERTIES FOLDER "ZeroLibraries")

target_sources(Support
  PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}/Archive.cpp
    ${CMAKE_CURRENT_LIST_DIR}/Archive.hpp
    ${CMAKE_CURRENT_LIST_DIR}/ChunkReader.hpp
    ${CMAKE_CURRENT_LIST_DIR}/ChunkWriter.hpp
    ${CMAKE_CURRENT_LIST_DIR}/FileConsoleListener.hpp
    ${CMAKE_CURRENT_LIST_DIR}/FileSupport.cpp
    ${CMAKE_CURRENT_LIST_DIR}/FileSupport.hpp
    ${CMAKE_CURRENT_LIST_DIR}/HdrSupport.cpp
    ${CMAKE_CURRENT_LIST_DIR}/HdrSupport.hpp
    ${CMAKE_CURRENT_LIST_DIR}/ImageSupport.cpp
    ${CMAKE_CURRENT_LIST_DIR}/ImageSupport.hpp
    ${CMAKE_CURRENT_LIST_DIR}/NameValidation.cpp
    ${CMAKE_CURRENT_LIST_DIR}/NameValidation.hpp
    ${CMAKE_CURRENT_LIST_DIR}/PartialMatch.cpp
    ${CMAKE_CURRENT_LIST_DIR}/PartialMatch.hpp
    ${CMAKE_CURRENT_LIST_DIR}/PngSupport.cpp
    ${CMAKE_CURRENT_LIST_DIR}/PngSupport.hpp
    ${CMAKE_CURRENT_LIST_DIR}/Precompiled.cpp
    ${CMAKE_CURRENT_LIST_DIR}/Precompiled.hpp
    ${CMAKE_CURRENT_LIST_DIR}/Profiler.cpp
    ${CMAKE_CURRENT_LIST_DIR}/Profiler.hpp
    ${CMAKE_CURRENT_LIST_DIR}/StringMap.hpp
    ${CMAKE_CURRENT_LIST_DIR}/StringReplacement.cpp
    ${CMAKE_CURRENT_LIST_DIR}/StringReplacement.hpp
    ${CMAKE_CURRENT_LIST_DIR}/SupportStandard.hpp
    ${CMAKE_CURRENT_LIST_DIR}/Urls.cpp
    ${CMAKE_CURRENT_LIST_DIR}/Urls.hpp
)

target_include_directories(Support
PUBLIC
    ${CMAKE_CURRENT_LIST_DIR}/../
    ${CMAKE_CURRENT_LIST_DIR}
)

target_link_libraries(Support
                    PUBLIC
                    Common
                    ${ZLibStatic}
                    ${LibpngStatic}
)

zero_multitarget_output_settings(
    Support
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


zero_source_group(${CMAKE_CURRENT_LIST_DIR} Support "")
