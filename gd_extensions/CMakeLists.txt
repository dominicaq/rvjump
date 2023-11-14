cmake_minimum_required(VERSION 3.6)
project(VRVExt)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

include_directories(godot-cpp/include godot-cpp/build/gen/include godot-cpp/gdextension)
add_library(VRVExt SHARED vrv/vrv_ext.cc vrv/vrv_ext.h)

# Link against the static library produced by the submodule
target_link_libraries(VRVExt ${CMAKE_CURRENT_SOURCE_DIR}/godot-cpp/build/bin/libgodot-cpp.linux.release.64.a)

