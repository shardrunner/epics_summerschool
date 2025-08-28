#!../../bin/linux-x86_64/mtca

#- SPDX-FileCopyrightText: 2003 Argonne National Laboratory
#-
#- SPDX-License-Identifier: EPICS

#- You may have to change mtca to something else
#- everywhere it appears in this file

< envPaths

cd "${TOP}"

epicsEnvSet("PORT", "MTCAB")
epicsEnvSet("PREFIX", "ADC3117:")

## Register all support components
dbLoadDatabase "dbd/mtca.dbd"
mtca_registerRecordDeviceDriver pdbbase

mtcaScopeConfig("$(PORT)", 0, 12, 0, 0)

## Load record instances
dbLoadRecords("db/mtca.template","P=$(PREFIX),R=")
dbLoadRecords("$(MTCA_SCOPE)/db/mtca-scope-base.template", "PORT=$(PORT),P=$(PREFIX),R=")
dbLoadRecords("$(MTCA_SCOPE)/db/mtca-scope-channel.template", "PORT=$(PORT),ADDR=0,P=$(PREFIX),R=CH,CH=0")
dbLoadRecords("$(MTCA_SCOPE)/db/mtca-scope-channel.template", "PORT=$(PORT),ADDR=1,P=$(PREFIX),R=CH,CH=1")
dbLoadRecords("$(MTCA_SCOPE)/db/mtca-scope-channel.template", "PORT=$(PORT),ADDR=2,P=$(PREFIX),R=CH,CH=2")
dbLoadRecords("$(MTCA_SCOPE)/db/mtca-scope-channel.template", "PORT=$(PORT),ADDR=3,P=$(PREFIX),R=CH,CH=3")

cd "${TOP}/iocBoot/${IOC}"
iocInit

## Start any sequence programs
#seq sncxxx,"user=dev"
