# STEP PREFIXES: "Nelim's Sanctuary:" is the Sanctuary Backlot (fixture and named places: frame, empty, animals removed);
# "Nelim's Pickle Tools:" is PickleTools (ScreenshotStudio presentation mode, ColonistRace clothes, CameraZoom, StageDecor,
# InspectTabs, ScreenshotMode); the rest is Pickle's. This suite has no step of its own for the gallery.
#
# THE SERIES (PUBLISHING.md and GALLERY.md: every capture is a staged photograph except the menus; one story; the session
# directs it). The story: a morning at the Sanctuary's pen. Nelim brings the flock out, the hens lay, the nest is full, a chick
# runs between the legs of its mother, the neighbour emu strolls up and the two big birds stand face to face. Midday, hour 12,
# the series runs forward 5 minutes of game time per image (about 208 ticks, cumulative, GALLERY.md "Recette explicite").
#
# SHOOTING PLAN, one line per image (place; moment; subject; composition; living thing; what the image says):
#   1  enclosure-south (the small pen, x 130-168, z 204-223); 12:00 plus set-up; three adult moas spread over the grass at three
#      depths, wide framing (rectangle (139,207)-(159,221)), Nelim at the gate in teal and plum; "a flock, big birds that live
#      together".
#   2  enclosure-south; +5 minutes; a hen on the straw of a nest (tall yellow grass), two fertilized eggs in front of her, the
#      cock a few cells behind; tight (zoom 3.4) on the nest; "it lays, and the eggs are big".
#   3  enclosure-south; +10 minutes; a chick (life stage 0) beside an adult moa, tight (zoom 3); "they hatch, small and round".
#   4  enclosure-south; +15 minutes; a moa and an emu face to face on the grass, medium framing; "they cross with the emu".
#   5  the information card of the moa (a menu, a full-height window) on the Sanctuary's `window-backdrop-for-height`, bamboo,
#      midday (SanctuaryBacklot GALERIE.md, "Choisir un lieu"): what the animal is, its stats.
#
# This is a review scenario: it asserts that each capture was taken, not what is on the picture. Each capture has to be OPENED
# AND LOOKED AT before it goes on the Workshop page (AUDIT.md, 9.d).
#
#   -Language English -DepMap wsl-deps.gallery.map -Filter '11-gallery-captures'
#
# English only (PUBLISHING.md, "Écrire en anglais").
@requires:nelim.sanctuarybacklot
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.screenshotmode
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.camerazoom
@requires:nelim.pickletools.stagedecor
@requires:nelim.pickletools.inspecttabs
Feature: the Workshop gallery images

  @review
  Scenario: image 1, the flock in the pen
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And I set the hour to 12
    And I set the weather to "Clear"
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Sanctuary: the animals are removed from the sanctuary "enclosure-south"
    And Nelim's Sanctuary: I am at the sanctuary "enclosure-south"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (22, 110, 120)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants" dyed rgb (92, 38, 84)
    And I wait 60 ticks
    And Nelim's Pickle Tools: "Nelim" stands at (157, 210) facing West
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Sanctuary: Nelim has her own face
    When Nelim's Pickle Tools: an adult animal of kind "Moa" named "Hen" is spawned at (144, 216)
    And Nelim's Pickle Tools: an adult animal of kind "Moa" named "Cock" is spawned at (149, 212)
    And Nelim's Pickle Tools: an adult animal of kind "Moa" named "Third" is spawned at (153, 217)
    And Nelim's Pickle Tools: I frame the rectangle from (139, 207) to (159, 221)
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And I take a screenshot "image 1, the flock in the pen"
    Then Nelim's Pickle Tools: "Nelim" mouth reads "MouthSmirkSmile"
    And no errors were logged

  @review
  Scenario: image 2, a hen on her nest with two eggs
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And I set the hour to 12
    And I set the weather to "Clear"
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Sanctuary: the animals are removed from the sanctuary "enclosure-south"
    And Nelim's Sanctuary: I am at the sanctuary "enclosure-south"
    And I wait 268 ticks
    When Nelim's Pickle Tools: I place the decor "Plant_YellowTallGrass" at (147, 214) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_YellowTallGrass" at (148, 214) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_YellowTallGrass" at (147, 215) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_YellowTallGrass" at (148, 215) fully grown
    And Nelim's Pickle Tools: I place the decor "EggMoaFertilized" at (147, 213)
    And Nelim's Pickle Tools: I place the decor "EggMoaFertilized" at (148, 213)
    And Nelim's Pickle Tools: an adult animal of kind "Moa" named "Hen" is spawned at (147, 215)
    And Nelim's Pickle Tools: an adult animal of kind "Moa" named "Cock" is spawned at (151, 218)
    And Nelim's Pickle Tools: I frame the cell (148, 215) at zoom 3.4
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And I take a screenshot "image 2, a hen on her nest"
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
    When Nelim's Pickle Tools: an adult animal of kind "Moa" named "Hen" is spawned at (148, 214)
    And Nelim's Pickle Tools: an animal of kind "Moa" named "Chick" is spawned at (149, 215) at life stage 0
    And Nelim's Pickle Tools: I frame the cell (148, 215) at zoom 3
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And I take a screenshot "image 3, a chick and its mother"
    Then no errors were logged

  @review
  Scenario: image 4, a moa and an emu face to face
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And I set the hour to 12
    And I set the weather to "Clear"
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Sanctuary: the animals are removed from the sanctuary "enclosure-south"
    And Nelim's Sanctuary: I am at the sanctuary "enclosure-south"
    And I wait 685 ticks
    When Nelim's Pickle Tools: an adult animal of kind "Moa" named "Cock" is spawned at (146, 214)
    And Nelim's Pickle Tools: an adult animal of kind "Emu" named "Neighbour" is spawned at (151, 214)
    And Nelim's Pickle Tools: I frame the rectangle from (141, 210) to (156, 218)
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And I take a screenshot "image 4, a moa and an emu"
    Then no errors were logged

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
    When Nelim's Pickle Tools: an adult animal of kind "Moa" named "Cock" is spawned at (90, 140)
    And Nelim's Pickle Tools: I select the thing of def "Moa" at (90, 140)
    And Nelim's Pickle Tools: I open the info card of the selected thing on the "Stats" tab
    And Nelim's Pickle Tools: screenshot mode is enabled around the open windows
    And I take a screenshot "image 5, information card of the moa"
    And Nelim's Pickle Tools: screenshot mode is disabled
    And Nelim's Pickle Tools: I close the info card
    Then no errors were logged
