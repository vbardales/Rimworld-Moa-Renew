# The moa and the emu can breed (owner's decision, 2026-09-29): the game reads canCrossBreedWith on the race of the
# MALE only, so each race lists the other; the moa in its own def, the emu by Patches/EmuCrossbreeding.xml, which
# modifies a vanilla animal. Vanilla behaviour, no optional mod: played in every pass. An actual breeding needs a pair
# of both sexes and a long mating delay: not played (see TESTING.md).
Feature: the moa and the emu list each other

  Scenario: both directions are declared
    Given Moa Renew: the game has finished starting
    And the main menu is open
    Then Moa Renew: the ThingDef "Moa" can cross with "Emu"
    And Moa Renew: the ThingDef "Emu" can cross with "Moa"

  Scenario: no other animal was touched
    Given Moa Renew: the game has finished starting
    And the main menu is open
    Then Moa Renew: the ThingDef "Cassowary" cannot cross with "Moa"
    And Moa Renew: the ThingDef "Ostrich" cannot cross with "Moa"
    And Moa Renew: the ThingDef "Moa" cannot cross with "Cassowary"
