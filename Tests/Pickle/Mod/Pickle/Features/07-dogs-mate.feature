# Dogs mate (Continued) cross-checks every animal's canCrossBreedWith at game start and adds the missing reverse
# entries; the moa declares both sides itself, so with that mod beside it nothing changes and nothing is logged.
# There is no patch of ours to assert, only that the mod does not disturb the pair and does not log about them.
@requires:Mlie.DogsMate
Feature: Dogs mate leaves the moa and the emu alone

  Scenario: the pair is unchanged and the log is quiet
    Given Moa Renew: the game has finished starting
    And the main menu is open
    Then mod "Mlie.DogsMate" is loaded
    And Moa Renew: the ThingDef "Moa" can cross with "Emu"
    And Moa Renew: the ThingDef "Emu" can cross with "Moa"
    And Moa Renew: nothing logged as an error or a warning names "EggMoa"
