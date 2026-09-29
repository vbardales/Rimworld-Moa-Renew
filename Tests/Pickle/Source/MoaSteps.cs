using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Threading.Tasks;
using RimWorks.Pickle;
using RimWorld;
using Verse;

namespace MoaRenew.PickleSteps
{
    /// <summary>
    /// What Pickle's own steps cannot say about this mod. Every text starts with "Moa Renew:", because
    /// Pickle loads the steps of every active suite into one namespace and two suites declaring the same
    /// text make healthy scenarios fail with "Ambiguous step". No text here uses parentheses or slashes,
    /// which Cucumber expressions read as optional text and alternatives.
    ///
    /// Why not Pickle's own def steps. Every one of the nine species is TWO defs with the same defName, a
    /// ThingDef and a PawnKindDef. Pickle's "def X field Y is Z" and "def X raw stat Y is Z" look a name up
    /// across every def database and throw when it names more than one def, so they cannot be used here at
    /// all. These steps name the def type.
    /// </summary>
    [PickleSteps]
    public class MoaSteps
    {
        // ---------------------------------------------------------------- starting up

        /// <summary>
        /// Waits until the game has finished loading: no long event is running or queued. Pickle's own "the
        /// main menu is open" gives a step five seconds, and the first scenario of a pass sits right at that
        /// limit: it took 4.4 s in a plain pass, and 5.2 s with the original mod beside this one, whose extra
        /// defs and load errors slow the start, which failed the incompatibility pass on its first step. Every
        /// scenario that starts from the menu says this first, with a deadline that a slow start cannot reach.
        ///
        /// It must NOT wait for the menu itself. The first version waited for ProgramState.Entry, and a
        /// scenario that follows one which loaded a save finds the game still in Playing: the menu only comes
        /// from the step after this one, so the wait never ended, and Pickle's watchdog killed the whole run
        /// after 120 s (2026-09-25, request e147). What is asked here is only that nothing is still loading.
        /// </summary>
        [Given("Moa Renew: the game has finished starting", TimeoutSeconds = 125f)]
        public async Task GameHasFinishedStarting(PickleContext ctx)
        {
            await ctx.WaitUntil(() => !LongEventHandler.AnyEventNowOrWaiting, 120f);
        }

        // ---------------------------------------------------------------- the log

        /// <summary>
        /// The test companion's own name. It is "Moa Renew - Pickle tests", so any message the game logs
        /// about the companion contains "ebbb" and, when it quotes a dependency, this mod's packageId. Two
        /// such messages are normal for a companion that only holds features: one warning that a dependency
        /// declares no download URL, and one error that the mod "did not load any content". The first run
        /// of this suite failed two scenarios on exactly those. They are about the harness, not about the
        /// mod under test, so they are left out of what these steps read.
        /// </summary>
        private const string Companion = "Moa Renew - Pickle tests";

        private static List<string> ErrorsAndWarnings()
        {
            return Log.Messages
                .Where(m => m.type == LogMessageType.Error || m.type == LogMessageType.Warning)
                .Select(m => m.text ?? string.Empty)
                .Where(text => text.IndexOf(Companion, StringComparison.OrdinalIgnoreCase) < 0)
                .ToList();
        }

        private static string FirstLine(string text)
        {
            int cut = text.IndexOf('\n');
            return cut < 0 ? text : text.Substring(0, cut);
        }

        /// <summary>
        /// Pickle's "no errors were logged" reads what is logged after a scenario is armed, and arming clears
        /// the buffer, so an error the game logged while it LOADED THE DEFS is gone before the first step.
        /// The lines are still in RimWorld's own log, Verse.Log.Messages, so this reads that. Case
        /// insensitive, errors and warnings both. The log is bounded, which is why every pass stages a small set.
        /// </summary>
        [Then("Moa Renew: nothing logged as an error or a warning names {string}")]
        public void NothingNames(PickleContext ctx, string text)
        {
            List<string> hits = ErrorsAndWarnings()
                .Where(line => line.IndexOf(text, StringComparison.OrdinalIgnoreCase) >= 0)
                .ToList();
            ctx.Assert(
                hits.Count == 0,
                "expected nothing logged as an error or a warning to name '" + text + "'; got " + hits.Count + ": "
                + string.Join(" | ", hits.Take(3).Select(FirstLine)));
        }

        // ---------------------------------------------------------------- loaded defs, by type and name

        private static Def FindDef(PickleContext ctx, string typeName, string defName)
        {
            foreach (Type type in GenDefDatabase.AllDefTypesWithDatabases())
            {
                if (!string.Equals(type.Name, typeName, StringComparison.OrdinalIgnoreCase))
                {
                    continue;
                }

                Def def = GenDefDatabase.GetDefSilentFail(type, defName, false);
                ctx.Require(def != null, "no " + typeName + " named '" + defName + "' is loaded");
                return def;
            }

            throw new InvalidOperationException("no def database for type '" + typeName + "'");
        }

        // ---------------------------------------------------------------- who owns a def

        private static ModContentPack RunningMod(PickleContext ctx, string packageId)
        {
            ModContentPack pack = LoadedModManager.RunningModsListForReading.FirstOrDefault(
                m => string.Equals(m.PackageId, packageId, StringComparison.OrdinalIgnoreCase)
                     || string.Equals(m.PackageIdPlayerFacing, packageId, StringComparison.OrdinalIgnoreCase));
            ctx.Require(pack != null, "no running mod has the packageId '" + packageId + "'");
            return pack;
        }

        /// <summary>
        /// Whether a mod carries a def of this type and name in its own list, whatever became of it in the
        /// game's database. Two mods defining one name are not refused and not logged: the database keeps the
        /// later one, and the earlier mod still lists its own copy, which is what this reads.
        /// </summary>
        [Then("Moa Renew: the mod {string} defines a {word} named {string}")]
        public void ModDefines(PickleContext ctx, string packageId, string typeName, string defName)
        {
            ModContentPack pack = RunningMod(ctx, packageId);
            bool found = pack.AllDefs.Any(
                d => d.defName == defName && string.Equals(d.GetType().Name, typeName, StringComparison.OrdinalIgnoreCase));
            ctx.Assert(found, "the mod '" + packageId + "' does not define a " + typeName + " named '" + defName + "'");
        }

        /// <summary>Walks a dotted path of public fields and properties. Null when any link is null.</summary>
        private static object Walk(object start, string path)
        {
            object current = start;
            foreach (string segment in path.Split('.'))
            {
                if (current == null)
                {
                    return null;
                }

                const BindingFlags flags = BindingFlags.Public | BindingFlags.Instance;
                Type type = current.GetType();
                FieldInfo field = type.GetField(segment, flags);
                if (field != null)
                {
                    current = field.GetValue(current);
                    continue;
                }

                PropertyInfo property = type.GetProperty(segment, flags);
                if (property == null)
                {
                    throw new InvalidOperationException("'" + segment + "' is not a public field or property of " + type.Name);
                }

                current = property.GetValue(current, null);
            }

            return current;
        }

        /// <summary>
        /// Reads a value off a loaded def by a dotted path and compares it, case insensitively, with the text.
        /// The type is a def type such as ThingDef, PawnKindDef or BodyDef: the same name is a ThingDef and a
        /// PawnKindDef for every species here, which Pickle's own step refuses to choose between.
        /// </summary>
        [Then("Moa Renew: the {word} {string} reads {string} as {string}")]
        public void ReadsAs(PickleContext ctx, string typeName, string defName, string path, string expected)
        {
            Def def = FindDef(ctx, typeName, defName);
            string actual = Walk(def, path)?.ToString() ?? "(null)";
            ctx.Assert(
                string.Equals(actual, expected, StringComparison.OrdinalIgnoreCase),
                typeName + " '" + defName + "' reads '" + path + "' as '" + actual + "', expected '" + expected + "'");
        }

        // ---------------------------------------------------------------- what the two compatibility patches add

        /// <summary>
        /// The extension is found by the full name of its class and read by reflection, so this suite has no
        /// reference to the mod that owns the class: without that mod the class does not exist, and the pass
        /// that stages it is the only one that plays these steps.
        /// </summary>
        private static DefModExtension ExtensionOf(PickleContext ctx, Def def, string className)
        {
            DefModExtension extension = def.modExtensions == null
                ? null
                : def.modExtensions.FirstOrDefault(e => e != null && e.GetType().FullName == className);
            ctx.Require(extension != null, def.GetType().Name + " '" + def.defName + "' carries no extension of class '" + className + "'");
            return extension;
        }

        private static List<string> CanCrossBreedWith(PickleContext ctx, string defName)
        {
            ThingDef def = (ThingDef)FindDef(ctx, "ThingDef", defName);
            ctx.Require(def.race != null, "ThingDef '" + defName + "' has no race");
            return def.race.canCrossBreedWith == null
                ? new List<string>()
                : def.race.canCrossBreedWith.Select(d => d.defName).ToList();
        }

        [Then("Moa Renew: the ThingDef {string} can cross with {string}")]
        public void CanCross(PickleContext ctx, string defName, string other)
        {
            List<string> list = CanCrossBreedWith(ctx, defName);
            ctx.Assert(list.Contains(other), "ThingDef '" + defName + "' can cross with [" + string.Join(", ", list) + "], not with '" + other + "'");
        }

        [Then("Moa Renew: the ThingDef {string} cannot cross with {string}")]
        public void CannotCross(PickleContext ctx, string defName, string other)
        {
            List<string> list = CanCrossBreedWith(ctx, defName);
            ctx.Assert(!list.Contains(other), "ThingDef '" + defName + "' can cross with '" + other + "', which it should not");
        }

        /// <summary>
        /// What Better Crossbreeding will make of the offspring, read off the mother's kind: the outcomes are
        /// named after the father, and the label is the behaviour, with the weighted kinds for Other.
        /// </summary>
        [Then("Moa Renew: the PawnKindDef {string} bred with {string} gives {string}")]
        public void BredWithGives(PickleContext ctx, string motherName, string fatherName, string expected)
        {
            DefModExtension extension = ExtensionOf(ctx, FindDef(ctx, "PawnKindDef", motherName), "DZY.CrossBreeding.Extension");
            IEnumerable outcomes = Walk(extension, "outcomes") as IEnumerable;
            ctx.Require(outcomes != null, "the crossbreeding extension of '" + motherName + "' has no outcomes");
            foreach (object outcome in outcomes)
            {
                Def father = Walk(outcome, "kindDef") as Def;
                if (father == null || father.defName != fatherName)
                {
                    continue;
                }

                string label = Walk(outcome, "behavior")?.ToString() ?? "(null)";
                if (label == "Other")
                {
                    IList kinds = Walk(outcome, "childrenKinds") as IList;
                    IList weights = Walk(outcome, "childrenWeights") as IList;
                    ctx.Require(kinds != null && weights != null && kinds.Count == weights.Count, "the Other outcome of '" + motherName + "' has no matching kinds and weights");
                    for (int i = 0; i < kinds.Count; i++)
                    {
                        label += " " + ((Def)kinds[i]).defName + "=" + weights[i];
                    }
                }

                ctx.Assert(label == expected, "PawnKindDef '" + motherName + "' bred with '" + fatherName + "' gives '" + label + "', expected '" + expected + "'");
                return;
            }

            ctx.Assert(false, "PawnKindDef '" + motherName + "' has no outcome for a father '" + fatherName + "'");
        }

        /// <summary>
        /// The statBases entry itself, not the computed stat. The fault this port exists to fix was a
        /// wildness the game never read: a species without the entry falls back to the stat's default, -1,
        /// and looks perfectly normal, so a missing entry fails here instead of comparing a default.
        /// </summary>
        [Then("Moa Renew: the ThingDef {string} has the stat {string} at {float}")]
        public void HasStatAt(PickleContext ctx, string defName, string statName, float expected)
        {
            ThingDef def = (ThingDef)FindDef(ctx, "ThingDef", defName);
            StatDef stat = DefDatabase<StatDef>.GetNamedSilentFail(statName);
            ctx.Require(stat != null, "no StatDef named '" + statName + "' is loaded");
            StatModifier entry = def.statBases == null ? null : def.statBases.FirstOrDefault(m => m.stat == stat);
            ctx.Require(
                entry != null,
                "ThingDef '" + defName + "' has no statBases entry for '" + statName + "'; it falls back to the stat's default of "
                + stat.defaultBaseValue);
            ctx.Assert(
                Math.Abs(entry.value - expected) < 0.0001f,
                "ThingDef '" + defName + "' statBases '" + statName + "' is " + entry.value + ", expected " + expected);
        }

        /// <summary>A melee tool of the species carries this label, as the game holds it after translation.</summary>
        [Then("Moa Renew: the ThingDef {string} has a tool labelled {string}")]
        public void HasToolLabelled(PickleContext ctx, string defName, string label)
        {
            ThingDef def = (ThingDef)FindDef(ctx, "ThingDef", defName);
            List<string> labels = def.tools == null ? new List<string>() : def.tools.Select(t => t.label ?? string.Empty).ToList();
            ctx.Assert(
                labels.Any(l => string.Equals(l, label, StringComparison.OrdinalIgnoreCase)),
                "ThingDef '" + defName + "' has no tool labelled '" + label + "'; its tools are: " + string.Join(", ", labels));
        }

        private static List<string> RecipesOf(PickleContext ctx, string defName, string recipeName)
        {
            ThingDef def = (ThingDef)FindDef(ctx, "ThingDef", defName);
            ctx.Require(
                DefDatabase<RecipeDef>.GetNamedSilentFail(recipeName) != null,
                "no RecipeDef named '" + recipeName + "' is loaded: is the mod that defines it staged in this pass?");
            return def.AllRecipes.Select(r => r.defName).ToList();
        }

        /// <summary>
        /// The species is a user of the recipe, the way the health tab offers it: through ThingDef.AllRecipes,
        /// which is built from every recipe's recipeUsers once the defs have resolved. This is what the
        /// compatibility patch for A Dog Said 2 has to end up doing, and it only does when the patch ran
        /// before that mod copied its category lists into its real recipes.
        /// </summary>
        [Then("Moa Renew: the ThingDef {string} can be operated on with {string}")]
        public void CanBeOperatedOnWith(PickleContext ctx, string defName, string recipeName)
        {
            List<string> recipes = RecipesOf(ctx, defName, recipeName);
            ctx.Assert(
                recipes.Contains(recipeName),
                "ThingDef '" + defName + "' cannot be operated on with '" + recipeName + "'; it has " + recipes.Count + " recipes");
        }

        /// <summary>The other half: a species below the category of a recipe must not be offered it.</summary>
        [Then("Moa Renew: the ThingDef {string} cannot be operated on with {string}")]
        public void CannotBeOperatedOnWith(PickleContext ctx, string defName, string recipeName)
        {
            List<string> recipes = RecipesOf(ctx, defName, recipeName);
            ctx.Assert(
                !recipes.Contains(recipeName),
                "ThingDef '" + defName + "' can be operated on with '" + recipeName + "', which its category should not offer");
        }

        [Then("Moa Renew: the ThingDef {string} lays {string} fertilized and {string} unfertilized")]
        public void Lays(PickleContext ctx, string defName, string fertilized, string unfertilized)
        {
            ThingDef def = (ThingDef)FindDef(ctx, "ThingDef", defName);
            CompProperties_EggLayer layer = def.comps.OfType<CompProperties_EggLayer>().FirstOrDefault();
            ctx.Require(layer != null, "ThingDef '" + defName + "' has no egg layer");
            string f = layer.eggFertilizedDef == null ? "(null)" : layer.eggFertilizedDef.defName;
            string u = layer.eggUnfertilizedDef == null ? "(null)" : layer.eggUnfertilizedDef.defName;
            ctx.Assert(f == fertilized && u == unfertilized, "ThingDef '" + defName + "' lays '" + f + "' fertilized and '" + u + "' unfertilized, expected '" + fertilized + "' and '" + unfertilized + "'");
        }

        [Then("Moa Renew: the egg {string} hatches into the kind {string}")]
        public void Hatches(PickleContext ctx, string eggName, string kindName)
        {
            ThingDef egg = (ThingDef)FindDef(ctx, "ThingDef", eggName);
            CompProperties_Hatcher hatcher = egg.comps.OfType<CompProperties_Hatcher>().FirstOrDefault();
            ctx.Require(hatcher != null, "ThingDef '" + eggName + "' has no hatcher");
            string kind = hatcher.hatcherPawn == null ? "(null)" : hatcher.hatcherPawn.defName;
            ctx.Assert(kind == kindName, "egg '" + eggName + "' hatches into '" + kind + "', expected '" + kindName + "'");
        }

        // ---------------------------------------------------------------- eggs, hatching, butchering (a loaded map)

        private static Pawn Generate(PickleContext ctx, string kindName, Gender gender)
        {
            PawnKindDef kind = DefDatabase<PawnKindDef>.GetNamedSilentFail(kindName);
            ctx.Require(kind != null, "no pawn kind '" + kindName + "'");
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "no current map: load a save first");
            var ages = kind.RaceProps.lifeStageAges;
            float adult = ages != null && ages.Count > 0 ? ages[ages.Count - 1].minAge : 0f;
            var request = new PawnGenerationRequest(kind, Faction.OfPlayer, PawnGenerationContext.NonPlayer, -1, forceGenerateNewPawn: true,
                fixedGender: gender, fixedBiologicalAge: adult);
            Pawn pawn = PawnGenerator.GeneratePawn(request);
            ctx.Require(CellFinder.TryFindRandomCellNear(map.Center, map, 30, c => c.Standable(map) && c.GetFirstPawn(map) == null, out IntVec3 cell, 400),
                "no free cell near the map centre for a '" + kindName + "'");
            GenSpawn.Spawn(pawn, cell, map, WipeMode.Vanish);
            ctx.Require(pawn.Spawned, "the '" + kindName + "' could not be placed at " + cell);
            return pawn;
        }

        private static Gender GenderOf(PickleContext ctx, string word)
        {
            ctx.Require(word == "female" || word == "male", "gender must be female or male, not '" + word + "'");
            return word == "female" ? Gender.Female : Gender.Male;
        }

        /// <summary>The egg the layer builds when no male reached the female: the unfertilized def, no hatcher.</summary>
        [Then("Moa Renew: a female {string} without a mate builds the egg {string}")]
        public void UnfertilizedEgg(PickleContext ctx, string kindName, string eggName)
        {
            Pawn mother = Generate(ctx, kindName, Gender.Female);
            CompEggLayer layer = mother.TryGetComp<CompEggLayer>();
            ctx.Require(layer != null, "the '" + kindName + "' has no egg layer");
            Thing egg = layer.ProduceEgg();
            ctx.Require(egg != null, "the layer built no egg");
            ctx.Assert(egg.def.defName == eggName, "the unmated '" + kindName + "' built '" + egg.def.defName + "', expected '" + eggName + "'");
            ctx.Assert(egg.TryGetComp<CompHatcher>() == null, "the unfertilized egg '" + eggName + "' has a hatcher");
        }

        /// <summary>Fertilizes, lays, then forces the incubation to its end (the 7 days are the game's, not asserted) and reads what is born.</summary>
        [Then("Moa Renew: a female {string} fertilized by a male {string} builds the egg {string}, which hatches into a {string} or a {string}")]
        public void FertilizedEggHatches(PickleContext ctx, string motherKind, string fatherKind, string eggName, string kindA, string kindB)
        {
            Map map = Find.CurrentMap;
            Pawn mother = Generate(ctx, motherKind, Gender.Female);
            Pawn father = Generate(ctx, fatherKind, Gender.Male);
            CompEggLayer layer = mother.TryGetComp<CompEggLayer>();
            ctx.Require(layer != null, "the '" + motherKind + "' has no egg layer");
            for (int i = 0; i < 50 && !layer.FullyFertilized; i++)
            {
                layer.Fertilize(father);
            }

            ctx.Require(layer.FullyFertilized, "the layer is not fully fertilized after 50 matings");
            Thing egg = layer.ProduceEgg();
            ctx.Require(egg != null, "the layer built no egg");
            ctx.Assert(egg.def.defName == eggName, "the fertilized '" + motherKind + "' built '" + egg.def.defName + "', expected '" + eggName + "'");
            CompHatcher hatcher = egg.TryGetComp<CompHatcher>();
            ctx.Require(hatcher != null, "the fertilized egg has no hatcher");
            IntVec3 cell = mother.Position;
            GenSpawn.Spawn(egg, cell, map, WipeMode.Vanish);
            FieldInfo progress = typeof(CompHatcher).GetField("gestateProgress", BindingFlags.Instance | BindingFlags.NonPublic);
            ctx.Require(progress != null, "CompHatcher has no field gestateProgress in this game version");
            progress.SetValue(hatcher, 1f);
            hatcher.Hatch();
            List<Pawn> born = map.mapPawns.AllPawnsSpawned.Where(p => p != mother && p != father && p.RaceProps.Animal && p.ageTracker.CurLifeStage.developmentalStage.Baby() && (p.kindDef.defName == kindA || p.kindDef.defName == kindB)).ToList();
            ctx.Assert(born.Count == 1, "the egg hatched " + born.Count + " young of kind '" + kindA + "' or '" + kindB + "', expected one");
        }

        /// <summary>What a butcher gets from the animal: the meat and the leather its race names, in a real quantity.</summary>
        [Then("Moa Renew: butchering a {string} gives its meat and its leather")]
        public void Butchering(PickleContext ctx, string kindName)
        {
            Pawn animal = Generate(ctx, kindName, Gender.Female);
            Pawn butcher = Find.CurrentMap.mapPawns.FreeColonists.FirstOrDefault();
            ctx.Require(butcher != null, "the loaded map has no colonist to butcher with");
            ThingDef meat = animal.RaceProps.meatDef;
            ThingDef leather = animal.RaceProps.leatherDef;
            ctx.Require(meat != null, "the race '" + kindName + "' names no meat");
            List<Thing> products = animal.ButcherProducts(butcher, 1f).ToList();
            int meatCount = products.Where(t => t.def == meat).Sum(t => t.stackCount);
            ctx.Assert(meatCount > 0, "butchering a '" + kindName + "' gave no '" + meat.defName + "'");
            if (leather != null)
            {
                ctx.Assert(products.Any(t => t.def == leather), "butchering a '" + kindName + "' gave no '" + leather.defName + "'");
            }
        }
    }
}
