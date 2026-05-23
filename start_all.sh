#!/bin/bash

echo "--- Starting all Docker services ---"
echo ""

echo "-> Starting Pi-hole..."
cd /home/trent/docker/pihole
docker compose up -d

echo "-> Starting Jellyfin..."
cd /home/trent/docker/jellyfin
docker compose up -d

echo "-> Starting Nginx Proxy Manager..."
cd /home/trent/docker/npm
docker compose up -d

echo "-> Starting Media Stack (qBittorrent, Sonarr, Radarr...)..."
cd /home/trent/docker/media-stack
docker compose up -d

echo "-> Starting Duplicati..."
cd /home/trent/docker/duplicati
docker compose up -d

echo "-> Starting Glance Dashboard..."
cd /home/trent/docker/glance
docker compose up -d

echo ""
echo "--- All services have been started. ---"
echo "Run 'docker ps' to check their status."
