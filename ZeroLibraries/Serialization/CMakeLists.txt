################################################################################
# Generated using Joshua T. Fisher's 'CMake Builder'.
# Link: https://github.com/playmer/CmakeBuilder 
################################################################################
add_library(Serialization "")

set_target_properties(Serialization PROPERTIES FOLDER "ZeroLibraries")

target_sources(Serialization
  PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}/Binary.cpp
    ${CMAKE_CURRENT_LIST_DIR}/Binary.hpp
    ${CMAKE_CURRENT_LIST_DIR}/DataTree.cpp
    ${CMAKE_CURRENT_LIST_DIR}/DataTree.hpp
    ${CMAKE_CURRENT_LIST_DIR}/DataTreeNode.cpp
    ${CMAKE_CURRENT_LIST_DIR}/DataTreeNode.hpp
    ${CMAKE_CURRENT_LIST_DIR}/DataTreeParser.cpp
    ${CMAKE_CURRENT_LIST_DIR}/DataTreeParser.hpp
    ${CMAKE_CURRENT_LIST_DIR}/DataTreeTokenizer.cpp
    ${CMAKE_CURRENT_LIST_DIR}/DataTreeTokenizer.hpp
    ${CMAKE_CURRENT_LIST_DIR}/DefaultSerializer.hpp
    ${CMAKE_CURRENT_LIST_DIR}/EnumSerialization.hpp
    ${CMAKE_CURRENT_LIST_DIR}/FundamentalTypes.hpp
    ${CMAKE_CURRENT_LIST_DIR}/LegacyDataTreeParser.cpp
    ${CMAKE_CURRENT_LIST_DIR}/LegacyDataTreeParser.hpp
    ${CMAKE_CURRENT_LIST_DIR}/MathSerialization.hpp
    ${CMAKE_CURRENT_LIST_DIR}/MetaSerialization.cpp
    ${CMAKE_CURRENT_LIST_DIR}/MetaSerialization.hpp
    ${CMAKE_CURRENT_LIST_DIR}/OldDataTreeParser.cpp
    ${CMAKE_CURRENT_LIST_DIR}/OldDataTreeParser.hpp
    ${CMAKE_CURRENT_LIST_DIR}/Precompiled.cpp
    ${CMAKE_CURRENT_LIST_DIR}/Precompiled.hpp
    ${CMAKE_CURRENT_LIST_DIR}/Serialization.cpp
    ${CMAKE_CURRENT_LIST_DIR}/Serialization.hpp
    ${CMAKE_CURRENT_LIST_DIR}/SerializationBuilder.hpp
    ${CMAKE_CURRENT_LIST_DIR}/SerializationStandard.cpp
    ${CMAKE_CURRENT_LIST_DIR}/SerializationStandard.hpp
    ${CMAKE_CURRENT_LIST_DIR}/SerializationTraits.hpp
    ${CMAKE_CURRENT_LIST_DIR}/SerializationUtility.cpp
    ${CMAKE_CURRENT_LIST_DIR}/SerializationUtility.hpp
    ${CMAKE_CURRENT_LIST_DIR}/Simple.cpp
    ${CMAKE_CURRENT_LIST_DIR}/Simple.hpp
    ${CMAKE_CURRENT_LIST_DIR}/StdContainers.hpp
    ${CMAKE_CURRENT_LIST_DIR}/Text.cpp
    ${CMAKE_CURRENT_LIST_DIR}/Text.hpp
    ${CMAKE_CURRENT_LIST_DIR}/Tokenizer.cpp
    ${CMAKE_CURRENT_LIST_DIR}/Tokenizer.hpp
    ${CMAKE_CURRENT_LIST_DIR}/ZeroContainers.hpp
)

target_include_directories(Serialization
PUBLIC
    ${CMAKE_CURRENT_LIST_DIR} 
    ${CMAKE_CURRENT_LIST_DIR}/../
)

target_link_libraries(Serialization
                    PUBLIC
                    Common
                    Geometry
)


zero_multitarget_output_settings(
    Serialization
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

zero_source_group(${CMAKE_CURRENT_LIST_DIR} Serialization "")
