# Moa Renew

The moa from Halo Reach, brought forward to RimWorld 1.6.

**I am not the author of this mod.** The bird is Poshspider's, the update through 1.3 is
dninemfive's, and the textures are Serpyderpy's — all I did was the work needed to make it run on
1.6. Credit goes to them; mistakes in the update are mine.

Original mod: https://steamcommunity.com/sharedfiles/filedetails/?id=1746450702 — last supporting
1.3. Abandoned, not withdrawn.

## What the mod does

It adds one bird and its eggs.

- **Moa** — a large flightless herd bird, long domesticated but also living wild. Body size 0.6,
  worth 250 silver, fourteen years of life. It eats rough vegetation and it is filthy: eight times
  the mess of an ordinary animal.
- **Moa eggs**, fertilized and unfertilized. It lays every two days, one to three at a time, where
  an emu manages one every three and a third.
- Found in temperate forest and swamp, in rainforest, and rather more often in arid shrubland.

The author balanced it against the emu, and left the comparison in the file: every stat carries the
emu's value beside it in a comment. It is tamer (0.45 against 0.95), slower, shorter-lived, and it
fights worse — weaker claws and beak — but a surprise attack from a moa stuns harder.

No DLC required. No Harmony, no framework, no dependency of any kind.

Content mod: removing it mid-save will lose any moa and any moa eggs already in play.

## What changed in the 1.6 update

- **`wildness` moved to `<Wildness>` under `statBases`.** It stopped being a field of
  `RaceProperties` in 1.6 and became a StatDef. The old form is not an error, it is simply not
  read, and the stat's default is `-1` — outside the range the game uses, so the bird tames for
  almost nothing instead of sitting at 0.45.
- **The unfertilized egg had to be written.** `CompEggLayer` really does call
  `ThingMaker.MakeThing(Props.eggUnfertilizedDef)` as soon as an animal lays without having been
  fertilized, and throws if the field is null. On a bird that lays every two days, that is an
  in-game exception rather than a load-time warning. `EggMoaUnfertilized` carries the fertilized
  egg's market value and colour.
- **One of the two moas was dropped.** The mod shipped the bird twice: an older version under
  `Common/Defs/` and the current one under `1.3/Defs/`. Since 1.5 RimWorld loads a `Common` folder
  by default *and* the highest version folder it can find, so on 1.6 the pair would have collided
  over the same `defName`. Only the 1.3 version is kept.

No balance value was changed.

## Terms

The original is **MIT** (`LICENSE`, copyright dninemfive 2021), and that notice ships with the mod,
which is the condition MIT places on redistribution.

If Poshspider, dninemfive or Serpyderpy comes back to it, or asks for this to be taken down, it
comes down.

If I do not answer within a reasonable time after being contacted, anyone may freely update this or
any other of my mods, including publishing a continuation of it. All credit must be preserved.

## Credits

- **Poshspider** — the original mod.
- **dninemfive** — the update through 1.3, and the MIT terms this port relies on.
- **Serpyderpy** — the textures.
- 1.6 update by nelim. Written with the help of Claude (Anthropic).

