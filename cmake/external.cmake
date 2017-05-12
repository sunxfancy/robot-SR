include(${CMAKE_ROOT}/Modules/ExternalProject.cmake)
set (third_party_install_path ${CMAKE_CURRENT_SOURCE_DIR}/extlib)

if (UNIX)
    set(POCKETSPHINX_CONFIGURE_COMMAND ./autogen.sh --without-python --prefix=${third_party_install_path})
    set(POCKETSPHINX_BUILD_COMMAND make check)
    set(POCKETSPHINX_INSTALL_COMMAND make install)
else()
    set(POCKETSPHINX_CONFIGURE_COMMAND "")
    set(POCKETSPHINX_BUILD_COMMAND ./autogen.sh --without-python && make install -j8)
    set(POCKETSPHINX_INSTALL_COMMAND make install)
endif()


ExternalProject_Add(sphinxbase 
    DOWNLOAD_DIR third_party/
	GIT_REPOSITORY https://github.com/cmusphinx/sphinxbase
    SOURCE_DIR third_party/sphinxbase/
    INSTALL_DIR ${third_party_install_path}
    BUILD_IN_SOURCE 1
    CONFIGURE_COMMAND ${POCKETSPHINX_CONFIGURE_COMMAND}
    BUILD_COMMAND ${POCKETSPHINX_BUILD_COMMAND}
    INSTALL_COMMAND ${POCKETSPHINX_INSTALL_COMMAND}
    BUILD_ALWAYS 0
)


ExternalProject_Add(pocketsphinx 
    DOWNLOAD_DIR third_party/
	GIT_REPOSITORY https://github.com/cmusphinx/pocketsphinx
    SOURCE_DIR third_party/pocketsphinx/
    INSTALL_DIR ${third_party_install_path}
    BUILD_IN_SOURCE 1
    CONFIGURE_COMMAND ${POCKETSPHINX_CONFIGURE_COMMAND}
    BUILD_COMMAND ${POCKETSPHINX_BUILD_COMMAND}
    INSTALL_COMMAND ${POCKETSPHINX_INSTALL_COMMAND}
    BUILD_ALWAYS 0
    DEPENDS sphinxbase
)



ADD_CUSTOM_TARGET(deps
	DEPENDS sphinxbase pocketsphinx
)