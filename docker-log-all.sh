#!/bin/sh

docker ps -q | xargs -I _ -P 999 docker logs -f _
