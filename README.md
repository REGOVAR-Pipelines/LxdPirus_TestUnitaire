# Lxd Pirus TestUnitaire pipeline

This pipeline do almost nothing, it's used by Pirus unit tests to test the lxd container manager. 

This document explain you how to build it.

## Requirement
 * You need LXD on your computer to create it
 * You should read the official doc of Pirus

## Instructions

    git clone https://github.com/REGOVAR-Pipelines/LxdPirus_TestUnitaire.git
    make install
   
If the make instruction run without error, it will create the pirus pipeline image : LxdPirus_TestUnitaire.tar.xz
You can then use it on your server to run TU (have a look to the Pirus/pirus/tests/core/test_core_lxdmanager.py to set the path where is the image).
You can also use this 


