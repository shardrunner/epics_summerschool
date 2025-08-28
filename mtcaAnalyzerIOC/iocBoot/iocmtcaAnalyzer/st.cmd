#!../../bin/linux-x86_64/mtcaAnalyzer

#- SPDX-FileCopyrightText: 2003 Argonne National Laboratory
#-
#- SPDX-License-Identifier: EPICS

#- You may have to change mtcaAnalyzer to something else
#- everywhere it appears in this file

< envPaths

cd "${TOP}"

epicsEnvSet("PORT", "MTCAB")
epicsEnvSet("PREFIX", "ADC3117:")
epicsEnvSet("IOC", "LINSTAT")
epicsEnvSet("LINSTAT", "/epics/support/linstat")

## Register all support components
dbLoadDatabase "dbd/mtcaAnalyzer.dbd"
mtcaAnalyzer_registerRecordDeviceDriver pdbbase

## Load record instances
dbLoadRecords("db/mtcaChannelTransform.template", "PORT=$(PORT),ADDR=0,P=$(PREFIX),R=CH,CH=0")
dbLoadRecords("db/mtcaChannelTransform.template", "PORT=$(PORT),ADDR=1,P=$(PREFIX),R=CH,CH=1")
dbLoadRecords("db/mtcaChannelTransform.template", "PORT=$(PORT),ADDR=2,P=$(PREFIX),R=CH,CH=2")
dbLoadRecords("db/mtcaChannelTransform.template", "PORT=$(PORT),ADDR=3,P=$(PREFIX),R=CH,CH=3")
dbLoadRecords("db/mtcaTransform.template", "PORT=$(PORT),ADDR=3,P=$(PREFIX),R=")

# Autosave
# Set the directory for save files
set_savefile_path("$(TOP)/as/save")

# Set the directory for request files  
set_requestfile_path("$(TOP)/as/req")

#set_pass0_restoreFile("", "")
set_pass1_restoreFile("auto_settings.sav", "P=$(PREFIX), R=, CH=CH1")

# System-wide information
dbLoadRecords("/epics/support/linStat/db/linStatHost.db","IOC=$(IOC)")

# IOC process specific information
dbLoadRecords("/epics/support/linStat/db/linStatProc.db","IOC=$(IOC)")

# Network interface information
dbLoadRecords("/epics/support/linStat/db/linStatNIC.db","IOC=$(IOC),NIC=lo")
# may repeat with different NIC= network interface name(s)
#dbLoadRecords("/epics/support/linStat/db/linStatNIC.db","IOC=$(IOC),NIC=eth0")

# File system mount point information
dbLoadRecords("/epics/support/linStat/db/linStatFS.db","P=$(IOC):ROOT,DIR=/")
# may repeat with different file system mount points
# change both P= and DIR=
#dbLoadRecords("/epics/support/linStat/db/linStatFS.db","P=$(IOC):DATA,DIR=/data")


cd "${TOP}/iocBoot/${IOC}"
iocInit

# Create monitor sets for your PVs
create_monitor_set("auto_settings.req", 5, "P=$(PREFIX), R=, CH=CH1")

