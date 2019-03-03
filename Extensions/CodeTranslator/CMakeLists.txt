################################################################################
# Generated using Joshua T. Fisher's 'CMake Builder'.
# Link: https://github.com/playmer/CmakeBuilder 
################################################################################
add_library(CodeTranslator "")

set_target_properties(CodeTranslator PROPERTIES FOLDER "Extensions")

target_sources(CodeTranslator
  PRIVATE
  ${CMAKE_CURRENT_LIST_DIR}/CodeSplitWindow.cpp
  ${CMAKE_CURRENT_LIST_DIR}/CodeSplitWindow.hpp
  ${CMAKE_CURRENT_LIST_DIR}/CodeTranslatorCommands.cpp
  ${CMAKE_CURRENT_LIST_DIR}/CodeTranslatorCommands.hpp
  ${CMAKE_CURRENT_LIST_DIR}/CodeTranslatorStandard.hpp
  ${CMAKE_CURRENT_LIST_DIR}/Precompiled.cpp
  ${CMAKE_CURRENT_LIST_DIR}/Precompiled.hpp
  ${CMAKE_CURRENT_LIST_DIR}/ShaderTranslationDebugHelper.cpp
  ${CMAKE_CURRENT_LIST_DIR}/ShaderTranslationDebugHelper.hpp
)

target_include_directories(CodeTranslator 
PUBLIC 
    ${CMAKE_CURRENT_LIST_DIR}/../
)

target_link_libraries(CodeTranslator
                PUBLIC
                Engine
)

zero_multitarget_output_settings(
    CodeTranslator
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

zero_source_group(${CMAKE_CURRENT_LIST_DIR} CodeTranslator "")
