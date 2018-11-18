################################################################################
# Generated using Joshua T. Fisher's 'CMake Builder'.
# Link: https://github.com/playmer/CmakeBuilder 
################################################################################
add_library(UiWidget "")

set_target_properties(UiWidget PROPERTIES FOLDER "Extensions")

target_sources(UiWidget
    PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}/Precompiled.cpp
    ${CMAKE_CURRENT_LIST_DIR}/Precompiled.hpp
    ${CMAKE_CURRENT_LIST_DIR}/UiDockLayout.cpp
    ${CMAKE_CURRENT_LIST_DIR}/UiDockLayout.hpp
    ${CMAKE_CURRENT_LIST_DIR}/UiFillLayout.cpp
    ${CMAKE_CURRENT_LIST_DIR}/UiFillLayout.hpp
    ${CMAKE_CURRENT_LIST_DIR}/UiLayout.cpp
    ${CMAKE_CURRENT_LIST_DIR}/UiLayout.hpp
    ${CMAKE_CURRENT_LIST_DIR}/UiRootWidget.cpp
    ${CMAKE_CURRENT_LIST_DIR}/UiRootWidget.hpp
    ${CMAKE_CURRENT_LIST_DIR}/UiStackLayout.cpp
    ${CMAKE_CURRENT_LIST_DIR}/UiStackLayout.hpp
    ${CMAKE_CURRENT_LIST_DIR}/UiWidget.cpp
    ${CMAKE_CURRENT_LIST_DIR}/UiWidget.hpp
    ${CMAKE_CURRENT_LIST_DIR}/UiWidgetEvents.cpp
    ${CMAKE_CURRENT_LIST_DIR}/UiWidgetEvents.hpp
    ${CMAKE_CURRENT_LIST_DIR}/UiWidgetStandard.cpp
    ${CMAKE_CURRENT_LIST_DIR}/UiWidgetStandard.hpp
)

target_include_directories(UiWidget 
PUBLIC 
    ${CMAKE_CURRENT_LIST_DIR}/../
)

target_link_libraries(UiWidget
                PUBLIC
                Engine
) 

zero_source_group(${CMAKE_CURRENT_LIST_DIR} UiWidget "")
