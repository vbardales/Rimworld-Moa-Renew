# Moa Renew — texts for review

Origin language: English (the upstream Defs, `Mod/Defs/`). The mod ships no English file: the English shown
in game is the origin text itself, so the origin and English columns are identical. French is injected from
`Mod/Languages/French/DefInjected/` (`ThingDef/Moa.xml` and `PawnKindDef/Moa.xml`).

Every text names a species or an egg. No text agrees with a pawn, so no gender switch is used.

| # | Def and field | Origin (English) | English in game | French |
|---|---|---|---|---|
| 1 | ThingDef `Moa` `label` | moa | moa | moa |
| 2 | ThingDef `Moa` `description` | A large flightless bird native to the planet of Reach, known for its tasty meat. It has been long domesticated, but also lives in the wild. | same | Un grand oiseau incapable de voler, originaire de la planète Reach et réputé pour sa viande savoureuse. Domestiqué depuis longtemps, il vit également à l'état sauvage. |
| 3 | ThingDef `Moa` `race.meatLabel` | moa meat | moa meat | viande de moa |
| 4 | ThingDef `Moa` tool `claws` `label` | claws | claws | griffes |
| 5 | ThingDef `Moa` tool `beak` `label` | beak | beak | bec |
| 6 | ThingDef `Moa` tool `head` `label` | head | head | tête |
| 7 | PawnKindDef `Moa` `label` | moa | moa | moa |
| 8 | ThingDef `EggMoaFertilized` `label` | moa egg (fert.) | moa egg (fert.) | œuf de moa (fécondé) |
| 9 | ThingDef `EggMoaFertilized` `description` | A fertilized moa egg. If all goes well, it should hatch into a baby moa. It can be eaten raw, but it's much better cooked. | same | Un œuf de moa fécondé. Si tout se passe bien, un petit moa devrait en sortir. Il peut être mangé cru, mais il est bien meilleur une fois cuit. |
| 10 | ThingDef `EggMoaUnfertilized` `label` | moa egg (unfert.) | moa egg (unfert.) | œuf de moa (non fécondé) |
| 11 | ThingDef `EggMoaUnfertilized` `description` | An unfertilized moa egg. It can be eaten raw, but it's much, much better cooked. | same | Un œuf de moa non fécondé. Il peut être mangé cru, mais il est bien meilleur une fois cuit. |

## Points to decide

- **#2, #9** — masculine by the species noun (`il vit`, `un petit moa`), not by a pawn. Reword only if the
  rule wants an epicene wording for animals.
- **#8, #10** — the English abbreviates (`fert.`, `unfert.`), the French spells out (`fécondé`,
  `non fécondé`). The English is the upstream wording; say if the abbreviations should go too.
- **#11** — the English says `much, much better cooked`; the French says `bien meilleur` once. The doubling is lost.
- **#2** — `long domesticated` (English) reads `Domestiqué depuis longtemps` (French); the English `also lives
  in the wild` reads `il vit également à l'état sauvage`.
