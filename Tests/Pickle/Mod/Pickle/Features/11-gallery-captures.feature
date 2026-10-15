# STEP PREFIXES: "Nelim's Sanctuary:" is the Sanctuary Backlot (fixture and named places); "Nelim's Pickle Tools:" is PickleTools
# (ScreenshotStudio presentation mode, ColonistRace clothes, CameraZoom, InspectTabs, ScreenshotMode); the rest is Pickle's.
#
# THE SERIES (GALLERY.md: staged photographs except the menus; one story; the session directs it). Reshot 2026-10-15 after the
# director's verdict on P12: the first series showed the birds from above, small, from behind, with no moa seen from the front.
# Rules applied: the protagonist is the moa, seen from the FRONT (animals face South, toward the camera), a tight camera, Nelim in
# frame. Names are neutral (the sex of a spawned animal is not chosen). The story: a morning at the Sanctuary's pen, midday, the
# series running 5 game minutes per image (about 208 ticks, cumulative).
#
# SHOOTING PLAN (place; moment; subject; composition; living thing; what the image says):
#   1  enclosure-south; 12:01; three moas side by side facing the camera, Nelim a little behind; zoom 4 on the middle bird;
#      "a flock, big birds that live together".
#   2  enclosure-south; +5 min; a chick (life stage 0) and an adult moa side by side facing the camera; zoom 2.8; "they hatch,
#      small and round".
#   3  enclosure-south; +10 min; a moa and an emu face to face in profile (moa East, emu West), medium frame; "they cross with
#      the emu".
#   4  enclosure-south; +15 min; Nelim beside a moa, both facing the camera, her smile and the bird's size read together, zoom 3;
#      "a bird as tall as its keeper".
#   5  the information card of the moa on the Sanctuary's `window-backdrop-for-height`, midday; the card is cropped laterally
#      around the window afterwards (GALLERY.md).
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
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (22, 110, 120)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants" dyed rgb (92, 38, 84)
    And I wait 60 ticks
    And Nelim's Pickle Tools: "Nelim" stands at (148, 211) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Sanctuary: Nelim has her own face
    When Nelim's Pickle Tools: an adult animal of kind "Moa" named "Kiwi" is spawned at (145, 214)
    And Nelim's Pickle Tools: an adult animal of kind "Moa" named "Pip" is spawned at (148, 214)
    And Nelim's Pickle Tools: an adult animal of kind "Moa" named "Dune" is spawned at (151, 214)
    And Nelim's Pickle Tools: the animal "Kiwi" stands at (145, 214) facing South
    And Nelim's Pickle Tools: the animal "Pip" stands at (148, 214) facing South
    And Nelim's Pickle Tools: the animal "Dune" stands at (151, 214) facing South
    And Nelim's Pickle Tools: I frame the cell (148, 213) at zoom 4
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And I take a screenshot "image 1, three moas facing the camera"
    Then Nelim's Pickle Tools: "Nelim" mouth reads "MouthSmirkSmile"
    And no errors were logged

  @review
  Scenario: image 2, a chick beside an adult
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And I set the hour to 12
    And I set the weather to "Clear"
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Sanctuary: the animals are removed from the sanctuary "enclosure-south"
    And Nelim's Sanctuary: I am at the sanctuary "enclosure-south"
    And I wait 268 ticks
    When Nelim's Pickle Tools: an adult animal of kind "Moa" named "Pip" is spawned at (148, 214)
    And Nelim's Pickle Tools: an animal of kind "Moa" named "Chick" is spawned at (149, 214) at life stage 0
    And Nelim's Pickle Tools: the animal "Pip" stands at (148, 214) facing South
    And Nelim's Pickle Tools: the animal "Chick" stands at (149, 214) facing South
    And Nelim's Pickle Tools: I frame the cell (148, 214) at zoom 2.8
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And I take a screenshot "image 2, a chick and an adult"
    Then no errors were logged

  @review
  Scenario: image 3, a moa and an emu face to face
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And I set the hour to 12
    And I set the weather to "Clear"
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Sanctuary: the animals are removed from the sanctuary "enclosure-south"
    And Nelim's Sanctuary: I am at the sanctuary "enclosure-south"
    And I wait 477 ticks
    When Nelim's Pickle Tools: an adult animal of kind "Moa" named "Pip" is spawned at (146, 214)
    And Nelim's Pickle Tools: an adult animal of kind "Emu" named "Neighbour" is spawned at (150, 214)
    And Nelim's Pickle Tools: the animal "Pip" stands at (146, 214) facing East
    And Nelim's Pickle Tools: the animal "Neighbour" stands at (150, 214) facing West
    And Nelim's Pickle Tools: I frame the cell (148, 214) at zoom 3.4
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And I take a screenshot "image 3, a moa and an emu"
    Then no errors were logged

  @review
  Scenario: image 4, Nelim beside a moa
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And I set the hour to 12
    And I set the weather to "Clear"
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Sanctuary: the animals are removed from the sanctuary "enclosure-south"
    And Nelim's Sanctuary: I am at the sanctuary "enclosure-south"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (22, 110, 120)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants" dyed rgb (92, 38, 84)
    And I wait 685 ticks
    And Nelim's Pickle Tools: "Nelim" stands at (147, 214) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Sanctuary: Nelim has her own face
    When Nelim's Pickle Tools: an adult animal of kind "Moa" named "Pip" is spawned at (149, 214)
    And Nelim's Pickle Tools: the animal "Pip" stands at (149, 214) facing South
    And Nelim's Pickle Tools: I frame the cell (148, 214) at zoom 3
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And I take a screenshot "image 4, Nelim beside a moa"
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
