#!/bin/bash

# Create database/files
if [ ! -e shareddatadirectory/database/files ]; then
  rm -rf shareddatadirectory/database/files
fi
mkdir -p shareddatadirectory/database/files

# Create job_working_directory
if [ -e shareddatadirectory/job_working_directory ]; then
  rm -rf shareddatadirectory/job_working_directory
fi
mkdir -p shareddatadirectory/job_working_directory

# Create config
if [ ! -e shareddatadirectory/config/galaxy.ini ]; then
  # copy sample file to galaxy.ini
  cp shareddatadirectory/config/galaxy.ini.sample shareddatadirectory/config/galaxy.ini
  # file_path
  grep ^file_path shareddatadirectory/config/galaxy.ini
  if [ $? -ne 0 ]; then
    sed -i -e "/^#file_path/a file_path = $PWD/shareddatadirectory/database/files" shareddatadirectory/config/galaxy.ini
  fi
  # job_working_directory
  grep ^job_working_directory shareddatadirectory/config/galaxy.ini
  if [ $? -ne 0 ]; then
    sed -i -e "/^#job_working_directory/a job_working_directory = $PWD/shareddatadirectory/job_working_directory" shareddatadirectory/config/galaxy.ini
  fi
fi


#
GALAXY_TOP_DIR=/home/galaxy/galaxy-15.07
docker run  --net=host --pid=host \
   -v $PWD/shareddatadirectory/tools/alwaysfail:${GALAXY_TOP_DIR}/tools/alwaysfail \
   -v $PWD/shareddatadirectory/tools/alwayssuccess:${GALAXY_TOP_DIR}/tools/alwayssuccess \
   -v $PWD/shareddatadirectory/tools/hellodockergalaxy:${GALAXY_TOP_DIR}/tools/hellodockergalaxy \
   -v $PWD/shareddatadirectory/tools/e1only:${GALAXY_TOP_DIR}/tools/e1only \
   -v $PWD/shareddatadirectory/tools/e2only:${GALAXY_TOP_DIR}/tools/e2only \
   -v $PWD/shareddatadirectory/tools/hellogalaxy:${GALAXY_TOP_DIR}/tools/hellogalaxy \
   -v $PWD/shareddatadirectory/config/tool_conf.xml.sge_different_queue.sample:${GALAXY_TOP_DIR}/config/tool_conf.xml \
   -v $PWD/shareddatadirectory/config/job_conf.xml.sge_different_queue.sample:${GALAXY_TOP_DIR}/config/job_conf.xml \
   -v $PWD/shareddatadirectory/config/galaxy.ini:${GALAXY_TOP_DIR}/config/galaxy.ini \
   -v $PWD/shareddatadirectory/job_working_directory:$PWD/shareddatadirectory/job_working_directory \
   -v $PWD/shareddatadirectory/database/files:$PWD/shareddatadirectory/database/files \
   -v $PWD/act_qmaster:/var/lib/gridengine/default/common/act_qmaster \
   --name manabutgalaxytool -e RUNUSER_UID=10001 -e RUNUSER_GID=10000 -e RUNUSER_USERNAME=manabu \
   -p 8080:8080 --rm manabuishii/docker-galaxy-bit:0.3.0
