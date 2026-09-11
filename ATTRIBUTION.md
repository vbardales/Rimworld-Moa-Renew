# Moa — what was taken, and what was changed

## Source

| | |
|---|---|
| Mod | Moa |
| Original author | Poshspider |
| Update through 1.3 | dninemfive |
| Textures | Serpyderpy |
| Workshop | [1746450702](https://steamcommunity.com/sharedfiles/filedetails/?id=1746450702) |
| Last version supported | 1.3 |
| Licence | MIT — see `LICENSE` |

The upstream `LICENSE` is MIT, copyright dninemfive 2021. That notice ships with this mod, which
is what MIT asks in exchange for redistribution.

## What was taken

| File | Origin |
|---|---|
| `Defs/Races_Animal_Moa.xml` | `1.3/Defs/Races_Animal_Moa.xml` |
| `Defs/Items_Eggs_Moa.xml` | `Common/Defs/Items_Eggs_Moa.xml`, unchanged |
| `Textures/Things/Pawn/Animal/Moa_Serpy/*` | unchanged, three files |

`Defs/Items_MoaEggUnfertilized.xml` is new — see below.

## What was left behind

`Common/Defs/Races_Animal_Moa.xml`: the mod's own older copy of the bird, kept for 1.1 and 1.2.

This is not tidiness, it is a real defect on 1.6. Since 1.5 RimWorld loads a `Common` folder by
default **and** falls back to the highest version folder at or below the running version. Both
copies would therefore have loaded, declaring `Moa` twice. The mod shipped a
`LoadFolders.xml.disabled` — the file that would have arbitrated between them, renamed out of use
by its own author.

## What was changed

### `wildness` is a stat now, not a race field

```xml
<!-- before, in <race> -->
<wildness>0.45</wildness>						<!-- emu: 0.95 -->

<!-- after, in <statBases> -->
<Wildness>0.45</Wildness>						<!-- emu: 0.95 -->
```

In 1.6 `wildness` left `RaceProperties` and became a `Wildness` **StatDef**. The old field is not
an error, it is simply not read: the value falls back to the stat's default, which Ludeon set to
`-1`, outside the `[0, 1]` the game uses, precisely so an animal that lost its value is
conspicuous. The moa's whole point is that it is tamer than an emu; losing the number loses the
mod.

The author's comparison comments are preserved, including on the line that moved.

### The unfertilized egg had to be written

`Races_Animal_Moa.xml` declared `eggFertilizedDef` and nothing else. Up to 1.3 that was tolerated.
In 1.6:

```csharp
// CompEggLayer, on laying without fertilization
Thing thing = ThingMaker.MakeThing(Props.eggUnfertilizedDef);
```

A null `eggUnfertilizedDef` throws there, in game, on a bird laying every two days whether or not
anyone asked. `EggMoaUnfertilized` is a new def on `EggUnfertBase`, carrying the fertilized egg's
market value (26) and the same blue-grey tint. It is the only def in this mod that is not the
original authors'.

### Nothing else

No stat, no biome weight, no life stage, no tool, no texture.

## Known limitation, inherited and left alone

The moa's **dessicated corpse borrows the emu's texture**, at each of its three draw sizes. That
was the authors' choice and it is still the only dessicated art the mod has.

## Verification

Two scripts check the mod before release: every def reference and every `ParentName` resolves
against **Core alone**, so no DLC is required, and each reference points at the right *type* of
def. What they cannot see is field-name validity — they check references between defs, not whether
a field still exists. That is exactly how the wildness breakage slipped past, and it is only
caught by loading the game.
