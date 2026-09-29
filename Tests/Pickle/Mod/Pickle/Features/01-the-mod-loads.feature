# Player.log half of what TEST_SCENARIOS.md S1 asks a person to read. No save is loaded, on purpose: the errors this
# mod can produce are logged while the defs load, before any scenario is armed, and Pickle's own "no errors were
# logged" only sees what is logged after that. These steps read RimWorld's own log (Source/MoaSteps.cs).
# Played in every pass.
Feature: the mod loads clean and defines the moa and its eggs

  Scenario: the mod is loaded and its defs exist
    Given Moa Renew: the game has finished starting
    And the main menu is open
    Then mod "nelim.moa" is loaded
    And Moa Renew: the mod "nelim.moa" defines a ThingDef named "Moa"
    And Moa Renew: the mod "nelim.moa" defines a PawnKindDef named "Moa"
    And Moa Renew: the mod "nelim.moa" defines a ThingDef named "EggMoaFertilized"
    And Moa Renew: the mod "nelim.moa" defines a ThingDef named "EggMoaUnfertilized"

  Scenario: nothing logged while the defs loaded names the mod or its eggs
    Given Moa Renew: the game has finished starting
    And the main menu is open
    Then Moa Renew: nothing logged as an error or a warning names "nelim.moa"
    And Moa Renew: nothing logged as an error or a warning names "EggMoa"
