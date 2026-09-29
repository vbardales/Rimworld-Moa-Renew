# Patches/AnimalProsthetics2.xml in the loaded game: the moa is offered the surgeries of the emu's categories,
# 1 and 2, and not the bionics of category 3. ADS 2 copies its lists into its real recipes in its last patch, so
# this mod has to load first: About.xml declares loadBefore, and the pass map names this mod first because the
# staging does not sort by loadBefore (what the game does with the declaration is the game's business).
# One recipe stands for each step: the peg leg for category 1, the simple prosthetic leg for 2, the bionic leg for 3.
@requires:SamBucher.ADogSaidAnimalProsthetics2
Feature: the moa is offered the surgeries of its A Dog Said 2 category

  Scenario: this mod loads before A Dog Said 2
    Given Moa Renew: the game has finished starting
    And the main menu is open
    Then mod "SamBucher.ADogSaidAnimalProsthetics2" is loaded
    And mod "nelim.moa" loads before "SamBucher.ADogSaidAnimalProsthetics2"

  Scenario: categories 1 and 2, like the emu, and not 3
    Given Moa Renew: the game has finished starting
    And the main menu is open
    Then Moa Renew: the ThingDef "Moa" can be operated on with "InstallPegLegAnimal"
    And Moa Renew: the ThingDef "Moa" can be operated on with "InstallSimpleProstheticLegAnimal"
    And Moa Renew: the ThingDef "Moa" cannot be operated on with "InstallBionicLegAnimal"
    And Moa Renew: the ThingDef "Emu" cannot be operated on with "InstallBionicLegAnimal"
