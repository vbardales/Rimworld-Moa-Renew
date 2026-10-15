# STEP PREFIXES: "Nelim's Sanctuary:" is the Sanctuary Backlot (fixture and named places); "Nelim's Pickle Tools:" is PickleTools
# (ScreenshotStudio presentation mode, ColonistRace clothes, CameraZoom, InspectTabs, ScreenshotMode); the rest is Pickle's.
#
# THE SERIES (GALLERY.md: staged photographs except the menus; one story; the session directs it). Reshot 2026-10-15 after the
# director's verdict on P12: the first series showed the birds from above, small, from behind, with no moa seen from the front.
# Rules applied: the protagonist is the moa, seen from the FRONT (animals face South, toward the camera), a tight camera, Nelim in
# frame. Names are neutral (the sex of a spawned animal is not chosen). Midday, the
# series running 5 game minutes per image (about 208 ticks, cumulative).
#
# THE STORY, "a day with the flock", in the order of the scenarios: (1) Nelim comes to the pen and three moas turn to her; (2) one
# of them has made a nest, a big animal bed with straw and three fertilized eggs, and sits at it; (3) the eggs have hatched, a chick
# stands beside its mother; (4) the neighbour emu strolls up and the two big birds stand face to face while Nelim watches (the
# cross is why the two breed); (5) the moa's information card closes the series. Mod brought in for the story: More animal beds
# (Animal.BedsNew, GSAnimalBedBigPrestige, the nest; seen on a clear cushion in CreaturesOfKiRenew, GALLERY-PROPS.md).
#
# SHOOTING PLAN (place; moment; subject; composition; living thing; what the image says):
#   1  enclosure-south; 12:01; three moas facing the camera, Nelim behind them in cream and forest green (the blue-grey birds stand out against her), hair in a bun, a bright smile (MouthSmile, LidCheerful); zoom 4; "a flock, big birds".
#   2  enclosure-south; +5 min; a moa at a nest (big bed, tall yellow grass, three fertilized eggs on the bed), facing the
#      camera; zoom 2.4 so the eggs read as eggs; "it lays big eggs".
#   3  enclosure-south; +10 min; a chick and an adult side by side facing the camera; zoom 2.8; "they hatch, small and round".
#   4  enclosure-south; +15 min; a moa and an emu face to face in profile, Nelim behind them facing the camera; zoom 3.6;
#      "they cross with the emu".
#   5  the information card of the moa on `window-backdrop-for-height`, midday, cropped around the window afterwards.
#
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
  Scenario: image 1, three moas facing the camera
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
    And Nelim's Pickle Tools: "Nelim" stands at (148, 211) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Bun"
    And Nelim's Pickle Tools: "Nelim" hair colour is rgb (62, 40, 30)
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthSmile"
    And Nelim's Pickle Tools: "Nelim" lids are "LidCheerful"
    When Nelim's Pickle Tools: an adult animal of kind "Moa" named "Kiwi" is spawned at (145, 214)
    And Nelim's Pickle Tools: an adult animal of kind "Moa" named "Pip" is spawned at (148, 214)
    And Nelim's Pickle Tools: an adult animal of kind "Moa" named "Dune" is spawned at (151, 214)
    And Nelim's Pickle Tools: the animal "Kiwi" stands at (145, 214) facing South
    And Nelim's Pickle Tools: the animal "Pip" stands at (148, 214) facing South
    And Nelim's Pickle Tools: the animal "Dune" stands at (151, 214) facing South
    And Nelim's Pickle Tools: I frame the cell (148, 213) at zoom 4
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And I take a screenshot "image 1, three moas facing the camera"
    Then Nelim's Pickle Tools: "Nelim" mouth reads "MouthSmile"
    And no errors were logged

  @review
  Scenario: image 2, a moa at her nest with three eggs
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And I set the hour to 12
    And I set the weather to "Clear"
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Sanctuary: the animals are removed from the sanctuary "enclosure-south"
    And Nelim's Sanctuary: I am at the sanctuary "enclosure-south"
    And I wait 268 ticks
    When Nelim's Pickle Tools: I place the decor "GSAnimalBedBigPrestige" at (148, 214)
    And Nelim's Pickle Tools: I place the decor "Plant_YellowTallGrass" at (147, 213) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_YellowTallGrass" at (150, 213) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_YellowTallGrass" at (147, 216) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_YellowTallGrass" at (150, 216) fully grown
    And Nelim's Pickle Tools: I place the decor "EggMoaFertilized" at (148, 215)
    And Nelim's Pickle Tools: I place the decor "EggMoaFertilized" at (149, 215)
    And Nelim's Pickle Tools: I place the decor "EggMoaFertilized" at (149, 214)
    And Nelim's Pickle Tools: an adult animal of kind "Moa" named "Pip" is spawned at (148, 214)
    And Nelim's Pickle Tools: the animal "Pip" stands at (148, 214) facing South
    And Nelim's Pickle Tools: I frame the cell (149, 214) at zoom 2.4
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And I take a screenshot "image 2, a moa at her nest"
    And Nelim's Pickle Tools: the decor is removed
    Then no errors were logged

  @review
  Scenario: image 3, a chick beside an adult
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And I set the hour to 12
    And I set the weather to "Clear"
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Sanctuary: the animals are removed from the sanctuary "enclosure-south"
    And Nelim's Sanctuary: I am at the sanctuary "enclosure-south"
    And I wait 477 ticks
    When Nelim's Pickle Tools: an adult animal of kind "Moa" named "Pip" is spawned at (148, 214)
    And Nelim's Pickle Tools: an animal of kind "Moa" named "Chick" is spawned at (149, 214) at life stage 0
    And Nelim's Pickle Tools: the animal "Pip" stands at (148, 214) facing South
    And Nelim's Pickle Tools: the animal "Chick" stands at (149, 214) facing South
    And Nelim's Pickle Tools: I frame the cell (148, 214) at zoom 2.8
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And I take a screenshot "image 3, a chick and an adult"
    Then no errors were logged

  @review
  Scenario: image 4, a moa and an emu face to face, Nelim watching
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And I set the hour to 12
    And I set the weather to "Clear"
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Sanctuary: the animals are removed from the sanctuary "enclosure-south"
    And Nelim's Sanctuary: I am at the sanctuary "enclosure-south"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (238, 228, 205)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants" dyed rgb (46, 94, 66)
    And I wait 685 ticks
    And Nelim's Pickle Tools: "Nelim" stands at (148, 211) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Bun"
    And Nelim's Pickle Tools: "Nelim" hair colour is rgb (62, 40, 30)
    And Nelim's Pickle Tools: "Nelim" brows are "BrowRaised"
    When Nelim's Pickle Tools: an adult animal of kind "Moa" named "Pip" is spawned at (146, 214)
    And Nelim's Pickle Tools: an adult animal of kind "Emu" named "Neighbour" is spawned at (150, 214)
    And Nelim's Pickle Tools: the animal "Pip" stands at (146, 214) facing East
    And Nelim's Pickle Tools: the animal "Neighbour" stands at (150, 214) facing West
    And Nelim's Pickle Tools: I frame the cell (148, 213) at zoom 3.6
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And I take a screenshot "image 4, a moa and an emu, Nelim watching"
    Then Nelim's Pickle Tools: "Nelim" mouth reads "MouthSmirkSmile"
    And no errors were logged

  @review
  Scenario: image 5, the information card of the moa on the tall-window backdrop
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
    And I take a screenshot "image 5, information card of the moa"
    And Nelim's Pickle Tools: screenshot mode is disabled
    And Nelim's Pickle Tools: I close the info card
    Then no errors were logged
