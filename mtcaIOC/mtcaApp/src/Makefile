# SPDX-FileCopyrightText: 2003 Argonne National Laboratory
#
# SPDX-License-Identifier: EPICS

TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#=============================
# Build the IOC application

PROD_IOC = mtca
# mtca.dbd will be created and installed
DBD += mtca.dbd

# mtca.dbd will be made up from these files:
mtca_DBD += base.dbd
mtca_DBD += asyn.dbd
mtca_DBD += mtcaScope.dbd

# Include dbd files from all support applications:
#mtca_DBD += xxx.dbd

# Add all the support libraries needed by this IOC
#mtca_LIBS += xxx
mtca_LIBS += asyn
mtca_LIBS += mtcaScope

# mtca_registerRecordDeviceDriver.cpp derives from mtca.dbd
mtca_SRCS += mtca_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
mtca_SRCS_DEFAULT += mtcaMain.cpp
mtca_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#mtca_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Finally link to the EPICS Base libraries
mtca_LIBS += $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

