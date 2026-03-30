# Simulateurs en ligne ARM Cortex-M

- [Simulateur en ligne GIF1001](http://gif1001-sim.gel.ulaval.ca/?sim=nouveau)

- [Simulateur ARM en ligne - CPUTlator](https://cpulator.01xz.net/?sys=arm)

- [Simulateur ARM en ligne - ARMdroid](https://tesla.ce.pdn.ac.lk/arm/armdroid/)


# Jeu d'instructions ARM Cortex-M (M0/M3/M33)

Voici une vue d’ensemble des **mnémoniques ARM ASM** les plus courantes, classées par type d’opérations.  

---

## 1. Instructions de transfert de données

| Instruction | Description |
|------------|-------------|
| `MOV` | Déplacer une valeur dans un registre |
| `MVN` | Déplacer la valeur inversée dans un registre |
| `LDR` | Charger depuis la mémoire vers un registre |
| `STR` | Stocker depuis un registre vers la mémoire |
| `LDRB` / `STRB` | Charger / stocker un octet |
| `LDRH` / `STRH` | Charger / stocker un mot demi-mot (16 bits) |
| `LDRSB` / `LDRSH` | Charger et étendre signé (8 ou 16 bits) |

---

## 2. Instructions arithmétiques et logiques

| Instruction | Description |
|------------|-------------|
| `ADD` | Addition |
| `ADC` | Addition avec retenue |
| `SUB` | Soustraction |
| `SBC` | Soustraction avec retenue |
| `RSB` | Reverse Subtract (soustraction inversée) |
| `CMP` | Comparer (sans stocker le résultat) |
| `CMN` | Compare Negative |
| `AND` | ET logique |
| `ORR` | OU logique |
| `EOR` | XOR logique |
| `BIC` | AND avec complément |
| `MOVS` | Déplacer avec mise à jour des flags |
| `LSL` / `LSR` | Shift logique gauche / droite |
| `ASR` | Shift arithmétique droite |
| `ROR` | Rotation droite |
| `RRC` | Rotation droite avec retenue |

---

## 3. Instructions de contrôle de flux

| Instruction | Description |
|------------|-------------|
| `B` | Branch (saut inconditionnel) |
| `BL` | Branch avec lien (appel de fonction) |
| `BX` | Branch à l’adresse contenue dans un registre |
| `BLX` | Branch avec lien vers registre ou adresse |
| `CBZ` / `CBNZ` | Branch si registre zéro / non zéro (Thumb) |
| `IT` | If-Then (conditionnelle pour instructions suivantes) |
| `NOP` | No Operation |
| `SEV` | Send Event (synchronisation) |
| `WFE` / `WFI` | Wait For Event / Wait For Interrupt |

---

## 4. Instructions de pile et exception

| Instruction | Description |
|------------|-------------|
| `PUSH` | Empiler un ou plusieurs registres |
| `POP` | Dépiler un ou plusieurs registres |
| `MRS` | Lire un registre de statut spécial |
| `MSR` | Écrire dans un registre de statut spécial |
| `SVC` | Supervisor Call (appeler le mode privilégié) |
| `CPSIE` / `CPSID` | Activer / désactiver les interruptions |

---

## 5. Instructions spécifiques Cortex-M

| Instruction | Description |
|------------|-------------|
| `CLZ` | Count Leading Zeros |
| `REV` / `REV16` / `REVSH` | Réverser l’ordre des octets |
| `BKPT` | Breakpoint (pour debug) |
| `NOP` | No Operation |
| `SEV` | Send Event |
| `WFI` / `WFE` | Wait For Interrupt / Wait For Event |

---

> ⚠️ Note : Les Cortex-M0 ont un sous-ensemble plus limité que M3/M33. Certaines instructions comme `CLZ` ou `CPSIE` existent uniquement sur M3/M33.


# Référence complète des mnémoniques ARM Cortex-M (M0, M3, M33)

Cette table couvre les instructions courantes pour les microcontrôleurs comme RP2040 (Cortex-M0) et RP2350 (Cortex-M33).

---

## 1. Transfert de données

| Instruction | Description | Disponible |
|------------|-------------|------------|
| `MOV` | Déplacer une valeur dans un registre | M0/M3/M33 |
| `MVN` | Déplacer la valeur inversée | M0/M3/M33 |
| `LDR` | Charger depuis la mémoire | M0/M3/M33 |
| `STR` | Stocker vers la mémoire | M0/M3/M33 |
| `LDRB` / `STRB` | Charger / stocker un octet | M0/M3/M33 |
| `LDRH` / `STRH` | Charger / stocker un mot demi-mot | M0/M3/M33 |
| `LDRSB` / `LDRSH` | Charger et étendre signé | M3/M33 |
| `PUSH` | Empiler un ou plusieurs registres | M0/M3/M33 |
| `POP` | Dépiler un ou plusieurs registres | M0/M3/M33 |
| `MRS` | Lire un registre spécial (PSR, CONTROL) | M3/M33 |
| `MSR` | Écrire un registre spécial | M3/M33 |

---

## 2. Arithmétique et logique

| Instruction | Description | Disponible |
|------------|-------------|------------|
| `ADD` | Addition | M0/M3/M33 |
| `ADC` | Addition avec retenue | M3/M33 |
| `SUB` | Soustraction | M0/M3/M33 |
| `SBC` | Soustraction avec retenue | M3/M33 |
| `RSB` | Reverse subtract | M0/M3/M33 |
| `CMP` | Comparer (sans stocker) | M0/M3/M33 |
| `CMN` | Compare Negative | M3/M33 |
| `AND` | ET logique | M0/M3/M33 |
| `ORR` | OU logique | M0/M3/M33 |
| `EOR` | XOR logique | M0/M3/M33 |
| `BIC` | AND avec complément | M3/M33 |
| `LSL` / `LSR` | Shift logique gauche / droite | M0/M3/M33 |
| `ASR` | Shift arithmétique droite | M0/M3/M33 |
| `ROR` | Rotation droite | M3/M33 |
| `CLZ` | Count leading zeros | M3/M33 |
| `REV` / `REV16` / `REVSH` | Réverser octets ou demi-mot | M3/M33 |

---

## 3. Contrôle de flux

| Instruction | Description | Disponible |
|------------|-------------|------------|
| `B` | Branch inconditionnel | M0/M3/M33 |
| `BL` | Branch with Link (fonction) | M0/M3/M33 |
| `BX` | Branch vers registre | M3/M33 |
| `BLX` | Branch with Link vers registre | M3/M33 |
| `CBZ` / `CBNZ` | Branch si zéro / non zéro | M0/M3/M33 |
| `IT` | If-Then (instructions conditionnelles) | M3/M33 |
| `NOP` | No Operation | M0/M3/M33 |
| `SEV` | Send Event (synchronisation) | M3/M33 |
| `WFE` / `WFI` | Wait for Event / Wait for Interrupt | M0/M3/M33 |
| `BKPT` | Breakpoint pour débogage | M0/M3/M33 |
| `SVC` | Supervisor Call | M0/M3/M33 |
| `CPSIE` / `CPSID` | Enable / Disable Interrupts | M3/M33 |

---

## 4. Pile et exceptions

| Instruction | Description | Disponible |
|------------|-------------|------------|
| `PUSH` | Empiler registres | M0/M3/M33 |
| `POP` | Dépiler registres | M0/M3/M33 |
| `MRS` | Lire registre de statut | M3/M33 |
| `MSR` | Écrire registre de statut | M3/M33 |
| `SVC` | Appel au mode privilégié | M0/M3/M33 |
| `BKPT` | Breakpoint | M0/M3/M33 |

---

## 5. DMA et périphériques (Cortex-M33 uniquement)

- Gestion fine des interruptions et DMA
- DMA avec jusqu’à **12 canaux indépendants**
- Assignation des périphériques, GPIO et DMA aux **domaines de sécurité**
- Priorité et latence optimisées pour temps réel

---

> ⚠️ Notes :
> - Cortex-M0 : subset minimal (pas de `CLZ`, `BIC`, `REVSH`, `IT`, etc.)
> - Cortex-M3/M33 : instructions étendues et sécurité/privilege support
> - Cortex-M33 : support complet TrustZone et accélérateurs matériels (SHA-256, sécurités DMA)




