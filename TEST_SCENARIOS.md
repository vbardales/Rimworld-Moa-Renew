# Functional validation scenarios

Status: NOT EXECUTED in game. Covered by the Pickle suite (see TESTING.md); nothing here is a pass.
Use a disposable save. Record game build, language, active mod list, date, actions, observed
results and relevant Player.log excerpts. Repeat S1–S5 in English and French. Inspect the log
for missing Defs, translation keys, textures, XML errors and exceptions after every scenario.

| ID | Preconditions | Actions | Expected results |
|---|---|---|---|
| S1 — Fresh Core-only game | Core and Moa Renew, no DLC or framework required; start a new test colony | Open mod list, create map, spawn an adult moa using developer tools, inspect animal and information panes | Icon and name appear; moa renders in each facing direction; name, description and attack labels display in selected language; no new relevant load/runtime errors |
| S2 — Eggs and hatching | Adult male/female moa together, fed and safe, temperature suitable for incubation | Allow mating and laying, observe fertilized eggs, incubate for the defined 7 days | Laying produces the defined 1–3 eggs, incubation completes into a moa, baby/juvenile/adult graphics render; no null-def exception |
| S3 — Unfertilized path | Isolated adult female, no male; separately spawn an unfertilized moa egg | Observe egg progress across the configured interval; inspect the egg and use it as food | Progress respects the configured unfertilized cap of 0.5; do not assume autonomous unfertilized laying from the 2-day interval alone. Spawned unfertilized egg is usable food, has correct localized label/description and does not hatch; no exceptions |
| S4 — Meat, corpse and combat | Test moa and a designated disposable combat/butchering area | Inspect attacks, perform combat, butcher a corpse, inspect meat and a dessicated corpse | Attacks operate without errors; meat uses localized moa meat label; generated corpse text is localized; inherited emu dessicated texture is expected, not a missing-texture defect |
| S5 — Save/reload and existing colony | Save with moa, both egg types and meat; backup a separate pre-existing Core colony | Save, quit/reload manually; add mod to backed-up existing colony and spawn content | Animals/items persist without missing references; existing colony loads, content can be spawned and used; no new relevant errors. No settings persistence test is needed because no settings exist |
| S6 — Natural spawning and settings absence | New maps in each declared biome; default configuration | Sample TemperateForest, TemperateSwamp, TropicalRainforest and AridShrubland maps; inspect Mod options and main bar | Moa is eligible in declared biomes (random absence on one map is not failure); no empty mod settings page or main-button shortcut; no RIMMSQOL dependency |

Language inventory: animal label/description, moa meat, claws/beak/head, PawnKind label,
and both egg labels/descriptions. Proper name "moa" is intentionally identical in EN/FR.
Check generated meat/corpse text, accents, raw keys, fallback English and clipping directly.
If a correction is needed, rerun its affected static checks and game scenarios; do not mark
`tested` until all applicable scenarios and log/UI checks have passed.

Compilation and custom C# unit tests are not applicable: the mod contains XML and textures only.
Static coverage and content regression tests are in Tests/test_content.py; game field/reference
and injection validation use the shared scripts documented in Tests/RESULTS.md.
