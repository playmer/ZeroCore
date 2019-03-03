################################################################################
# Generated using Joshua T. Fisher's 'CMake Builder'.
# Link: https://github.com/playmer/CmakeBuilder 
################################################################################
add_library(Meta "")

set_target_properties(Meta PROPERTIES FOLDER "ZeroLibraries")

target_sources(Meta
  PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}/AttributeExtension.cpp
    ${CMAKE_CURRENT_LIST_DIR}/AttributeExtension.hpp
    ${CMAKE_CURRENT_LIST_DIR}/CommonHandleManagers.cpp
    ${CMAKE_CURRENT_LIST_DIR}/CommonHandleManagers.hpp
    ${CMAKE_CURRENT_LIST_DIR}/Event.cpp
    ${CMAKE_CURRENT_LIST_DIR}/Event.hpp
    ${CMAKE_CURRENT_LIST_DIR}/HandleManagers.hpp
    ${CMAKE_CURRENT_LIST_DIR}/LocalModifications.cpp
    ${CMAKE_CURRENT_LIST_DIR}/LocalModifications.hpp
    ${CMAKE_CURRENT_LIST_DIR}/MercurialSourceControl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/MetaArray.cpp
    ${CMAKE_CURRENT_LIST_DIR}/MetaArray.hpp
    ${CMAKE_CURRENT_LIST_DIR}/MetaBindingExtensions.cpp
    ${CMAKE_CURRENT_LIST_DIR}/MetaBindingExtensions.hpp
    ${CMAKE_CURRENT_LIST_DIR}/MetaComposition.cpp
    ${CMAKE_CURRENT_LIST_DIR}/MetaComposition.hpp
    ${CMAKE_CURRENT_LIST_DIR}/MetaDatabase.cpp
    ${CMAKE_CURRENT_LIST_DIR}/MetaDatabase.hpp
    ${CMAKE_CURRENT_LIST_DIR}/MetaEditorExtensions.cpp
    ${CMAKE_CURRENT_LIST_DIR}/MetaEditorExtensions.hpp
    ${CMAKE_CURRENT_LIST_DIR}/MetaHandles.cpp
    ${CMAKE_CURRENT_LIST_DIR}/MetaHandles.hpp
    ${CMAKE_CURRENT_LIST_DIR}/MetaLibraryExtensions.cpp
    ${CMAKE_CURRENT_LIST_DIR}/MetaLibraryExtensions.hpp
    ${CMAKE_CURRENT_LIST_DIR}/MetaMath.cpp
    ${CMAKE_CURRENT_LIST_DIR}/MetaMath.hpp
    ${CMAKE_CURRENT_LIST_DIR}/MetaSelection.cpp
    ${CMAKE_CURRENT_LIST_DIR}/MetaSelection.hpp
    ${CMAKE_CURRENT_LIST_DIR}/MetaStandard.cpp
    ${CMAKE_CURRENT_LIST_DIR}/MetaStandard.hpp
    ${CMAKE_CURRENT_LIST_DIR}/NativeTypeConversion.cpp
    ${CMAKE_CURRENT_LIST_DIR}/NativeTypeConversion.hpp
    ${CMAKE_CURRENT_LIST_DIR}/Notification.cpp
    ${CMAKE_CURRENT_LIST_DIR}/Notification.hpp
    ${CMAKE_CURRENT_LIST_DIR}/Object.cpp
    ${CMAKE_CURRENT_LIST_DIR}/Object.hpp
    ${CMAKE_CURRENT_LIST_DIR}/ObjectRestoreState.hpp
    ${CMAKE_CURRENT_LIST_DIR}/Precompiled.cpp
    ${CMAKE_CURRENT_LIST_DIR}/Precompiled.hpp
    ${CMAKE_CURRENT_LIST_DIR}/PropertyHandle.cpp
    ${CMAKE_CURRENT_LIST_DIR}/PropertyHandle.hpp
    ${CMAKE_CURRENT_LIST_DIR}/SourceControl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/SourceControl.hpp
    ${CMAKE_CURRENT_LIST_DIR}/SvnSourceControl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/Tags.hpp
    ${CMAKE_CURRENT_LIST_DIR}/ThreadSafeReferenceCounted.cpp
    ${CMAKE_CURRENT_LIST_DIR}/ThreadSafeReferenceCounted.hpp
    ${CMAKE_CURRENT_LIST_DIR}/VariantTypes.inl
    ${CMAKE_CURRENT_LIST_DIR}/ZeroMetaArray.hpp
)

target_include_directories(Meta
PUBLIC
    ${CMAKE_CURRENT_LIST_DIR} 
    ${CMAKE_CURRENT_LIST_DIR}/../
)

target_link_libraries(Meta
                    PUBLIC
                    Zilch
)


zero_multitarget_output_settings(
    Meta
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


zero_source_group(${CMAKE_CURRENT_LIST_DIR} Meta "")
