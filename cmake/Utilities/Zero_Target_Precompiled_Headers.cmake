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
