cmake_minimum_required(VERSION 3.2)
project(robot-sr)

include(cmake/external.cmake)

include_directories(${CMAKE_JS_INC} ${CMAKE_SOURCE_DIR}/extlib/include 
                    ${CMAKE_SOURCE_DIR}/extlib/include/pocketsphinx 
                    ${CMAKE_SOURCE_DIR}/extlib/include/sphinxbase )
link_directories(${CMAKE_SOURCE_DIR}/extlib/lib)

message(STATUS ${CMAKE_JS_INC})
file(GLOB SOURCE_FILES ${CMAKE_SOURCE_DIR}/src/*.cpp)

add_library(${PROJECT_NAME} SHARED ${SOURCE_FILES})
set_target_properties(${PROJECT_NAME} PROPERTIES PREFIX "" SUFFIX ".node")
target_link_libraries(${PROJECT_NAME} ${CMAKE_JS_LIB} pocketsphinx sphinxbase)

# add_dependencies(${PROJECT_NAME} deps)