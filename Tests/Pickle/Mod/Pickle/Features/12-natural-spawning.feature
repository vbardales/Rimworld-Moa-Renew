# TEST_SCENARIOS.md S6, the part a loaded game can answer: the moa is eligible, at the weights the author set, in the four
# biomes the description names (BiomeDef.CommonalityOfAnimal reads race.wildBiomes). The random draw of a map is not asserted:
# an absence on one map is not a failure. No settings page and no MainButtons shortcut exist: settings_audit is not_applicable.
Feature: the moa lives wild in its four biomes

  Scenario: the game gives the moa a commonality in each declared biome
    Given Moa Renew: the game has finished starting
    And the main menu is open
    Then Moa Renew: the biome "TemperateForest" gives the animal "Moa" the commonality 0.2
    And Moa Renew: the biome "TemperateSwamp" gives the animal "Moa" the commonality 0.2
    And Moa Renew: the biome "TropicalRainforest" gives the animal "Moa" the commonality 0.25
    And Moa Renew: the biome "AridShrubland" gives the animal "Moa" the commonality 0.35
