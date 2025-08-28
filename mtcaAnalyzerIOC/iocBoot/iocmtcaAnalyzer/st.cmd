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


cd "${TOP}/iocBoot/${IOC}"
iocInit


