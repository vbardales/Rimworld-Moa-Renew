# TEST_SCENARIOS.md S1 and S5 in a loaded map: the moa is generated, stands on it, survives a save and a reload,
# and generating it logs nothing (a missing texture or a broken life stage shows up as an error).
# @save: test-colony, a save written without this mod; loading it with the mod active is what adding the mod to an
# existing save looks like. Pickle's spawn step places the pawn exactly at the cell; the row z = 155 is the one the
# other suites of this collection use on the same fixture. Eggs are not spawned here: what they are is read from
# the defs (02).
@save
Feature: the moa spawns and survives a reload

  Scenario: the moa can be generated and stands on the map
    Given the save "test-colony" is loaded
    When I spawn a "Moa" pawn at (140, 155)
    Then a "Moa" exists
    And no errors were logged

  Scenario: it is still there after a save and a reload
    Given the save "test-colony" is loaded
    When I spawn a "Moa" pawn at (140, 155)
    And I save and reload
    Then a "Moa" exists
    And no errors were logged

  # A capture for a person to look at: the green says the steps ran, not that no texture is pink or that the bird
  # is drawn in every direction. The state is asserted before the capture.
  @review
  Scenario: two moas, for a person to look at
    Given the save "test-colony" is loaded
    When I spawn a "Moa" pawn at (140, 155)
    And I spawn a "Moa" pawn at (142, 155)
    Then a "Moa" exists
    When I move the camera to (141, 155)
    And I take a screenshot "moa-spawn"
    Then no errors were logged
