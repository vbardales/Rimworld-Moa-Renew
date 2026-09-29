# The values the 1.6 port exists to fix, read off the loaded defs (TEST_SCENARIOS.md S2 and S3, the def half).
# Wildness moved from a race field to a StatDef in 1.6: read as a race field it is silently ignored and the
# stat falls back to -1, so a missing statBases entry fails here. The unfertilized egg is what CompEggLayer
# builds when an animal lays without a mate: a null field is an exception on a bird that lays every two days.
# The moa is a ThingDef AND a PawnKindDef of the same name, so every step names the def type.
Feature: the port's fixes and the moa's fixed values are in the loaded defs

  Scenario: wildness is the stat, and the values are the ones the author set
    Given Moa Renew: the game has finished starting
    And the main menu is open
    Then Moa Renew: the ThingDef "Moa" has the stat "Wildness" at 0.45
    And Moa Renew: the ThingDef "Moa" has the stat "MoveSpeed" at 4.2
    And Moa Renew: the ThingDef "Moa" has the stat "MarketValue" at 250
    And Moa Renew: the ThingDef "Moa" reads "race.lifeExpectancy" as "14"
    And Moa Renew: the ThingDef "Moa" reads "race.herdAnimal" as "True"

  Scenario: it lays both eggs, and the fertilized one hatches into a moa
    Given Moa Renew: the game has finished starting
    And the main menu is open
    Then Moa Renew: the ThingDef "Moa" lays "EggMoaFertilized" fertilized and "EggMoaUnfertilized" unfertilized
    And Moa Renew: the egg "EggMoaFertilized" hatches into the kind "Moa"

  @en-only
  Scenario: it fights with three tools
    Given Moa Renew: the game has finished starting
    And the main menu is open
    Then Moa Renew: the ThingDef "Moa" has a tool labelled "claws"
    And Moa Renew: the ThingDef "Moa" has a tool labelled "beak"
    And Moa Renew: the ThingDef "Moa" has a tool labelled "head"
