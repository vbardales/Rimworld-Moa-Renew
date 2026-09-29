# Patches/BetterCrossbreeding.xml in the loaded game: what is born of a moa and an emu, by mother: either parent's
# kind on a coin flip. That mod's extension on the mother's PawnKindDef is read. The guard compares the mod's About
# name with ==: if its author renames it, the patch silently does nothing and this feature goes red at its first
# assertion. Not tested: an actual breeding, and the mod's own arithmetic.
@requires:DizzyEevee.BetterCrossbreeding
Feature: the moa and the emu give either parent's kind with Better Crossbreeding

  Scenario: the extension is there in both directions
    Given Moa Renew: the game has finished starting
    And the main menu is open
    Then mod "DizzyEevee.BetterCrossbreeding" is loaded
    And Moa Renew: the PawnKindDef "Moa" bred with "Emu" gives "Random"
    And Moa Renew: the PawnKindDef "Emu" bred with "Moa" gives "Random"
