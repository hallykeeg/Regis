#!/bin/bash

docker run -dit -v $HOME/Backup:/esug/Backup --name esug -p 8000:8000 esug bash
docker exec -d esug screen -Sdm esug ./pharo esug.image restore --no-quit
