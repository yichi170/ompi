# -*- shell-script -*-
#
# Copyright (c) 2004-2005 The Trustees of Indiana University and Indiana
#                         University Research and Technology
#                         Corporation.  All rights reserved.
# Copyright (c) 2004-2005 The University of Tennessee and The University
#                         of Tennessee Research Foundation.  All rights
#                         reserved.
# Copyright (c) 2004-2005 High Performance Computing Center Stuttgart,
#                         University of Stuttgart.  All rights reserved.
# Copyright (c) 2004-2005 The Regents of the University of California.
#                         All rights reserved.
# Copyright (c) 2010-2016 Cisco Systems, Inc.  All rights reserved.
# Copyright (c) 2016      Los Alamos National Security, LLC. All rights
#                         reserved.
# Copyright (c) 2022      Amazon.com, Inc. or its affiliates.  All Rights reserved.
# $COPYRIGHT$
#
# Additional copyrights may follow
#
# $HEADER$
#

# MCA_btl_fftcp_CONFIG([action-if-found], [action-if-not-found])
# -----------------------------------------------------------
AC_DEFUN([MCA_opal_btl_fftcp_CONFIG], [
    AC_CONFIG_FILES([opal/mca/btl/fftcp/Makefile])
    PKG_CHECK_MODULES_STATIC([DPDK], [libdpdk >= 21.11], [
        AC_MSG_NOTICE([DPDK found, enabling fftcp with DPDK support.])
        opal_btl_fftcp_happy=yes
        HAVE_LIBDPDK=1
	btl_fftcp_WRAPPER_EXTRA_LIBS="$DPDK_STATIC_LIBS -lrte_net_bond -lcrypto"
	CPPFLAGS="$CPPFLAGS $DPDK_LIBS -lrte_net_bond -lcrypto"
    ], [
        AC_MSG_WARN([DPDK not found, disabling fftcp BTL component.])
        opal_btl_fftcp_happy=no
        HAVE_LIBDPDK=0
    ])

    AC_SUBST([DPDK_CFLAGS])
    AC_SUBST([DPDK_LIBS])
    AC_SUBST([DPDK_STATIC_LIBS])

    AC_CHECK_HEADER([ff_api.h], [
        AC_MSG_NOTICE([f-stack headers found. Enabling f-stack support.])
        HAVE_FSTACK=1
	FSTACK_LIBS="-L/usr/local/lib -lfstack"
    ], [
        AC_MSG_WARN([f-stack headers not found, disabling f-stack support.])
        HAVE_FSTACK=0
	FSTACK_LIBS=""
    ])

    OPAL_SUMMARY_ADD([Transports], [FFTCP], [], [$opal_btl_fftcp_happy])

    AC_SUBST([HAVE_LIBDPDK])
    AC_SUBST([HAVE_FSTACK])
    AC_SUBST([FSTACK_LIBS])

    AM_CONDITIONAL([HAVE_LIBDPDK], [test "x$HAVE_LIBDPDK" = "x1"])
    AM_CONDITIONAL([HAVE_FSTACK], [test "x$HAVE_FSTACK" = "x1"])
])dnl

