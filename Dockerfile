# Dockerfile per server Minecraft con Forge 1.21.1
FROM itzg/minecraft-server:java21

# Imposta variabili d'ambiente per Forge
ENV TYPE=FORGE
ENV FORGE_INSTALLER_URL=https://maven.minecraftforge.net/net/minecraftforge/forge/1.21.1-52.1.3/forge-1.21.1-52.1.3-installer.jar
ENV FORGE_VERSION=1.21.1-52.1.3

# Espone la porta del server Minecraft
EXPOSE 25565

# Volume per i dati persistenti
VOLUME ["/data"]