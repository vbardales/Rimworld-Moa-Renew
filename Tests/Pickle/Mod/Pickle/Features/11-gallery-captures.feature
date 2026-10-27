# STEP PREFIXES: "Nelim's Sanctuary:" is the Sanctuary Backlot (fixture and named places); "Nelim's Pickle Tools:" is PickleTools
# (ScreenshotStudio presentation mode, ColonistRace clothes and forced jobs, CameraZoom, InspectTabs, ScreenshotMode); the rest is Pickle's.
#
# THE SERIES (GALLERY.md: staged photographs except the menus; one story; the session directs it). Reshot after the shotlist of
# 2026-10-27 (rated 2.5/5 on 2026-10-27: no decor, nobody caught mid-gesture, no wide shot; this version carries the director's pass).
# Protagonist: Nelim (Virginie), canon looks of SanctuaryBacklot/docs/APPARENCES-CANON.md: high ponytail (`Roo_HD_Hair_Highpony`,
# never a bun), her own face, a bright smile (MouthSmile, LidCheerful: smiling is the default on a default scene, GALLERY.md 2026-10-25).
# Outfit, the same all day (continuity, criterion d): cream shirt (238, 228, 205) and forest-green trousers (46, 94, 66), chosen so
# the blue-grey moas stand out against her. Only NSB colonists: Nelim alone.
#
# THE STORY, "a day with the flock", noon at the pen `enclosure-south`, clear, 20 degrees. Rhythm: one start hour (12) and a
# cumulative wait: 60 ticks of set-up, then +208 ticks (5 game minutes) per image, so 12:01, 12:06, 12:11, 12:16, 12:21
# (60, 268, 477, 685, 893 ticks). (1) Nelim comes in through the south gate with an armful of hay and the flock runs to her;
# (2) she has put the hay down, three moas eat it, facing us, and she walks away; (3) a hen broods three eggs on a big nest bed
# while a male crosses behind her; (4) a chick and its mother eat side by side; (5) the neighbour emu arrives at the same hay as a moa,
# face to face, and Nelim leaves through the gate; (6) the information card of the moa closes the series (eggs and meat yields).
# Mod brought in for the story: More animal beds (Animal.BedsNew, GSAnimalBedBigPrestige, the nest; GALLERY-PROPS.md).
# Hay (vanilla `Hay`) is what Nelim carries and sets down; every heap is decor, removed after the shot.
#
# HOW A GESTURE IS OBTAINED: the game is paused; a pawn or an animal is forced into a job (Ingest on a Hay heap, a walk, a lie-down),
# then `I advance the paused game by exactly N ticks` lets the job begin and stops it mid-movement. N is a first guess (about
# 13 ticks per cell for a walking pawn) and is tuned by the capture, never by the run being green.
# FACING: z grows to the north and the camera looks from the south, so a bird shows its front when it heads to a heap at a SMALLER z
# than itself (images 1, 2, 4: birds at z 215 to 218, heaps at z 212 to 213); a heap at the same z shows it in profile (image 5).
#
# SHOOTING PLAN (place; moment; subject; composition; living things; decor; the instant; what the image says):
#   1  WIDE opening. enclosure-south; 12:01; Nelim, a flock; zoom 8.5 on (150, 213), the whole pen with the south gate (159, 207) and
#      its fence; Nelim mid-stride just inside the gate, 20 Hay in her hands (carries, forced to walk to (153, 212), 40 ticks),
#      four adult moas (two hens, two cocks), two of them in Ingest on the heap at (153, 212) paused mid-run towards it, the two others
#      standing behind; decor Plant_YellowTallGrass tufts at (140, 218), (156, 220) and a Hay heap at (153, 212);
#      instant: "just after she steps through the gate with the first armful"; says "a flock of big birds, fed by hand".
#   2  MEDIUM. enclosure-south; +5 min; zoom 4 on (148, 214); three moas eating from three Hay heaps set south of them, so they face
#      the camera, beaks going down (Ingest, 20 ticks); Nelim behind them, empty-handed, forced to walk east to (154, 213), mid-step,
#      smiling; instant: "just after she set the hay down, the first beak goes down"; says "they gather and eat".
#   3  CLOSE. enclosure-south; +10 min; zoom 2.4 on (149, 214); a hen lies on a big animal bed nest (GSAnimalBedBigPrestige at
#      (148, 214)) with three fertilized eggs (EggMoaFertilized) and tall yellow grass around, facing South; a cock mid-stride at the
#      edge of the frame, forced into Ingest on a heap at (145, 216), 25 ticks; instant: "just before the cock reaches
#      the hay beside the nest"; says "they lay big eggs and brood them".
#   4  MEDIUM-CLOSE. enclosure-south; +15 min; zoom 3.5 on (148, 214); the hen eats from a heap at (147, 215) while a chick (life
#      stage 0) runs to its own heap at (149, 215), forced into Ingest from three cells away, paused mid-step; no nest, no egg (the
#      timeline: eggs at 12:11, a chick by 12:16 is the same hatch of another hen, not shown); instant: "just before the chick
#      reaches the heap beside its mother"; says "the chicks follow the flock".
#   5  MEDIUM-WIDE closing. enclosure-south; +20 min; zoom 6 on (150, 212); a hen moa (east, head down, Ingest at the heap (148, 214))
#      and a cock emu (west, spawned at (141, 214), forced into Ingest on the same heap, paused mid-stride) meet face to face in
#      profile; Nelim in the background leaving through the south gate, empty-handed, back mostly to us, mid-step, the same outfit;
#      decor: the Hay heap at (148, 214); instant: "just as the emu reaches the moa's heap"; says "the emu neighbour is welcome, and they
#      cross" (hen moa x cock emu: the two breed, Better Crossbreeding).
#   6  INTERFACE. the information card of the moa (Stats tab, eggs and meat yields) on `window-backdrop-for-height`, cropped
#      around the window afterwards, no subtitle (not rated).
#
# SHOTLIST SCORE (GALLERY.md k, per shot a to g and j): see STATUS.md, "Shotlist 2026-10-27".
# Review scenario: asserts each capture was taken, not what is on it. Each capture has to be OPENED AND LOOKED AT (AUDIT.md 9.d).
#
#   -Language English -DepMap wsl-deps.gallery.map -Filter '11-gallery-captures'
@requires:nelim.sanctuarybacklot
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.screenshotmode
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.camerazoom
@requires:nelim.pickletools.stagedecor
@requires:nelim.pickletools.inspecttabs
@requires:Animal.BedsNew
Feature: the Workshop gallery images

  @review
  Scenario: image 1, the flock runs to Nelim and her armful of hay
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And I set the hour to 12
    And I set the weather to "Clear"
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Sanctuary: the animals are removed from the sanctuary "enclosure-south"
    And Nelim's Sanctuary: I am at the sanctuary "enclosure-south"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (238, 228, 205)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants" dyed rgb (46, 94, 66)
    And I wait 60 ticks
    When Nelim's Pickle Tools: I place the decor "Plant_YellowTallGrass" at (140, 218) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_YellowTallGrass" at (156, 220) fully grown
    And Nelim's Pickle Tools: I place the decor "Hay" at (153, 212)
    And Nelim's Pickle Tools: a female adult animal of kind "Moa" named "Kiwi" is spawned at (146, 216)
    And Nelim's Pickle Tools: a female adult animal of kind "Moa" named "Pip" is spawned at (149, 217)
    And Nelim's Pickle Tools: a male adult animal of kind "Moa" named "Dune" is spawned at (151, 215)
    And Nelim's Pickle Tools: a male adult animal of kind "Moa" named "Moss" is spawned at (155, 216)
    And Nelim's Pickle Tools: the animal "Kiwi" stands at (146, 216) facing South
    And Nelim's Pickle Tools: the animal "Pip" stands at (149, 217) facing South
    And Nelim's Pickle Tools: "Nelim" stands at (158, 208) facing West
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Highpony"
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthSmile"
    And Nelim's Pickle Tools: "Nelim" lids are "LidCheerful"
    And Nelim's Pickle Tools: "Nelim" carries 20 of the item "Hay"
    And Nelim's Pickle Tools: "Nelim" is forced to walk to (153, 212)
    And Nelim's Pickle Tools: the animal "Dune" is forced into the job "Ingest" on the item "Hay" at (153, 212)
    And Nelim's Pickle Tools: the animal "Moss" is forced into the job "Ingest" on the item "Hay" at (153, 212)
    And Nelim's Pickle Tools: I advance the paused game by exactly 40 ticks
    And Nelim's Pickle Tools: I frame the cell (150, 213) at zoom 8.5
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And I take a screenshot "image 1, the flock runs to Nelim"
    And Nelim's Pickle Tools: the decor is removed
    Then Nelim's Pickle Tools: "Nelim" mouth reads "MouthSmile"
    And no errors were logged

  @review
  Scenario: image 2, three moas eat the hay, Nelim walks away
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And I set the hour to 12
    And I set the weather to "Clear"
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Sanctuary: the animals are removed from the sanctuary "enclosure-south"
    And Nelim's Sanctuary: I am at the sanctuary "enclosure-south"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (238, 228, 205)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants" dyed rgb (46, 94, 66)
    And I wait 268 ticks
    When Nelim's Pickle Tools: I place the decor "Hay" at (147, 213)
    And Nelim's Pickle Tools: I place the decor "Hay" at (148, 213)
    And Nelim's Pickle Tools: I place the decor "Hay" at (149, 213)
    And Nelim's Pickle Tools: I place the decor "Plant_YellowTallGrass" at (143, 217) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_YellowTallGrass" at (153, 217) fully grown
    And Nelim's Pickle Tools: a female adult animal of kind "Moa" named "Kiwi" is spawned at (147, 215)
    And Nelim's Pickle Tools: a female adult animal of kind "Moa" named "Pip" is spawned at (148, 215)
    And Nelim's Pickle Tools: a male adult animal of kind "Moa" named "Dune" is spawned at (149, 215)
    And Nelim's Pickle Tools: "Nelim" stands at (151, 212) facing East
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Highpony"
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthSmile"
    And Nelim's Pickle Tools: "Nelim" lids are "LidCheerful"
    And Nelim's Pickle Tools: the animal "Kiwi" is forced into the job "Ingest" on the item "Hay" at (147, 213)
    And Nelim's Pickle Tools: the animal "Pip" is forced into the job "Ingest" on the item "Hay" at (148, 213)
    And Nelim's Pickle Tools: the animal "Dune" is forced into the job "Ingest" on the item "Hay" at (149, 213)
    And Nelim's Pickle Tools: "Nelim" is forced to walk to (154, 213)
    And Nelim's Pickle Tools: I advance the paused game by exactly 20 ticks
    And Nelim's Pickle Tools: I frame the cell (148, 214) at zoom 4
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And I take a screenshot "image 2, three moas eat"
    And Nelim's Pickle Tools: the decor is removed
    Then Nelim's Pickle Tools: "Nelim" mouth reads "MouthSmile"
    And no errors were logged

  @review
  Scenario: image 3, a hen broods three eggs, a cock crosses behind her
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And I set the hour to 12
    And I set the weather to "Clear"
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Sanctuary: the animals are removed from the sanctuary "enclosure-south"
    And Nelim's Sanctuary: I am at the sanctuary "enclosure-south"
    And I wait 477 ticks
    When Nelim's Pickle Tools: I place the decor "GSAnimalBedBigPrestige" at (148, 214)
    And Nelim's Pickle Tools: I place the decor "Plant_YellowTallGrass" at (147, 213) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_YellowTallGrass" at (150, 213) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_YellowTallGrass" at (147, 216) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_YellowTallGrass" at (150, 216) fully grown
    And Nelim's Pickle Tools: I place the decor "EggMoaFertilized" at (148, 215)
    And Nelim's Pickle Tools: I place the decor "EggMoaFertilized" at (149, 215)
    And Nelim's Pickle Tools: I place the decor "EggMoaFertilized" at (149, 214)
    And Nelim's Pickle Tools: I place the decor "Hay" at (145, 216)
    And Nelim's Pickle Tools: a female adult animal of kind "Moa" named "Pip" is spawned at (148, 214)
    And Nelim's Pickle Tools: the animal "Pip" lies at (148, 214) facing South
    And Nelim's Pickle Tools: a male adult animal of kind "Moa" named "Dune" is spawned at (141, 218)
    And Nelim's Pickle Tools: the animal "Dune" is forced into the job "Ingest" on the item "Hay" at (145, 216)
    And Nelim's Pickle Tools: I advance the paused game by exactly 25 ticks
    And Nelim's Pickle Tools: I frame the cell (149, 214) at zoom 2.4
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And I take a screenshot "image 3, a hen on her nest"
    And Nelim's Pickle Tools: the decor is removed
    Then no errors were logged

  @review
  Scenario: image 4, a chick runs to the hay beside its mother
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And I set the hour to 12
    And I set the weather to "Clear"
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Sanctuary: the animals are removed from the sanctuary "enclosure-south"
    And Nelim's Sanctuary: I am at the sanctuary "enclosure-south"
    And I wait 685 ticks
    When Nelim's Pickle Tools: I place the decor "Hay" at (147, 213)
    And Nelim's Pickle Tools: I place the decor "Hay" at (149, 213)
    And Nelim's Pickle Tools: I place the decor "Plant_YellowTallGrass" at (145, 217) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_YellowTallGrass" at (153, 216) fully grown
    And Nelim's Pickle Tools: a female adult animal of kind "Moa" named "Pip" is spawned at (147, 215)
    And Nelim's Pickle Tools: an animal of kind "Moa" named "Chick" is spawned at (152, 218) at life stage 0
    And Nelim's Pickle Tools: the animal "Pip" is forced into the job "Ingest" on the item "Hay" at (147, 213)
    And Nelim's Pickle Tools: the animal "Chick" is forced into the job "Ingest" on the item "Hay" at (149, 213)
    And Nelim's Pickle Tools: I advance the paused game by exactly 30 ticks
    And Nelim's Pickle Tools: I frame the cell (148, 214) at zoom 3.5
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And I take a screenshot "image 4, a chick and its mother"
    And Nelim's Pickle Tools: the decor is removed
    Then no errors were logged

  @review
  Scenario: image 5, a moa and the emu neighbour meet at the hay, Nelim leaves
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And I set the hour to 12
    And I set the weather to "Clear"
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Sanctuary: the animals are removed from the sanctuary "enclosure-south"
    And Nelim's Sanctuary: I am at the sanctuary "enclosure-south"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (238, 228, 205)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants" dyed rgb (46, 94, 66)
    And I wait 893 ticks
    When Nelim's Pickle Tools: I place the decor "Hay" at (148, 214)
    And Nelim's Pickle Tools: I place the decor "Plant_YellowTallGrass" at (145, 217) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_YellowTallGrass" at (153, 217) fully grown
    And Nelim's Pickle Tools: a female adult animal of kind "Moa" named "Pip" is spawned at (149, 214)
    And Nelim's Pickle Tools: a male adult animal of kind "Emu" named "Neighbour" is spawned at (141, 214)
    And Nelim's Pickle Tools: "Nelim" stands at (157, 209) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Highpony"
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthSmile"
    And Nelim's Pickle Tools: "Nelim" lids are "LidCheerful"
    And Nelim's Pickle Tools: the animal "Pip" is forced into the job "Ingest" on the item "Hay" at (148, 214)
    And Nelim's Pickle Tools: the animal "Neighbour" is forced into the job "Ingest" on the item "Hay" at (148, 214)
    And Nelim's Pickle Tools: "Nelim" is forced to walk to (159, 205)
    And Nelim's Pickle Tools: I advance the paused game by exactly 45 ticks
    And Nelim's Pickle Tools: I frame the cell (150, 212) at zoom 6
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And I take a screenshot "image 5, the emu neighbour meets a moa"
    And Nelim's Pickle Tools: the decor is removed
    Then no errors were logged

  @review
  Scenario: image 6, the information card of the moa on the tall-window backdrop
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And I set the hour to 12
    And I set the weather to "Clear"
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Sanctuary: the animals are removed from the sanctuary "window-backdrop-for-height"
    And Nelim's Sanctuary: I am at the sanctuary "window-backdrop-for-height"
    And I wait 120 ticks
    When Nelim's Pickle Tools: an adult animal of kind "Moa" named "Pip" is spawned at (90, 140)
    And Nelim's Pickle Tools: I select the thing of def "Moa" at (90, 140)
    And Nelim's Pickle Tools: I open the info card of the selected thing on the "Stats" tab
    And Nelim's Pickle Tools: screenshot mode is enabled around the open windows
    And I take a screenshot "image 6, information card of the moa"
    And Nelim's Pickle Tools: screenshot mode is disabled
    And Nelim's Pickle Tools: I close the info card
    Then no errors were logged
