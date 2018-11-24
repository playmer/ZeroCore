################################################################################
# Author: Joshua Shlemmer
# Copyright 2017, DigiPen Institute of Technology
################################################################################

# Should be run after all link targets are defined, and all sources are added.
function(zero_target_precompiled_headers aTarget aIntPath aHeaderName aSourceName)
  if (NOT ${MSVC} AND NOT (CMAKE_GENERATOR_TOOLSET STREQUAL "LLVM-vs2014"))
    message(SEND_ERROR "zero_target_precompiled_headers doesn't currently support anything but MSVC.")
    return()
  endif()

  set(pathToSource "${aSourceName}")

  set(precompiledObj "${aIntPath}/${aTarget}.pch")

  get_target_property(targetSources ${aTarget} SOURCES)

  foreach (targetSource ${targetSources})
    # if this is a cpp
    if(${targetSource} MATCHES \\.\(cpp|cxx|cc\)$)
      get_filename_component(targetSourceJustNameAndExtension ${targetSource} NAME)

      # if it is the precompiled cpp
      if(${targetSourceJustNameAndExtension} STREQUAL ${pathToSource})
        message(pchFound: ${targetSource})

        set_source_files_properties(${targetSource} PROPERTIES COMPILE_FLAGS
        "/Yc\"${aHeaderName}\" /Fp\"${precompiledObj}\"")
        set_source_files_properties(${targetSource} PROPERTIES OBJECT_OUTPUTS "${precompiledObj}")
        # if it is every other cpp
      else()
        set_source_files_properties(${targetSource} PROPERTIES OBJECT_DEPENDS "${precompiledObj}")
        set_source_files_properties(${targetSource} PROPERTIES COMPILE_FLAGS
                                "/Yu\"${aHeaderName}\" /Fp\"${precompiledObj}\"")
      endif()
    endif()
  endforeach()

  target_compile_options(${aTarget} PRIVATE #"/Yc${aHeaderName}"
                                            "/Yu\"${aHeaderName}\""
                                            "/Fp\"${precompiledObj}\"")
  message("Precompiled header added for target: ${aTarget}")

  set_property(GLOBAL PROPERTY "${aTarget}_Precompiled_Headers_Enabled" TRUE)

endfunction()


function(zero_target_precompiled_headers_helper)
    # set arguments
    set(oneValueArgs CONFIGS BASEPATH PLATFORM BITS TOOLSET PRECOMPILED_HEADER_NAME PRECOMPILED_SOURCE_NAME TARGET_SUBFOLDER IGNORE_TARGET CONFIG)
    cmake_parse_arguments(PARSED "" "${oneValueArgs}" "" ${ARGN})

    if("${PARSED_IGNORE_TARGET}" STREQUAL "")
        set(PARSED_IGNORE_TARGET OFF)
    endif()


    set(PARSED_TARGETS ${PARSED_UNPARSED_ARGUMENTS})

    # because of the way option sets were implemented, we must handle the no targets case
    if (PARSED_TARGETS STREQUAL "")
        return()
    endif()

    foreach(target ${PARSED_TARGETS})
      # if we were passed a config, seperate our intermediate files by config instead of platform
      if(PARSED_CONFIG)
        set(intOutputDirectory "${PARSED_BASEPATH}/Int/${PARSED_CONFIG}/${PARSED_BITS}${CONFIGS}/${target}")
      else()
        set(intOutputDirectory "${PARSED_BASEPATH}/Int/${PARSED_PLATFORM}/${PARSED_BITS}${CONFIGS}/${target}")
      endif()
      
      # if we were passed values for the precompiled headers, set the target precompiled headers
      if (NOT ("${PARSED_PRECOMPILED_HEADER_NAME}" STREQUAL ""))
          message(stuff: ${target} : "${intOutputDirectory}" : ${PARSED_PRECOMPILED_HEADER_NAME} : ${PARSED_PRECOMPILED_SOURCE_NAME})

          zero_target_precompiled_headers(${target} "${intOutputDirectory}" ${PARSED_PRECOMPILED_HEADER_NAME} ${PARSED_PRECOMPILED_SOURCE_NAME})
      else()
          message("<><><> Skipped precompiled for target: ${target}\n")
      endif()
    endforeach()
endfunction()
