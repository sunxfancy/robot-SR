include(${CMAKE_ROOT}/Modules/ExternalProject.cmake)
set (third_party_install_path ${CMAKE_CURRENT_SOURCE_DIR}/extlib)

if (UNIX)
    if (LINUX) 
        set(SPHINXBASE_CONFIGURE_COMMAND ./autogen.sh --without-python CFLAGS='-O2 -fPIC -DNDEBUG' --prefix=${third_party_install_path})
    else()
        set(SPHINXBASE_CONFIGURE_COMMAND ./autogen.sh --without-python --prefix=${third_party_install_path})
    endif()
    set(SPHINXBASE_BUILD_COMMAND make check)
    set(SPHINXBASE_INSTALL_COMMAND make install)

    if (LINUX) 
        set(POCKETSPHINX_CONFIGURE_COMMAND ./autogen.sh --without-python CFLAGS='-O2 -fPIC -DNDEBUG' --prefix=${third_party_install_path})
    else()
        set(POCKETSPHINX_CONFIGURE_COMMAND ./autogen.sh --without-python --prefix=${third_party_install_path})
    endif()
    set(POCKETSPHINX_BUILD_COMMAND make check)
    set(POCKETSPHINX_INSTALL_COMMAND make install)
else()
    set(SPHINXBASE_CONFIGURE_COMMAND devenv sphinxbase.sln /upgrade)
    set(SPHINXBASE_BUILD_COMMAND devenv sphinxbase.sln /build "Release|x64")
    set(SPHINXBASE_INSTALL_COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/script/copylib_sb.bat)

    set(POCKETSPHINX_CONFIGURE_COMMAND devenv pocketsphinx.sln /upgrade)
    set(POCKETSPHINX_BUILD_COMMAND devenv pocketsphinx.sln /build "Release|x64")
    set(POCKETSPHINX_INSTALL_COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/script/copylib_ps.bat)
endif()


ExternalProject_Add(sphinxbase_proj 
    DOWNLOAD_DIR third_party/
	GIT_REPOSITORY https://github.com/cmusphinx/sphinxbase
    SOURCE_DIR third_party/sphinxbase/
    INSTALL_DIR ${third_party_install_path}
    BUILD_IN_SOURCE 1
    CONFIGURE_COMMAND ${SPHINXBASE_CONFIGURE_COMMAND}
    BUILD_COMMAND ${SPHINXBASE_BUILD_COMMAND}
    INSTALL_COMMAND ${SPHINXBASE_INSTALL_COMMAND}
    BUILD_ALWAYS 0
    EXCLUDE_FROM_ALL 1
)


ExternalProject_Add(pocketsphinx_proj 
    DOWNLOAD_DIR third_party/
	GIT_REPOSITORY https://github.com/cmusphinx/pocketsphinx
    SOURCE_DIR third_party/pocketsphinx/
    INSTALL_DIR ${third_party_install_path}
    BUILD_IN_SOURCE 1
    CONFIGURE_COMMAND ${POCKETSPHINX_CONFIGURE_COMMAND}
    BUILD_COMMAND ${POCKETSPHINX_BUILD_COMMAND}
    INSTALL_COMMAND ${POCKETSPHINX_INSTALL_COMMAND}
    BUILD_ALWAYS 0
    EXCLUDE_FROM_ALL 1
    DEPENDS sphinxbase_proj
)



ADD_CUSTOM_TARGET(deps
	DEPENDS sphinxbase_proj pocketsphinx_proj
)