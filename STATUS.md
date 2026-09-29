---
localization: complete
translation_en: complete
translation_fr: complete
mod:          Moa Renew
packageId:    nelim.moa
repo:         Rimworld-Moa-Renew
visibility:   public
detached:     yes
stage:        showcase
workflow_stage: l10n
licence:      open
licence_at:   upstream LICENSE, MIT, copyright dninemfive 2021
upstream_mod_remotes:
  - https://github.com/dninemfive/rw-moa
dependencies: none
showcase:     icon and preview generated
settings_audit: not_applicable
tested_on:
workshop:      3806762626 (private, prepublished 0.1.0 on 2026-09-23)
remaining:
  - unverified: patches and French text in game (offline lxml tests are green)
  - feature: thanks to ADS 2, Nocturnal Animals (register, description, PUBLICATION.md)
  - feature: Pickle suite written and justified (none yet), then done
  - unverified: functional scenarios in game, no @wip, all conditional scenarios run, no manual test left
  - feature: PR to upstream dninemfive/rw-moa (needs Virginie agreement)
session:      maj:        2026-09-12, releve automatique
updated:      2026-09-29, audit and application
---

# Moa Renew — status

Read by a sweep across every mod, rather than by asking each thread in turn. It lives at the
root, never inside `Mod/`, so Steam never receives it.

The fields above were read off the disk on 2026-09-12. Four cannot be, and wait for whoever
holds this mod:

- **`stage`** — one of `port`, `showcase`, `preTest`, `done`, `tested`, `published`. Filled in
  from the session group where one exists; confirm it.
- **`tested_on`** — the date of the last run in game. Empty means never.
- **`dependencies`** — `declared` when every mod this one needs is named in the About's
  `modDependencies`, `to check` when a non-vanilla `loadAfter` suggests a dependency that is not
  declared, `none` when the mod needs nothing. An undeclared dependency is not cosmetic: on
  2026-09-11 Reequilibrage animaux took 47 vanilla animals down with it, Muffalo included, because
  the class it injects belongs to a mod that was not declared and not loaded.
- **`remaining`** — what is left, in three kinds: `feature` for something missing from a first
  release, `defect` for a known fault left unfixed, `unverified` for what could not be checked.
  The line already there is true of nearly the whole repository; replace it once it stops being.

`licence` vocabulary: `open` an explicit licence, `silent` no licence and a dead source,
`alive` no licence but a living source, `forbidden` a written refusal, `original` owing nothing
to anyone — not a name, not an idea traceable to one mod, not a value derived from its assets.

## Direct workflow audit — 2026-09-13

### Scope and preserved history

Audited `C:/Users/nelim/Documents/rimworld/Moa`, distributed folder `Mod/`.
Starting monorepo revision: `75c3000e1833d325cc7626a402981e4aa881d47a`.
Before this audit, only `STATUS.md` was locally modified within this mod: three unchecked
localization fields had been added. Those fields were evaluated, not discarded. The historical
sweep narrative above is retained; its old stage vocabulary does not define this audit.
Previous stage was empty, not a certified advanced state. Only STATUS.md was changed here.
No game launch, publication, image generation, development or directory rename was performed.

The stage field now uses the exact supplied workflow labels, without legacy code mapping:
`dansMonoRepo → horsMonoRepo → ModIcon générée → Preview générée → preOptions → options → l10n → preTest → done → tested`.
Overall retained state: **dansMonoRepo**. Later independent findings do not bypass earlier gates.
PUBLISHING.md, STYLE_RIMWORLD.md, MOD_SETTINGS.md and TRANSLATIONS.md were read; the user's
explicit override places interactive settings checks at the final in-game gate.

### Ordered transition findings

1. **dansMonoRepo → horsMonoRepo: defect found.** `git rev-parse --show-toplevel` returns
   `C:/Users/nelim/Documents/rimworld`; Moa has no own `.git`. A directory search under Documents
   found this project, source snapshots and monorepo worktree copies, no separate Moa checkout.
   GitHub read-only checks did validate public repository `vbardales/Rimworld-Moa-Renew`,
   default branch `main`, pushed commit `304e44cd3618720c251024b8ef97a92a26271907`.
   This does not establish a standalone local checkout and its remote. The absence of a Moa
   remote in the monorepo is not a defect. English README, ATTRIBUTION, CHANGELOG and LICENSE
   exist. Root, distributed and `_mods-sources/Moa/LICENSE` are byte-identical MIT notices,
   SHA256 `3CE048F84941F580BA7011479360E1668B93F559522E1A0086E9A7CA67813506`.
   `open` is supported by this local upstream snapshot; public visibility was checked live.
   No new licence is assigned to third-party material. Existing credits and takedown terms remain.
   Naming proposal from the user: folder `MoaRenew`, display title `Moa Renew`, existing repository
   `Rimworld-Moa-Renew`. Current title is `Moa 1.6`. Preserve `nelim.moa` as the established packageId;
   spelling need not be literally identical. No mandatory Renew rule was found in the four protocols,
   so this alignment is a recorded recommendation, not an invented naming failure.
2. **horsMonoRepo → ModIcon générée: defect found.** ModIcon.png is absent. There is no C# source,
   project or assembly; compilation is not applicable. Development completion is not certified
   by the successful static tests alone.
3. **ModIcon générée → Preview générée: defect found.** Preview.png is absent, as are source images
   in Art. Dimensions, size and visual conformity cannot be inspected. No camera defect is alleged.
4. **Preview générée → preOptions: defect found / non-verified.** Description is English, but its
   final required `[url=...]Source code on GitHub[/url]` link is missing. The About URL does point
   to the verified repository. Accent/secondary separation and title composition are non-verified
   because no preview exists.
5. **preOptions → options: justified not applicable.** See settings audit below.
6. **options → l10n: defect found.** English source coverage is complete; French is missing.
7. **l10n → preTest: independently validated statically.** Def references and ParentName resolve
   against Core alone. Only native EggLayer/Hatcher comps are used; no third-party dependencies,
   patches, LoadFolders or optional integrations exist. About declares 1.6; DLC loadAfter entries
   impose ordering, not requirements. No DLC dependency needs to be invented.
8. **preTest → done: incomplete.** Available automated XML checks passed on delivered files.
   No written functional scenario suite or corresponding executed functional test evidence was
   found. C# build/unit tests are not applicable to this XML-only content; functional content
   validation remains applicable. Existing documentation claims historical scripts, but is not
   treated as proof of execution. New test scenarios were not invented during this audit.
9. **done → tested: non-verified.** No available evidence of successful game scenarios, EN/FR UI,
   logs, new-game and existing-save validation. RimWorld was not launched, as requested.

### Settings audit

Inventory: one animal race and PawnKind, fertilized/unfertilized eggs, fixed animal statistics,
biome weights, life stages, attacks and native laying/hatching comps. These define the content;
no player configuration requirement or XML-only settings contract was found. Exposing each
balance constant is not warranted. No assembly, ModSettings subclass, settings page,
MainButtonDef or settings shortcut exists. Therefore `settings_audit: not_applicable` is justified
by source inventory. Access, input bounds, persistence and RIMMSQOL tests are inapplicable;
no integration is claimed as tested. This does not certify gameplay.

### Translation audit

All 11 owned text fields use native Def translation mechanisms and nonempty English sources:
ThingDef Moa label/description/race.meatLabel and tools claws/beak/head labels (6),
PawnKindDef Moa label (1), both egg ThingDefs label/description (4).
There is no code-owned UI or parameterized text. English source fallback is sufficient;
no redundant English files are required. There is no Languages folder, so all 11 fields lack
French coverage. Future French injections must address ThingDef and PawnKindDef separately,
including nested race and tool paths. Generated meat/corpse display must also be checked in game.
`localization: complete` records native translatability; `translation_en: complete` records
source coverage; `translation_fr: partial` records the audited absence, not an unexecuted check.

### Checks executed and limits

- PowerShell XML parsing: all four delivered XML files passed.
- `../scripts/Check-DefRefs.ps1 -ModPath ./Mod`: no missing references, wrong typed references
  or unresolved parents; repeated with `-GameData C:/Program Files (x86)/Steam/steamapps/common/RimWorld/Data/Core`
  and passed against Core alone. The script reports 3 unique names; there are 4 definitions,
  since ThingDef Moa and PawnKindDef Moa legitimately share a name across types.
- `../scripts/Check-XmlFields.ps1 -ModPath ./Mod`: 4 files checked, no unknown 1.6 fields.
- `../scripts/Check-DefInjected.ps1 -TransMod ./Mod`: 0 keys checked, 0 errors; this is a vacuous
  path result, not a translation pass. Manual text inventory establishes the missing FR coverage.
- `gh repo view ... --json name,visibility,defaultBranchRef,url` and `gh api repos/vbardales/Rimworld-Moa-Renew/commits/main --jq .sha`:
  public repository and pushed commit verified. Initial sandbox configuration access failed;
  the successful read-only retry superseded that access limitation.
- LICENSE SHA256 equality verified across three copies. Upstream snapshot About supports 1.1–1.3;
  this is local evidence, not a claim about the latest upstream Workshop state.

### Next transition and separate recommendations

Strict next transition: establish an autonomous checkout for this mod with its own GitHub remote,
retain the existing pushed history and local work, then recheck identity and documentation coherence.
No images, localization work or game launch is necessary merely to reach horsMonoRepo.
Separately, MoaRenew / Moa Renew is a sensible naming alignment to adopt during that work.
Later blockers remain the missing images, final source-link markup, French resources and functional
validation. Optional documentation correction: the claim that both eggs have the same tint disagrees
with `(107,113,139)` versus `(150,155,175)` in their current XML; this is a documentation mismatch,
not proof of broken gameplay. The inherited emu dessicated texture remains a documented limitation.

## Standalone import — 2026-09-13

Supersedes the local-checkout blocker and overall stage conclusion in the audit above.
User requested creation of MoaRenew and import of all existing content.
Cloned `https://github.com/vbardales/Rimworld-Moa-Renew.git` into
`C:/Users/nelim/Documents/rimworld/MoaRenew`, preserving the existing main history and origin.
Imported every file and directory from the original Moa workspace, including its locally modified
STATUS.md and empty Art directory. SHA256 comparison passed for every source file before this
status update. The original Moa folder is retained as a safety copy, not the active standalone project.
The distributed folder is now `C:/Users/nelim/Documents/rimworld/MoaRenew/Mod`.

Stage: **dansMonoRepo → horsMonoRepo**. The new checkout has its own .git, GitHub origin and
existing pushed commit `304e44cd3618720c251024b8ef97a92a26271907`. Public visibility and MIT evidence
remain as verified in the preceding audit. Display name `Moa 1.6` and packageId `nelim.moa` are
preserved during import; MoaRenew is the requested folder name. No feature or image was generated.
All independent settings/XML/localization findings above remain applicable to the identical payload.
Next gate remains blocked by the absent Mod/About/ModIcon.png; later preview/FR/test work remains.
Imported local changes have not been committed or pushed.

The existing RimWorld Mods/Moa junction was verified and retargeted to MoaRenew/Mod;
its old target was preserved. No game was launched.

## Import published to GitHub — 2026-09-13

User authorized commit and push. Import audit committed as 6353ab1 and pushed to origin/main.
Git normalization confirmed that the apparent payload modifications were line-ending differences;
only STATUS.md introduced content changes. Working tree was clean after the push.
This supersedes the earlier pending commit/push notes. Stage remains horsMonoRepo.
The original audit-only restriction on generating images awaits clarification before asset work.


## User-supplied ModIcon inspection — 2026-09-13

Directly opened and inspected Mod/About/ModIcon.png. PNG decoder confirms 1254 x 1254,
1,204,765 bytes. The image shows a single orange cartoon moa, a wink, heavy dark outlines,
a near-black background and one sparkle. Subject and contrast are clear at source resolution.
The user supplied this artwork; no generation was performed by this audit.
An additional source candidate is present at output/imagegen/moa-emoji-orange.png.

The missing-icon finding is superseded. Delivery dimensions still fail the expected 128 x 128;
a reduced delivery copy and direct 32 px readability check remain necessary. The <1 MB hard
limit applies to Preview, not to ModIcon; icon size is reported as optimization evidence.
Stage remains horsMonoRepo; no visual failure of camera is alleged and no artwork is overwritten.

## ModIcon delivery completed — 2026-09-13

User authorized continuing with the proposed size reduction. Archived the original unchanged as
Art/ModIcon-source.png; it matches output/imagegen/moa-emoji-orange.png by SHA256.
Resampled with high-quality bicubic interpolation to Mod/About/ModIcon.png, PNG 128 x 128,
19,885 bytes. Art/ModIcon-check-32.png records the 32 x 32 readability check.
Direct visual inspection of both versions passed: the orange bird silhouette, neck and beak
remain distinguishable; no cropping or unwanted border was introduced. Fine facial details
are naturally reduced at 32 px. No image was regenerated.

Stage: **horsMonoRepo → ModIcon générée**. The fixed XML content implementation is present;
there is no compiled component or build artifact requirement. Check-XmlFields.ps1 passed on
all 4 XML files, and Check-DefRefs.ps1 passed against Core alone in the new checkout.
These checks do not certify in-game behavior, which remains pending at the final test gate.
The earlier missing/oversized icon findings are superseded. Settings and translation audit
results remain unchanged because no gameplay XML or text changed.

Next transition: Preview générée, requiring Mod/About/Preview.png; that file is still absent.
The user's artwork source under output/ is retained locally and is not duplicated in Git;
Art/ModIcon-source.png is the committed source archive. No RimWorld launch was performed.

## Preview delivered — 2026-09-13

Stage: **ModIcon générée → Preview générée**. User requested continuation after completion
of the icon; this authorizes producing the next asset and supersedes the earlier pending scope
clarification. Built-in image generation produced the illustration using the actual moa sprite
as a subject reference. Exact prompt: Art/preview-generation.txt. Unmodified generated source:
Art/Preview.png. Delivered composition: Mod/About/Preview.png, PNG 896 x 504, 512,930 bytes.

Direct inspection of source, final composition and Art/Preview-check-268.png passed: overhead
oblique view, ground filling the frame, clear bird silhouettes, quiet title space and no clipping.
No concrete camera defect was found. Tiny animal face marks are part of the sprite reference;
there are no detailed colonist portraits. At thumbnail size the title/version and bird group remain
identifiable; the short summary is intended for full-size viewing.

Palette source of truth: Art/preview-palette.json. Slate ground and blue birds anchor the veil
and secondary ink. Pink crests supply the distinct vivid accent used by the line and version badge.
Art/render-preview.cjs generates Art/preview.html from that palette and captures it in headless
Chrome after document.fonts.ready. Segoe UI was available. Title 46px, Renew suffix at 65 percent,
summary 21px, badge 26px. No unofficial/prohibited tag is warranted by the recorded open licence.
Art/validate-preview.py measures every background pixel inside the text rectangles, using
Art/Preview-background-check.png; Art/preview-validation.json records minimum contrast ratios:
main title 7.679, suffix 6.853, summary 7.884, badge 6.996. All exceed 4.5:1.

Display title aligned to Moa Renew in About.xml, README and current STATUS fields; packageId
nelim.moa is unchanged. Added the required final GitHub source link and generation disclosure
to the English description. XML field check: all four files pass; About parses and the final
link matches the existing repository URL. Historic naming references above remain audit history.

## Preview composition and description gate — 2026-09-13

Stage: **Preview générée → preOptions**. Distinct secondary/accent colors, title hierarchy,
English description and final source-link markup passed the direct checks recorded above.
The preview uses the current Moa Renew display name; Renew is a secondary-colored suffix.
No linking word treatment is required for this title.


## Settings gate carried forward — 2026-09-13

Stage: **preOptions → options**. The justified settings_audit: not_applicable finding from
the direct audit remains valid: only artwork, About metadata and documentation changed.
No settings source, gameplay Def or integration changed. No empty page or shortcut exists.
Next gate is l10n: the previously inventoried 11 fields still lack French resources.
No game run or full functional validation is claimed.


## Audit and application — 2026-09-29

Old: `stage: options` (declared) with French absent. Retained: **l10n** (`stage: showcase`, `workflow_stage: l10n`).
Replaces the "translation_fr: partial / defect: French absent" decision above (replaced 2026-09-29, kept).

- French DefInjected now exists (`Mod/Languages/French/DefInjected/{ThingDef,PawnKindDef}/Moa.xml`, 11 fields, committed
  this date). Coverage rechecked by reading against the 11-field inventory above; `Tests/test_content.py` not rerun
  (Python unavailable), so results in `Tests/*.txt` (2026-09-13) predate the French files: unverified.
- `l10n → preTest` fails: this mod adds an animal, so the three integrations (ADS2, Nocturnal Animals, Better
  Crossbreeding) must be handled first (PUBLISHING.md, 2026-09-28); see BACKLOG.md. Dependencies: none, `loadAfter` only.
- `preTest → done`: no Pickle suite, no justification written. Not done.
- Prepublication 0.1.0: `About/PublishedFileId.txt` = 3806762626 (private item). CHANGELOG has `## [0.1.0]`; `1.0.0` stays unreleased.
- Upstream git repo found: `dninemfive/rw-moa` (MIT, main, last push 2022-07). Wording of the port matches its 1.3 files; PR in BACKLOG.
- `.dds`, `.ico`, `desktop.ini`, `output/`, evidence folders are gitignored; no Pickle evidence exists.
- Rules for `tested`: no `@wip`, every `@requires` scenario run, no manual test left.
- Docs read and versions: `docs/PROTOCOLS-READ.md`.

## Animal integrations — 2026-09-29

Analogue vanilla animal: the emu (parent `BigBirdThingBase`). Nothing depends on these mods; `modDependencies` stays empty.
- **A Dog Said... Animal Prosthetics 2** (3238353862): patch `Mod/Patches/AnimalProsthetics2.xml` adds `Moa` to `ADS_Cat1`
  and `ADS_Cat2`, where its 1.6 `Animal_Categories.xml` lists the Emu (not Cat3). Guarded by `PatchOperationConditional`
  on `ADS_Cat1`; `loadBefore` added to About.xml. Not applied to real XML yet (no Python/lxml here): **unverified**.
- **[XND] Nocturnal Animals (Continued)** (2269731409): its 1.6 `Patches/Core` names only the Cassowary among birds; the
  Emu is not named, so it is diurnal. Moa follows: no patch, by decision.
- **Better Crossbreeding** (3520675842): vanilla emu has no `canCrossBreedWith` and the moa description names no partner.
  No patch: a moa that cannot crossbreed is a decision, not an oversight. Reopen if Virginie wants a partner.
- **Dogs Mate (Continued)** (2441132298, `Mlie.DogsMate`): since 1.6 it uses the vanilla crossbreeding system and only
  cross-checks lists at game start. With no crossbreeding declared on the moa, there is nothing to patch.
Thanks (`THANKS`, WORKSHOP_COMMENTS.md) to ADS 2 and Nocturnal Animals are not written yet: description and register pending.
`remaining`: the animal-integration item is closed except the ADS 2 patch test and the thanks.

## Moa × emu crossbreeding — 2026-09-29 (owner's decision)

Replaces the "no crossbreeding" decisions above for Better Crossbreeding and Dogs Mate.
- Vanilla: `Moa` lists `Emu` in `canCrossBreedWith` (`Defs/Races_Animal_Moa.xml`); `Patches/EmuCrossbreeding.xml` lists `Moa` on the
  emu, appending to an existing list if any. This **modifies the vanilla emu** whenever the mod is loaded.
- Better Crossbreeding: `Patches/BetterCrossbreeding.xml`, guarded by `PatchOperationFindMod`, young of the pair are `Random`
  (either parent's kind) in both directions; namespace `DZY.CrossBreeding` confirmed in the DLL (`grep -a`), class `Extension` not.
- Dogs Mate: no patch; it cross-checks the lists at start, and both sides are now declared.
- **Unverified**: none of these patches applied to real XML or in game (no Python/lxml here); the BC `Extension` type name and `Random`
  element shape are read from its example only. Thanks to Better Crossbreeding and Dogs Mate still to write.

## Offline checks rerun — 2026-09-29 (revision after 5f-crossbreeding commit, with `uv run --with lxml`)

- `Tests/test_content.py`: PASS, 9 XML files, 11 EN/FR fields covered (results in `Tests/content-results.txt`).
- `Tests/test_patches.py`: 10 tests OK against real Core 1.6 and ADS 2's real `Animal_Categories.xml`: moa lands in ADS Cat1+Cat2 only,
  where the emu is; nothing changes with the mods absent; emu list appended, not duplicated; BC extension created or reused,
  `Random` both ways (`Tests/patches-results.txt`). The "test can fail" case is weak: it shows the always-true predicate would reach
  Cat3, not a full red run of the real patch.
- `Check-DefRefs.ps1` (Core alone), `Check-XmlFields.ps1` (7 files), `Check-DefInjected.ps1` (11 keys, 0 errors): clean.
  DefRefs does not implement `PatchOperationAddModExtension`.
- No `LoadFolders.xml`, no `modDependencies`; `loadAfter` DLC ordering and one `loadBefore` (ADS 2). `l10n → preTest` re-established 2026-09-29.
Remaining for `preTest`: thanks to the four mods (description, register, PUBLICATION.md).
