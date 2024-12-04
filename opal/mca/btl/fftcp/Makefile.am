#
# Copyright (c) 2004-2005 The Trustees of Indiana University and Indiana
#                         University Research and Technology
#                         Corporation.  All rights reserved.
# Copyright (c) 2004-2020 The University of Tennessee and The University
#                         of Tennessee Research Foundation.  All rights
#                         reserved.
# Copyright (c) 2004-2009 High Performance Computing Center Stuttgart,
#                         University of Stuttgart.  All rights reserved.
# Copyright (c) 2004-2005 The Regents of the University of California.
#                         All rights reserved.
# Copyright (c) 2009-2014 Cisco Systems, Inc.  All rights reserved.
# Copyright (c) 2013      NVIDIA Corporation.  All rights reserved.
# Copyright (c) 2017      IBM Corporation.  All rights reserved.
# Copyright (c) 2022      Amazon.com, Inc. or its affiliates.  All Rights reserved.
# $COPYRIGHT$
#
# Additional copyrights may follow
#
# $HEADER$
#

dist_opaldata_DATA = help-mpi-btl-fftcp.txt

sources = \
    btl_fftcp.c \
    btl_fftcp.h \
    btl_fftcp_addr.h \
    btl_fftcp_component.c \
    btl_fftcp_endpoint.c \
    btl_fftcp_endpoint.h \
    btl_fftcp_frag.c \
    btl_fftcp_frag.h \
    btl_fftcp_hdr.h \
    btl_fftcp_proc.c \
    btl_fftcp_proc.h

# Make the output library in this directory, and name it either
# mca_<type>_<name>.la (for DSO builds) or libmca_<type>_<name>.la
# (for static builds).

if MCA_BUILD_opal_btl_fftcp_DSO
lib =
lib_sources =
component = mca_btl_fftcp.la
component_sources = $(sources)
else
lib = libmca_btl_fftcp.la
lib_sources = $(sources)
component =
component_sources =
endif

mcacomponentdir = $(opallibdir)
mcacomponent_LTLIBRARIES = $(component)
mca_btl_fftcp_la_SOURCES = $(component_sources)
mca_btl_fftcp_la_LDFLAGS = -module -avoid-version

noinst_LTLIBRARIES = $(lib)
libmca_btl_fftcp_la_SOURCES = $(lib_sources)
libmca_btl_fftcp_la_LDFLAGS = -module -avoid-version

mca_btl_fftcp_la_LIBADD = $(top_builddir)/opal/lib@OPAL_LIB_NAME@.la
libmca_btl_fftcp_la_LIBADD =

mca_btl_fftcp_la_CPPFLAGS =
libmca_btl_fftcp_la_CPPFLAGS =
if HAVE_LIBDPDK
    mca_btl_fftcp_la_CPPFLAGS += $(DPDK_CFLAGS)
    mca_btl_fftcp_la_LDFLAGS += $(DPDK_LIBS)
    libmca_btl_fftcp_la_CPPFLAGS += $(DPDK_CFLAGS)
    libmca_btl_fftcp_la_LDFLAGS += $(DPDK_LIBS)
    mca_btl_fftcp_la_LIBADD += $(DPDK_LIBS)
    libmca_btl_fftcp_la_LIBADD += $(DPDK_LIBS) -lrte_net_bond -lcrypto
endif

if HAVE_FSTACK
    mca_btl_fftcp_la_LDFLAGS += $(FSTACK_LIBS)
    libmca_btl_fftcp_la_LDFLAGS += $(FSTACK_LIBS)
endif

