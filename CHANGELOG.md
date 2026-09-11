# Changelog

Format inspired by [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).
This file serves the repository and the writing of Steam patch notes; RimWorld does not display it
in game.

## [1.0.0] — unreleased

On release: create the `v1.0.0` tag and the matching GitHub release.

First release of the 1.6 update of **Moa**, by Poshspider, updated through 1.3 by dninemfive, with
textures by Serpyderpy.

### Added

- Support for RimWorld 1.6.
- `EggMoaUnfertilized`. The mod declared only its fertilized egg, which 1.3 tolerated. In 1.6
  `CompEggLayer` builds `eggUnfertilizedDef` as soon as an animal lays without having been
  fertilized, and throws if the field is null — an in-game exception on a bird that lays every two
  days. The new def carries the fertilized egg's market value and colour.
- `LICENSE`, the upstream MIT notice, which is what MIT asks in exchange for redistribution.

### Changed

- **`wildness` moved to `<Wildness>` under `statBases`.** It stopped being a field of
  `RaceProperties` in 1.6 and became a StatDef. The old form is not an error, it is simply not
  read, and the stat's default is `-1` — outside the range the game uses, so the bird tames for
  almost nothing. The author's comparison comment is preserved on the line that moved.

### Removed

- The mod's own older copy of the bird, `Common/Defs/Races_Animal_Moa.xml`. Since 1.5 RimWorld
  loads a `Common` folder by default and also falls back to the highest version folder available,
  so both copies would have loaded and declared `Moa` twice. The `LoadFolders.xml` that would have
  arbitrated shipped renamed to `.disabled`.

### Notes

No balance value was changed. One defect inherited from the original is left in place on purpose
and documented in `ATTRIBUTION.md`: the dessicated moa corpse uses the emu's texture.
