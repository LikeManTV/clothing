# CLOTHING
[![GitHub release](https://img.shields.io/github/v/release/LikeManTV/clothing.svg)](https://github.com/LikeManTV/clothing/releases/latest)
[![GitHub license](https://img.shields.io/github/license/LikeManTV/clothing.svg)](LICENSE)
<a href="https://discordapp.com/invite/54jH2Uu7tc" title="Chat on Discord"><img alt="Discord Status" src="https://discordapp.com/api/guilds/912329245789933569/widget.png"></a>

A clothing system for FiveM.

Please report any problems by creating a new issue or join the Discord server.
Also feel free to make a PR.

## Features
- Supports ESX & QB
- Clothes as items (using metadata)
- Menu for taking off clothes
  - Context menu
  - Radial menu
- Torso and arm clipping fix
- Option to fix mask and hat clipping issues
  - Whitelist / blacklist for certain IDs
- Functional gear (Night vision, etc..)
- Special clothing/outfits
- Outfit renaming
- Tearing clothes
- Commands for faster usage
- Localization
- Customizable notifications
 
## Dependencies
- [ox_lib](https://github.com/overextended/ox_lib)
- [ox_inventory](https://github.com/overextended/ox_inventory)
- esx_skin & skinchanger / [fivem-appearance](https://github.com/pedr0fontoura/fivem-appearance) / [illenium-appearance](https://github.com/iLLeniumStudios/illenium-appearance) / [qb-clothing](https://github.com/qbcore-framework/qb-clothing)

## Installation
1. Download latest release or source code
2. Extract the .zip file
3. Copy the folder to your server resources folder
4. Add `ensure clothing` to your server.cfg
5. Restart the server

## Exports (client)
- `isWearingOutfit(name)` - returns outfit name and outfit label or false
- `isWearing(index)` - returns component and texture or false
- `isWearingProp(index)` - returns prop and texture or false
- `isNaked()` - returns true if player doesn't have any clothes based on the config
- `getPedSex(ped)` - returns 'Male' or 'Female' regarding the ped gender

## Exports (server)
