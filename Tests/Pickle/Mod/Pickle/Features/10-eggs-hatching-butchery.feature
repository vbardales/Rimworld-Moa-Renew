# The four checks TESTING.md listed as not played, on the same fixture as 03: test-colony, a save written without this
# mod. What is real here: the layer builds the egg the def names, with and without a male (CompEggLayer.Fertilize and
# ProduceEgg), the egg's own hatcher turns it into a young animal (CompHatcher.Hatch), and a butcher gets meat and
# leather (Pawn.ButcherProducts). What is forced: the mating delay and the 7 days of incubation, which are the game's
# own timers and are not asserted; the hatcher's progress is set to its end. A moa and an emu give either parent's
# kind, so the assertion accepts both: which one is Better Crossbreeding's arithmetic, read in feature 06.
@save
Feature: the moa lays, hatches and is butchered

  Scenario: a female with no mate builds the unfertilized egg
    Given the save "test-colony" is loaded
    Then Moa Renew: a female "Moa" without a mate builds the egg "EggMoaUnfertilized"

  Scenario: a fertilized egg hatches into a moa
    Given the save "test-colony" is loaded
    Then Moa Renew: a female "Moa" fertilized by a male "Moa" builds the egg "EggMoaFertilized", which hatches into a "Moa" or a "Moa"

  Scenario: a moa and an emu give a young of either kind
    Given the save "test-colony" is loaded
    Then Moa Renew: a female "Moa" fertilized by a male "Emu" builds the egg "EggMoaFertilized", which hatches into a "Moa" or a "Emu"
    And no errors were logged

  Scenario: butchering a moa gives its meat and its leather
    Given the save "test-colony" is loaded
    Then Moa Renew: butchering a "Moa" gives its meat and its leather
    And no errors were logged
