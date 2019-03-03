################################################################################
# Add any files that need to be manually added in this file.
# Link: https://github.com/playmer/CmakeBuilder 
################################################################################
if(${ZERO_BUILD_ZeroLauncher})
    add_subdirectory(ZeroLauncher)
    set(Zero_OptionalTarget_ZeroLauncher ZeroLauncher PARENT_SCOPE)
endif()

if(${ZERO_BUILD_ZeroLauncherSharedLibrary})
    add_subdirectory(ZeroLauncherSharedLibrary)
    set(Zero_OptionalTarget_ZeroLauncherSharedLibrary ZeroLauncherSharedLibrary PARENT_SCOPE)
endif()



