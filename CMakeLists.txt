################################################################################
# Author: Joshua Shlemmer
# Copyright 2017, DigiPen Institute of Technology
################################################################################
################################################################################
# Set required version of cmake and any version specific policies
################################################################################
cmake_minimum_required(VERSION 3.9.1 FATAL_ERROR)
set_property(GLOBAL PROPERTY USE_FOLDERS ON)

set(CMAKE_CONFIGURATION_TYPES Debug Release RelWithDebInfo)

################################################################################
# Declare project(s) and set used languages
################################################################################
project(Zero CXX)

################################################################################
# Do platform specific checks for chunks of the library paths
################################################################################

## windows libraries
#if( ${CMAKE_SYSTEM_NAME} STREQUAL "Windows")
#    set(platform Windows)
#    # 64 bit windows libraries
#    if( ${CMAKE_SIZEOF_VOID_P} EQUAL 8 )
#        message(FATAL_ERROR "64bit windows is currently not supported.")
#    # 32 bit windows libraries
#    else()
#        set(bit x86)
#    endif()
## non-windows libraries
#else()
#    message(FATAL_ERROR "no other platforms are currently supported besides windows. Current Sys: ${CMAKE_SYSTEM_NAME}")
#endif()


################################################################################
# Set up options for projects depending on various ZeroCore features.
################################################################################

# Set up option sets, these will then set base options, these will all default
# to off.

# If you only want to link against Zilch and the ZilchShader extension this
# option is for you.
option(ZERO_OPTIONSET_ZilchShader "The ZilchShaders option set, will turn on everything required for ZilchShaders" OFF)

if(${ZERO_BUILD_ZilchShader})
    option(ZERO_BUILD_ZilchShaders "Build the ZilchShaders project" ON)
    option(ZERO_OPTIONSET_Zilch "Build the Zilch project" ON)
endif()

# If you only want to link against Zilch this option is for you.
option(ZERO_OPTIONSET_Zilch "The Zilch option set, will turn on everything required for Zilch" OFF)

if(${ZERO_BUILD_Zilch})
    option(ZERO_BUILD_Zilch "Build the Zilch project" ON)
endif()

##############################
# Base options.
##############################
#####################
# ZeroLibraries
#####################
option(ZERO_BUILD_Common "Build the Common project" ON)
option(ZERO_BUILD_Dash "Build the Dash project" ON)
option(ZERO_BUILD_Geometry "Build the Geometry project" ON)
option(ZERO_BUILD_Meta "Build the Meta project" ON)
option(ZERO_BUILD_Platform "Build the Platform project" ON)
option(ZERO_BUILD_Serialization "Build the Serialization project" ON)
option(ZERO_BUILD_SpatialPartition "Build the SpatialPartition project" ON)
option(ZERO_BUILD_Support "Build the Support project" ON)
option(ZERO_BUILD_Zilch "Build the Zilch project" ON)

#####################
# External
#####################


#####################
# Extensions
#####################
option(ZERO_BUILD_CodeTranslator "Build the CodeTranslator project" ON)
option(ZERO_BUILD_Editor "Build the Editor project" ON)
option(ZERO_BUILD_Gameplay "Build the Gameplay project" ON)
option(ZERO_BUILD_UiWidget "Build the UiWidget project" ON)
option(ZERO_BUILD_Widget "Build the Widget project" ON)
option(ZERO_BUILD_ZilchShaders "Build the ZilchShaders project" ON)

################################################################################
# Set up global variables
################################################################################

#paths
set(cmake_include_dir ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
set(cmake_utilities_dir ${cmake_include_dir}/Utilities)
set(cmake_os_dir ${cmake_include_dir}/OS)
set(cmake_flags_dir ${cmake_include_dir}/CommonFlags)
set(cmake_config_dir ${cmake_include_dir}/Configuration)
set(cmake_compiler_dir ${cmake_include_dir}/Compiler)


set(zero_core_path ${CMAKE_CURRENT_SOURCE_DIR})
message("CorePath: ${zero_core_path}\n")
set(zero_build_out ${zero_core_path}/BuildOutput)
set(supported_configs $<$<CONFIG:Debug>:Debug>$<$<CONFIG:Release>:Release>)
set(zero_intermediates_dir ${zero_build_out}/Int/${supported_configs})
set(zero_unit_test_dir ${zero_core_path}/UnitTests)


################################################################################
# Define any user options
################################################################################
option(generate_with_unit_tests "If set to 'ON', project will be generated with the unit tests included." OFF)
option(generate_spirv_projects "If set to 'ON', spirv tools projects will be created. Allows static linking or generation of dll for tools." OFF)
option(use_spirv_shared_library "If set to 'ON', project will link against a dll of spirv (allows release dll in debug mode)." ON)

if(NOT generate_spirv_projects AND NOT use_spirv_shared_library)
  message(FATAL_ERROR "spirv project cannot be statically linked without also generating the spirv projects.")
endif()

################################################################################
# Define any platform options
################################################################################
include(${cmake_include_dir}/Platform_Options.cmake)

set(zero_platform_data ${zero_core_path}/PlatformData/${platform})

set(zero_library_dir ${zero_build_out}/Out/${configuration}/${supported_configs})
set(zero_binary_dir ${zero_build_out}/Out/${configuration}/${supported_configs})

################################################################################
# Path for finding external CMake modules
################################################################################
set(CMAKE_MODULE_PATH "${Source_Root}/cmake/modules/")

################################################################################
# Includes
################################################################################
include(${cmake_utilities_dir}/zero_source_group.cmake)
include(${cmake_utilities_dir}/Zero_Mulitarget_Functions.cmake)
include(${cmake_utilities_dir}/Zero_Custom_Commands.cmake)

################################################################################
# Separate Projects into folders for IDEs.
################################################################################
set_property(GLOBAL PROPERTY USE_FOLDERS ON)


################################################################################
# Call CMakeLists.txt in source folders, adding them to the project non-globally
################################################################################
# external libraries
add_subdirectory(External)

# zero source and related projects
add_subdirectory(Extensions)
add_subdirectory(Systems)
add_subdirectory(ZeroLibraries)
add_subdirectory(Projects)

if (generate_with_unit_tests)
    if (NOT EXISTS ${zero_unit_test_dir})
        message(WARNING "option 'generate_with_unit_tests' set but unit test directory: '${zero_unit_test_dir}' doesn't exist.\n Skipping unit tests.\n")
    else()
        message("\nAdding unit tests to project...\n")
        add_subdirectory(UnitTests)
    endif()
endif()

set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT ZeroEditor) 

