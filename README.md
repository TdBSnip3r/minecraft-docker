# 🎮 Minecraft Forge Server Docker

Un server Minecraft con Forge 1.21.1 completamente configurato e pronto all'uso tramite Docker Compose.

## ✨ Caratteristiche

- **Minecraft Forge 1.21.1** con versione 52.1.3
- **Configurazione automatica** tramite environment variables
- **Nessuna whitelist** - accesso libero per tutti
- **Modalità offline** - nessuna autenticazione richiesta
- **RCON abilitato** per amministrazione remota
- **Volumi persistenti** per dati del server
- **Supporto mod e plugin**

## 🚀 Avvio Rapido

### Prerequisiti
- Docker e Docker Compose installati
- Porta 25565 libera

### Avvio del Server
```bash
# Clona o scarica il progetto
cd minecraft-docker

# Avvia il server
docker-compose up -d

# Controlla i log
docker-compose logs -f minecraft
```

### Connessione
- **Indirizzo**: `localhost:25565`
- **Modalità**: Offline (nessuna autenticazione)
- **Whitelist**: Disabilitata

## ⚙️ Configurazione

### Environment Variables Principali

```yaml
environment:
  # Configurazioni essenziali
  - EULA=true                    # Accetta l'EULA
  - MEMORY=4G                    # Memoria allocata
  - TYPE=FORGE                   # Tipo server (Forge)
  - FORGE_VERSION=1.21.1-52.1.3  # Versione Forge
  
  # Configurazioni del server
  - ONLINE_MODE=false            # Modalità offline
  - ENABLE_WHITELIST=false       # Whitelist disabilitata
  - ENFORCE_WHITELIST=false      # Nessuna forzatura whitelist
```

### Personalizzazione

Per modificare le configurazioni del server, edita il file `docker-compose.yml`:

```yaml
environment:
  - MAX_PLAYERS=20               # Numero massimo giocatori
  - DIFFICULTY=normal            # Difficoltà (peaceful/easy/normal/hard)
  - GAMEMODE=survival           # Modalità gioco (survival/creative/adventure)
  - MOTD=Il Mio Server          # Messaggio del giorno
  - VIEW_DISTANCE=10            # Distanza di rendering
  - SIMULATION_DISTANCE=10      # Distanza di simulazione
```

## 📁 Struttura Progetto

```
minecraft-docker/
├── docker-compose.yml    # Configurazione principale
├── Dockerfile           # Immagine personalizzata
├── mods/               # Directory per i mod (montata in /data/mods)
├── plugins/            # Directory per i plugin (montata in /data/plugins)
└── README.md           # Questo file
```

## 🛠️ Comandi Utili

### Gestione Server
```bash
# Avvia il server
docker-compose up -d

# Ferma il server
docker-compose down

# Riavvia il server
docker-compose restart minecraft

# Visualizza i log
docker-compose logs -f minecraft

# Accesso alla console del server
docker-compose exec minecraft rcon-cli
```

### Backup e Restore
```bash
# Backup dei dati
docker-compose exec minecraft tar -czf /data/backup-$(date +%Y%m%d).tar.gz -C /data world server.properties

# Copia backup fuori dal container
docker cp minecraft-forge-server:/data/backup-20240101.tar.gz ./
```

## 🔧 Amministrazione

### RCON (Remote Console)
- **Porta**: 25575
- **Password**: `changeme123` (modificabile in docker-compose.yml)
- **Comando**: `docker-compose exec minecraft rcon-cli`

### Comandi RCON Utili
```
/whitelist add <player>     # Aggiungi giocatore alla whitelist
/whitelist remove <player>  # Rimuovi giocatore dalla whitelist
/op <player>               # Rendi operatore
/deop <player>             # Rimuovi operatore
/kick <player>             # Espelli giocatore
/ban <player>              # Banna giocatore
```

## 📦 Mod e Plugin

### Aggiungere Mod
1. Scarica i file `.jar` dei mod
2. Copiali nella cartella `mods/`
3. Riavvia il server: `docker-compose restart minecraft`

### Aggiungere Plugin
1. Scarica i file `.jar` dei plugin
2. Copiali nella cartella `plugins/`
3. Riavvia il server: `docker-compose restart minecraft`

## 🔒 Sicurezza

### Modificare Password RCON
```yaml
environment:
  - RCON_PASSWORD=nuova_password_sicura
```

### Abilitare Whitelist (Opzionale)
```yaml
environment:
  - ENABLE_WHITELIST=true
  - ENFORCE_WHITELIST=true
```

### Abilitare Autenticazione Online
```yaml
environment:
  - ONLINE_MODE=true
```

## 🐛 Risoluzione Problemi

### Server Non Si Avvia
```bash
# Controlla i log per errori
docker-compose logs minecraft

# Verifica che la porta 25565 sia libera
netstat -tulpn | grep 25565
```

### Problemi di Connessione
- Verifica che il server sia in esecuzione: `docker-compose ps`
- Controlla i log: `docker-compose logs minecraft`
- Assicurati che la whitelist sia disabilitata

### Problemi di Memoria
```yaml
# Aumenta la memoria allocata
environment:
  - MEMORY=6G  # o 8G per server più grandi
```

## 📊 Monitoraggio

### Statistiche Server
```bash
# Utilizzo risorse
docker stats minecraft-forge-server

# Spazio disco
docker-compose exec minecraft df -h /data
```

### Log in Tempo Reale
```bash
# Segui i log del server
docker-compose logs -f minecraft

# Filtra solo gli errori
docker-compose logs minecraft | grep ERROR
```

## 🔄 Aggiornamenti

### Aggiornare Forge
1. Modifica `FORGE_VERSION` in `docker-compose.yml`
2. Ricostruisci l'immagine: `docker-compose build --no-cache`
3. Riavvia: `docker-compose up -d`

### Aggiornare Minecraft
1. Modifica `MINECRAFT_VERSION` in `docker-compose.yml`
2. Aggiorna `FORGE_VERSION` di conseguenza
3. Ricostruisci e riavvia

## 📝 Note

- **Dati persistenti**: Tutti i dati del server sono salvati nel volume `minecraft_data`
- **Backup automatico**: I dati persistono tra i riavvii del container
- **Performance**: Per server con molti giocatori, considera di aumentare la memoria
- **Mod**: Assicurati che i mod siano compatibili con Forge 1.21.1-52.1.3

## 🤝 Supporto

Per problemi o domande:
1. Controlla i log del server
2. Verifica la configurazione in `docker-compose.yml`
3. Consulta la documentazione di [itzg/minecraft-server](https://github.com/itzg/docker-minecraft-server)

---

**Buon divertimento con il tuo server Minecraft! 🎮**