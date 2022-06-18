cmake_minimum_required(VERSION 3.20)
project(opencc_window CXX)

add_subdirectory(../OpenCC build)

set(OPENCC_TARGET libopencc)

target_sources(${OPENCC_TARGET} PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/../interface.cpp ${CMAKE_CURRENT_SOURCE_DIR}/../interface.def)

# Because OUTPUT option may not use generator expressions,
# extract name of file from target's properties.
get_target_property(target_basename ${OPENCC_TARGET} OUTPUT_NAME)
get_target_property(target_suffix ${OPENCC_TARGET} SUFFIX)
set(target_filename ${target_basename}${target_suffix})
set(dest_dir ${CMAKE_CURRENT_SOURCE_DIR}/../../flutter_opencc_ffi_windows/windows/shared)
# make copied file be dependent from one which is build.
# Note, that DEPENDS here creates dependencies both from the target
# and from the file it creates.
add_custom_command(OUTPUT
        ${dest_dir}/${target_filename}
        COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:${OPENCC_TARGET}>
        ${dest_dir}
        DEPENDS ${OPENCC_TARGET}
        )
# Create target which consume the command via DEPENDS.
add_custom_target(copy_files ALL
        DEPENDS ${dest_dir}/${target_filename}
        )