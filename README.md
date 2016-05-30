# docker-galaxy-bit
Galaxy Docker Container

version 0.2.0

```
docker run -e RUNUSER_UID=10000 -e RUNUSER_GID=10000  -p 8080:8080 --rm manabuishii/docker-galaxy-bit:0.2.0
```

# TEST YOUR OWN TOOL

```
docker run -v $PWD/shareddatadirectory/hellogalaxy:/tmp/hellogalaxy -v $PWD/shareddatadirectory/tools/hellogalaxy:/home/galaxy/galaxy-15.07/tools/hellogalaxy -v $PWD/shareddatadirectory/config/tool_conf.xml:/home/galaxy/galaxy-15.07/config/tool_conf.xml -e RUNUSER_UID=10000 -e RUNUSER_GID=10000  -p 8080:8080 --rm manabuishii/docker-galaxy-bit:0.2.0
```
