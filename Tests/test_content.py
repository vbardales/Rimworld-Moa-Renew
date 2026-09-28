"""Run with Python 3; no game process or third-party Python packages required."""
from pathlib import Path
import hashlib, json, re, xml.etree.ElementTree as ET
root=Path(__file__).resolve().parents[1]
mod=root/'Mod'
parsed={p:ET.parse(p).getroot() for p in mod.rglob('*.xml')}
defs={}
for p,tree in parsed.items():
    if tree.tag!='Defs': continue
    for d in tree:
        key=(d.tag,d.findtext('defName'))
        assert key not in defs, f'Duplicate definition: {key}'
        defs[key]=d
inventory={}
for (kind,name),d in defs.items():
    for field in ('label','description','race/meatLabel'):
        value=d.findtext(field)
        if value is not None:
            assert value.strip(), f'Empty source: {name}/{field}'
            inventory[(kind,name+'.'+field.replace('/','.'))]=value
    for tool in d.findall('tools/li'):
        value=tool.findtext('label')
        if value:
            inventory[(kind,name+'.tools.'+value+'.label')]=value
translations={}
for p,tree in parsed.items():
    if 'French' not in p.parts: continue
    assert tree.tag=='LanguageData'
    for n in tree:
        key=(p.parent.name,n.tag)
        assert key not in translations, f'Duplicate translation: {key}'
        assert n.text and n.text.strip() and not re.search(r'TODO|TODO_TRANSLATE',n.text)
        translations[key]=n.text
assert inventory.keys()==translations.keys(), f'Coverage mismatch: {inventory.keys() ^ translations.keys()}'
for key,en in inventory.items():
    assert re.findall(r'\{[^}]+\}',en)==re.findall(r'\{[^}]+\}',translations[key]), f'Parameter mismatch: {key}'
race=defs[('ThingDef','Moa')]
layer=race.find("comps/li[@Class='CompProperties_EggLayer']")
assert layer is not None
for field in ('eggFertilizedDef','eggUnfertilizedDef'):
    assert ('ThingDef',layer.findtext(field)) in defs, f'Missing egg target: {field}'
egg=defs[('ThingDef',layer.findtext('eggFertilizedDef'))]
assert egg.findtext("comps/li[@Class='CompProperties_Hatcher']/hatcherPawn")=='Moa'
assert defs[('PawnKindDef','Moa')].findtext('race')=='Moa'
assert race.find('race/wildness') is None
assert 0<=float(race.findtext('statBases/Wildness'))<=1
for tex in defs[('PawnKindDef','Moa')].findall('lifeStages/li/bodyGraphicData/texPath'):
    for direction in ('north','east','south'):
        assert (mod/'Textures'/(tex.text+'_'+direction+'.png')).is_file()
meta=parsed[mod/'About'/'About.xml']
assert meta.findtext('packageId')=='nelim.moa'
assert meta.findtext('description').strip().endswith('[url='+meta.findtext('url')+']Source code on GitHub[/url]')
assert (root/'LICENSE').read_bytes()==(mod/'LICENSE').read_bytes()
manifest={str(p.relative_to(root)).replace('\\','/'):hashlib.sha256(p.read_bytes()).hexdigest() for p in sorted(mod.rglob('*')) if p.is_file()}
(root/'Tests'/'payload-sha256.json').write_text(json.dumps(manifest,indent=2)+'\n')
print(f'PASS: {len(parsed)} XML files parsed; {len(defs)} unique typed definitions; {len(inventory)} English/French fields fully covered.')
print('PASS: egg/hatcher/race links, Wildness migration, directional textures, package ID, source link and licence copies.')
print('Payload SHA256 manifest written. This is static validation, not a game test.')
