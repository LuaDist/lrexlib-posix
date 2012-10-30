# Copyright (C) 2007-2012 LuaDist.
# Created by Peter Kapec, Peter Drahos
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

project ( lrexlib-posix C )
cmake_minimum_required ( VERSION 2.8 )
include ( cmake/dist.cmake )
include ( lua )

add_definitions ( -DVERSION=\"${DIST_VERSION}\" )

# Use RXSpencer on Windows
if ( WIN32 AND NOT CYGWIN )
  add_definitions ( -Doff_t=_off_t )
  find_package ( RXSpencer REQUIRED )
  include_directories ( ${RXSPENCER_INCLUDE_DIRS} )
  if ( MSVC )
    add_definitions ( "-DREX_API=__declspec(dllexport)" )
  endif ( )
endif ( )

install_lua_module ( rex_posix 
  src/common.c
  src/posix/lposix.c
  LINK ${RXSPENCER_LIBRARIES} )
