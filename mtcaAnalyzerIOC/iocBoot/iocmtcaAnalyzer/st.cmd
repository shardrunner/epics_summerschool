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

cd "${TOP}/iocBoot/${IOC}"
iocInit

# Create monitor sets for your PVs
create_monitor_set("auto_settings.req", 5, "P=$(PREFIX), R=, CH=CH1")

