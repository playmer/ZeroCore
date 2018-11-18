################################################################################
# Generated using Joshua T. Fisher's 'CMake Builder'.
# Link: https://github.com/playmer/CmakeBuilder 
################################################################################
add_library(Startup "")

set_target_properties(Startup PROPERTIES FOLDER "Systems")

target_sources(Startup
  PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}/Precompiled.cpp
    ${CMAKE_CURRENT_LIST_DIR}/Precompiled.hpp
    ${CMAKE_CURRENT_LIST_DIR}/Startup.cpp
    ${CMAKE_CURRENT_LIST_DIR}/Startup.hpp
    ${CMAKE_CURRENT_LIST_DIR}/StartupStandard.hpp
)

target_include_directories(Startup 
PUBLIC 
    ${CMAKE_CURRENT_LIST_DIR}/../
)

target_link_libraries(Startup
    PUBLIC
    Common
    Geometry
    Graphics
) 

zero_source_group(${CMAKE_CURRENT_LIST_DIR} Startup "")
