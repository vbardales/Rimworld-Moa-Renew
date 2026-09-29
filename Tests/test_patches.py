"""Applies the real patch files to the real Core (and ADS 2) definitions with lxml (XPath 1.0, like the game).
Run: uv run --with lxml python Tests/test_patches.py   No game process needed."""
import copy, os, unittest
from pathlib import Path
from lxml import etree as LX

ROOT = Path(__file__).resolve().parents[1]
MOD = ROOT / 'Mod'
GAME = Path(os.environ.get('RIMWORLD_DIR', r'C:\Program Files (x86)\Steam\steamapps\common\RimWorld'))
WORKSHOP = Path(os.environ.get('RIMWORLD_WORKSHOP', r'C:\Program Files (x86)\Steam\steamapps\workshop\content\294100'))
BC = 'Better Crossbreeding'
BC_CLASS = 'DZY.CrossBreeding.Extension'
OPS = {'PatchOperationSequence', 'PatchOperationFindMod', 'PatchOperationConditional',
       'PatchOperationAdd', 'PatchOperationAddModExtension'}


def els(n): return [c for c in n if isinstance(c.tag, str)]
def absx(x): x = x.strip(); return x if x.startswith('/') else '/' + x


def apply(op, doc, active):
    cls = op.get('Class'); assert cls in OPS, cls
    if cls == 'PatchOperationSequence':
        for c in els(op.find('operations')): apply(c, doc, active)
    elif cls == 'PatchOperationFindMod':
        br = op.find('match') if any(li.text in active for li in op.find('mods')) else op.find('nomatch')
        if br is not None: apply(br, doc, active)
    elif cls == 'PatchOperationConditional':
        br = op.find('match') if doc.xpath(absx(op.findtext('xpath'))) else op.find('nomatch')
        if br is not None: apply(br, doc, active)
    elif cls == 'PatchOperationAdd':
        for n in doc.xpath(absx(op.findtext('xpath'))):
            for c in els(op.find('value')): n.append(copy.deepcopy(c))
    else:
        for n in doc.xpath(absx(op.findtext('xpath'))):
            h = n.find('modExtensions')
            if h is None: h = LX.SubElement(n, 'modExtensions')
            for c in els(op.find('value')): h.append(copy.deepcopy(c))


def patch(name, doc, active=()):
    for op in LX.parse(str(MOD / 'Patches' / name)).getroot().findall('Operation'):
        apply(op, doc, set(active))


def fresh():
    root = LX.Element('Defs')
    for folder in (GAME / 'Data/Core/Defs', MOD / 'Defs'):
        for f in sorted(folder.rglob('*.xml')):
            for c in LX.parse(str(f)).getroot():
                if isinstance(c.tag, str): root.append(c)
    return LX.ElementTree(root)


def crossers(doc, name):
    return [li.text for li in doc.xpath(f'/Defs/ThingDef[defName="{name}"]/race/canCrossBreedWith/li')]


def outcomes(doc, kind):
    return {f.tag: els(f)[0].tag for o in doc.xpath(
        f'/Defs/PawnKindDef[defName="{kind}"]/modExtensions/li[@Class="{BC_CLASS}"]/outcomes') for f in els(o)}


class Patches(unittest.TestCase):
    def test_guards(self):
        for f in (MOD / 'Patches').glob('*.xml'):
            for op in LX.parse(str(f)).getroot().findall('Operation'):
                self.assertNotIn('MayRequire', op.attrib, f.name)

    def test_ads2_load_order_and_no_dependency(self):
        about = LX.parse(str(MOD / 'About/About.xml')).getroot()
        self.assertIn('SamBucher.ADogSaidAnimalProsthetics2', [e.text for e in about.findall('loadBefore/li')])
        self.assertEqual(about.findall('modDependencies/li'), [])

    def ads_doc(self):
        doc = fresh()
        src = LX.parse(str(WORKSHOP / '3238353862/1.6/Defs/AnimalCategories/Animal_Categories.xml')).getroot()
        for c in els(src): doc.getroot().append(c)
        unrelated = LX.SubElement(doc.getroot(), 'RecipeDef')
        LX.SubElement(unrelated, 'defName').text = 'Unrelated'
        LX.SubElement(LX.SubElement(unrelated, 'recipeUsers'), 'li').text = 'Cat'
        return doc

    def test_ads2_moa_where_the_emu_is(self):
        doc = self.ads_doc()
        emu = {c: 'Emu' in [li.text for li in doc.xpath(f'/Defs/RecipeDef[@Name="{c}"]/recipeUsers/li')]
               for c in ('ADS_Cat1', 'ADS_Cat2', 'ADS_Cat3')}
        self.assertEqual(emu, {'ADS_Cat1': True, 'ADS_Cat2': True, 'ADS_Cat3': False})
        patch('AnimalProsthetics2.xml', doc)
        for c, has_emu in emu.items():
            users = [li.text for li in doc.xpath(f'/Defs/RecipeDef[@Name="{c}"]/recipeUsers/li')]
            self.assertEqual('Moa' in users, has_emu, c)
        self.assertEqual([li.text for li in doc.xpath('/Defs/RecipeDef[defName="Unrelated"]/recipeUsers/li')], ['Cat'])

    def test_ads2_absent_changes_nothing(self):
        doc = fresh(); before = LX.tostring(doc)
        patch('AnimalProsthetics2.xml', doc)
        self.assertEqual(LX.tostring(doc), before)

    def test_ads2_test_can_fail(self):
        # Put the always-true predicate trap back into a copy of the patch: the same assertions must go red.
        doc = self.ads_doc()
        bad = LX.parse(str(MOD / "Patches/AnimalProsthetics2.xml")).getroot()
        for x in bad.iter("xpath"):
            x.text = x.text.replace('[@Name="ADS_Cat2"]', '[@Name="ADS_Cat1" or "ADS_Cat2" or "ADS_Cat3"]')
        for op in bad.findall("Operation"):
            apply(op, doc, set())
        cat3 = [li.text for li in doc.xpath('/Defs/RecipeDef[@Name="ADS_Cat3"]/recipeUsers/li')]
        self.assertIn("Moa", cat3, "the trap must reach Cat3, which the real patch never does")

    def test_crossbreeding_both_ways(self):
        doc = fresh()
        self.assertEqual(crossers(doc, 'Moa'), ['Emu'])
        patch('EmuCrossbreeding.xml', doc)
        self.assertEqual(crossers(doc, 'Emu'), ['Moa'])

    def test_emu_existing_list_is_appended_not_duplicated(self):
        doc = fresh()
        race = doc.xpath('/Defs/ThingDef[defName="Emu"]/race')[0]
        LX.SubElement(LX.SubElement(race, 'canCrossBreedWith'), 'li').text = 'Cassowary'
        patch('EmuCrossbreeding.xml', doc)
        self.assertEqual(len(doc.xpath('/Defs/ThingDef[defName="Emu"]/race/canCrossBreedWith')), 1)
        self.assertEqual(crossers(doc, 'Emu'), ['Cassowary', 'Moa'])

    def test_bc_absent_changes_nothing(self):
        doc = fresh(); before = LX.tostring(doc)
        patch('BetterCrossbreeding.xml', doc)
        self.assertEqual(LX.tostring(doc), before)

    def test_bc_present_random_both_ways(self):
        doc = fresh(); patch('BetterCrossbreeding.xml', doc, {BC})
        self.assertEqual(outcomes(doc, 'Moa'), {'Emu': 'Random'})
        self.assertEqual(outcomes(doc, 'Emu'), {'Moa': 'Random'})

    def test_bc_existing_extension_is_reused(self):
        doc = fresh()
        k = doc.xpath('/Defs/PawnKindDef[defName="Emu"]')[0]
        ext = LX.SubElement(LX.SubElement(k, 'modExtensions'), 'li', Class=BC_CLASS)
        LX.SubElement(ext, 'outcomes'); LX.SubElement(ext[0], 'Cat').append(LX.Element('Paternal'))
        patch('BetterCrossbreeding.xml', doc, {BC})
        self.assertEqual(len(doc.xpath(f'/Defs/PawnKindDef[defName="Emu"]/modExtensions/li[@Class="{BC_CLASS}"]')), 1)
        self.assertEqual(outcomes(doc, 'Emu'), {'Cat': 'Paternal', 'Moa': 'Random'})


if __name__ == '__main__':
    unittest.main(verbosity=2)
