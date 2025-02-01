# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

project(time_config_checker_library VERSION 0.0.1 LANGUAGES C)

add_library(time_config_checker SHARED
  "time_config_checker.c"
)

set_target_properties(time_config_checker PROPERTIES
  PUBLIC_HEADER time_config_checker.h
  OUTPUT_NAME "time_config_checker"
)

target_compile_definitions(time_config_checker PUBLIC DART_SHARED_LIB)

if (ANDROID)
  # Support Android 15 16k page size
  target_link_options(time_config_checker PRIVATE "-Wl,-z,max-page-size=16384")
endif()
