# pico-assembly

# Microcontrôleurs Raspberry Pi : RP2040 et RP2350

[Voir le jeu d'instructions ARM](instructionSet.md)


## RP2040

Le **RP2040** est le premier microcontrôleur conçu par Raspberry Pi, introduit en 2021. Il est notamment utilisé dans la carte Raspberry Pi Pico.

# Aperçu du RP2040

![Vue d'ensemble du RP2040](images/rp2040-overview.png)

> Figure : Schéma des principales caractéristiques et périphériques du microcontrôleur RP2040.


### Caractéristiques principales

- **CPU** : Double cœur ARM Cortex-M0+ (jusqu’à 133 MHz)
- **Mémoire SRAM** : 264 Ko
- **Mémoire Flash** : Externe (QSPI, typiquement 2 Mo ou plus selon la carte)
- **GPIO** : 30 broches multifonctions
- **Interfaces** :
  - 2 × UART
  - 2 × SPI
  - 2 × I2C
  - USB 1.1 (device ou host)
- **Périphériques spéciaux** :
  - **PIO (Programmable I/O)** : 2 blocs PIO, chacun contenant 4 machines d’état (soit 8 machines d’état au total)
  - Timer et PWM
- **ADC** : 12 bits (4 entrées + capteur température interne)
- **Fabrication** : Gravure en 40 nm
- **Consommation** : Faible, adapté aux systèmes embarqués

### Points forts

- Très flexible grâce aux blocs **PIO**
- Coût très bas
- Large support logiciel (C/C++ SDK, MicroPython, etc.)

---

# Microcontrôleur RP2350

Le **RP2350** est un microcontrôleur récent de Raspberry Pi, conçu pour offrir des performances élevées et des fonctionnalités de sécurité avancées.

# Aperçu du RP2350

![Vue d'ensemble du RP2350](images/rp2350-overview.png)

> Figure : Schéma des principales caractéristiques et périphériques du microcontrôleur RP2350.

## 1. Processeur

- **CPU** : Dual ARM Cortex-M33 ou dual Hazard3 RISC-V
- **Fréquence maximale** : 150 MHz

## 2. Mémoire

- **SRAM intégrée** : 520 Ko, répartie en 10 banques indépendantes
- **Mémoire externe** : support jusqu’à 16 Mo de Flash/PSRAM via bus QSPI dédié
- **Extension** : 16 Mo supplémentaires accessibles via un second chip-select optionnel

## 3. Périphériques

- **UART** : 2
- **SPI** : 2 contrôleurs
- **I2C** : 2 contrôleurs
- **PWM** : 24 canaux
- **ADC** : 4 ou 8 canaux
- **USB** : 1 contrôleur USB 1.1 + PHY, support hôte et device
- **PIO (Programmable I/O)** : 12 machines d’état au total

## 4. Sécurité

- Signature optionnelle du boot enforceée par le mask ROM, avec empreinte de clé dans l’OTP
- Stockage OTP protégé pour clé de déchiffrement de boot optionnelle
- Filtrage global des bus selon niveaux de sécurité/privilege (ARM ou RISC-V)
- Assignation individuelle des périphériques, GPIO et canaux DMA aux domaines de sécurité
- Mitigations matérielles contre les attaques par injection de faute
- Accélérateur matériel SHA-256

## 5. Points forts

- Performances accrues par rapport au RP2040
- Sécurité matérielle avancée pour applications critiques
- Flexibilité élevée grâce aux PIO et à la gestion fine des DMA et périphériques
- Support possible pour des architectures dual-core ARM ou RISC-V


---

## Comparaison rapide

| Caractéristique | RP2040 | RP2350 |
|----------------|--------|--------|
| CPU | 2× Cortex-M0+ | Cortex-M33 / RISC-V |
| Fréquence | ~133 MHz | Plus élevée |
| SRAM | 264 Ko | Supérieure |
| PIO | Oui | Amélioré |
| Sécurité | Basique | Avancée (TrustZone) |
| Usage typique | Projets embarqués simples à intermédiaires | Projets avancés / industriels |


# Installation de l'environnement pour Raspberry Pi Pico

## 1. Installer les outils nécessaires

```bash
sudo apt update
sudo apt install cmake gcc-arm-none-eabi build-essential git
```

## 2. Installer le SDK officiel du Pico

```bash
cd ~
git clone https://github.com/raspberrypi/pico-sdk.git
```

## 3. Initialiser les dépendances (IMPORTANT)

```bash
cd pico-sdk
git submodule update --init
```

## 4. Définir la variable d’environnement

Ouvrir le fichier :

```bash
nano ~/.bashrc
```

Ajouter la ligne suivante :

```bash
export PICO_SDK_PATH=~/pico-sdk
```

Appliquer les modifications :

```bash
source ~/.bashrc
```

Vérifier :

```bash
echo $PICO_SDK_PATH
```
---

# Compiler un projet Raspberry Pi Pico

## 1. Préparer le projet

Dans le répertoire du projet :

Créer ou modifier le fichier :

```bash
nano pico_sdk_import.cmake
```

Ajouter la ligne suivante :

```cmake
include($ENV{PICO_SDK_PATH}/external/pico_sdk_import.cmake)
```

Sauvegarder le fichier.

## 2. Structure minimale du projet

Le projet doit contenir :

- `CMakeLists.txt`
- `main.S`
- `pico_sdk_import.cmake`

## 3. Compiler le projet

```bash
mkdir build
cd build
cmake ..
make
```

## 4. Compiler en mode debug

```bash
rm -rf build
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Debug ..
make
```
---

# Installation de OpenOCD et GDB pour Raspberry Pi Pico

## 1. Installer les dépendances

```bash
sudo apt install libjim-dev pkg-config
sudo apt install libhidapi-dev libusb-1.0-0-dev
sudo apt install gdb-multiarch
```

## 2. Installer OpenOCD (version Raspberry Pi)

```bash
cd pico-sdk/
git clone https://github.com/raspberrypi/openocd.git
cd openocd
git submodule update --init --recursive
./bootstrap
./configure --enable-internal-jimtcl
make -j$(nproc)
sudo make install
```

## 3. Configurer les règles udev

Créer le fichier :

```bash
sudo nano /etc/udev/rules.d/99-picoprobe.rules
```

Ajouter la ligne suivante :

```bash
SUBSYSTEM=="usb", ATTR{idVendor}=="2e8a", MODE="0666"
```

Recharger les règles :

```bash
sudo udevadm control --reload-rules
sudo udevadm trigger
```

## 4. Tester OpenOCD

```bash
openocd -f interface/cmsis-dap.cfg -f target/rp2040.cfg -c "gdb_memory_map disable" -c "init"
```
---

# GDB Cheat Sheet pour RP2040 (ARM Cortex-M0+)


executer gdb avec le fichier uf2 compilé
```gdb
gdb-multiarch hello_asm.elf
```


## 🔹 Connexion au RP2040 via OpenOCD
```gdb
target extended-remote localhost:3333   # se connecter au serveur GDB
monitor reset halt                      # reset et halt CPU
```

---

## 🔹 Gestion des breakpoints

### 1. Breakpoint sur un label
```gdb
break loop         # s'arrête à l'adresse du label 'loop' lors de la prochaine itération
break main         # s'arrête sur 'main'
```

### 2. Breakpoint sur une adresse exacte
```gdb
break *0x10000322  # s'arrête à l'adresse spécifique
break *$pc         # s'arrête à l'instruction courante
```

### 3. Watchpoint sur un registre ou variable
```gdb
watch $r7          # s'arrête quand R7 change
```

---

## 🔹 Exécution / Contrôle

```gdb
continue           # continue l'exécution jusqu'au prochain breakpoint
step               # exécute l'instruction suivante (step over source-level)
next               # exécute l'instruction suivante sans rentrer dans les fonctions
stepi (si)         # exécute 1 instruction assembleur (step instruction)
```

---

## 🔹 Inspection des instructions et registres

### Instructions
```gdb
x/i $pc            # affiche l'instruction courante sans exécuter
x/5i $pc           # affiche 5 instructions à partir du PC
x/i 0x10000322     # affiche l'instruction à une adresse spécifique
```

### Registres
```gdb
info registers     # affiche tous les registres
print $r0          # affiche le registre R0
```

---

## 🔹 Inspection de la mémoire

```gdb
x/s $r0            # affiche la chaîne pointée par R0
x/10x 0x20041f40   # affiche 10 mots mémoire à l'adresse donnée
```

---

## 🔹 Manipulation du PC (Program Counter)

```gdb
set $pc = 0x10000000   # redémarre le programme à une adresse spécifique
```

---

## 🔹 Conseils pour boucles infinies

- Placer les breakpoints **avant** de continuer (`continue`)  
- Utiliser `watch $r7` pour observer le compteur dans la boucle  
- `stepi` pour avancer instruction par instruction  

---

## 🔹 Flow typique pour debugger RP2040

```gdb
monitor reset halt       # reset CPU
break loop               # breakpoint sur le label loop
continue                 # exécute jusqu'au breakpoint
x/i $pc                  # inspecte l'instruction courante
info registers           # inspecte les registres
stepi                    # exécute 1 instruction
x/s $r0                  # inspecte la chaîne pointée par R0
watch $r7                # observe le compteur
```

---


# Guide rapide GDB TUI (Text User Interface)

Ce guide permet d’utiliser l’interface semi-graphique intégrée dans GDB pour un debug plus visuel sans IDE graphique.

---

1. Lancer GDB avec ton programme

gdb hello_asm.elf

---

2. Commandes principales `layout`

Commande       | Description
---------------|-----------------------------------------------------
layout asm     | Affiche la fenêtre du désassemblage (instructions)
layout regs    | Affiche la fenêtre des registres CPU
layout src     | Affiche la fenêtre du code source
layout split   | Affiche code source + désassemblage
layout next    | Passe à la mise en page suivante (cycle entre modes)
layout prev    | Revient à la mise en page précédente
layout info    | Affiche l’état actuel du layout TUI

---

3. Commandes clavier utiles en mode TUI

Raccourci              | Effet
-----------------------|------------------------------------------------
Ctrl + x puis a        | Active ou désactive l’interface TUI
Ctrl + x puis 2        | Divise la fenêtre en deux (split)
Ctrl + x puis o        | Change le focus entre les fenêtres

---

4. Commandes GDB utiles dans TUI

Commande          | Description
-----------------|---------------------------------------------------
break loop        | Placer un breakpoint sur le label `loop`
continue          | Continuer l’exécution jusqu’au breakpoint
step              | Exécuter ligne source par ligne
stepi             | Exécuter instruction par instruction
next              | Exécuter ligne source suivante (sans entrer dans les appels)
nexti             | Exécuter instruction suivante (sans entrer dans les appels)
info registers    | Afficher les registres CPU
x/i $pc           | Afficher l’instruction courante

---

5. Astuces

- Après un `stepi` ou `nexti`, les fenêtres TUI se mettent à jour automatiquement.
- Utilise `layout split` pour voir source et asm simultanément, très pratique sur du code embarqué.
- Ctrl + c interrompt une exécution continue.

---

6. Exemple de session simple

(gdb) layout split
(gdb) break loop
(gdb) continue
(gdb) stepi
(gdb) info registers

---





