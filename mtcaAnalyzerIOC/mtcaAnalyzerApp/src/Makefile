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

PROD_IOC = mtcaAnalyzer
# mtcaAnalyzer.dbd will be created and installed
DBD += mtcaAnalyzer.dbd

# mtcaAnalyzer.dbd will be made up from these files:
mtcaAnalyzer_DBD += base.dbd
mtcaAnalyzer_DBD += asyn.dbd
mtcaAnalyzer_DBD += calcSupport.dbd
mtcaAnalyzer_DBD += fftw.dbd
mtcaAnalyzer_DBD += mtcaScope.dbd
mtcaAnalyzer_DBD += mtcaTransform.dbd

# Include dbd files from all support applications:
#mtcaAnalyzer_DBD += xxx.dbd

# Add all the support libraries needed by this IOC
#mtcaAnalyzer_LIBS += xxx
mtcaAnalyzer_LIBS += asyn
mtcaAnalyzer_LIBS += calc
mtcaAnalyzer_LIBS += fftwSup
mtcaAnalyzer_LIBS += mtcaScope

# mtcaAnalyzer_registerRecordDeviceDriver.cpp derives from mtcaAnalyzer.dbd
mtcaAnalyzer_SRCS += mtcaAnalyzer_registerRecordDeviceDriver.cpp
mtcaAnalyzer_SRCS += mtcaTransform.cpp

# Build the main IOC entry point on workstation OSs.
mtcaAnalyzer_SRCS_DEFAULT += mtcaAnalyzerMain.cpp
mtcaAnalyzer_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#mtcaAnalyzer_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Finally link to the EPICS Base libraries
mtcaAnalyzer_LIBS += $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

