
set (third_party_install_path ${CMAKE_CURRENT_SOURCE_DIR}/extlib)

if (UNIX)
    set(POCKETSPHINX_BUILD_COMMAND "sh autogen.sh && ./configure && make install -j8")
else()
    set(POCKETSPHINX_BUILD_COMMAND "sh autogen.sh && ./configure && make install -j8")
endif()

ExternalProject_Add(pocketsphinx 
    DOWNLOAD_DIR third_party/
	GIT_REPOSITORY https://github.com/cmusphinx/pocketsphinx
    SOURCE_DIR third_party/pocketsphinx/
    BUILD_COMMAND ${POCKETSPHINX_BUILD_COMMAND}
    BUILD_ALWAYS 0
)


ExternalProject_Add(sphinxbase 
    DOWNLOAD_DIR third_party/
	GIT_REPOSITORY https://github.com/cmusphinx/sphinxbase
    SOURCE_DIR third_party/sphinxbase/
    BUILD_COMMAND ${POCKETSPHINX_BUILD_COMMAND}
    BUILD_ALWAYS 0
)


ADD_CUSTOM_TARGET(deps
	DEPENDS sphinxbase pocketsphinx
)