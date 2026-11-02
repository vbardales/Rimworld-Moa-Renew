<#
.SYNOPSIS
  Moa Renew's own expected values: egg/hatcher/race links, Wildness, textures, About text, and what the three patch files do
  to the real Core 1.6 and ADS 2 defs. No game process.

.DESCRIPTION
  The generic half (XML parses, duplicate defNames, French coverage, parameter tokens, licence copies) is done by the shared
  checks and not repeated here:
    powershell -NoProfile -ExecutionPolicy Bypass -File ..\scripts\Check-ModBasics.ps1 -ModRoot .
    powershell -NoProfile -ExecutionPolicy Bypass -File ..\scripts\Check-Translations.ps1 -ModRoot .
  Patches go through the shared interpreter scripts/lib/PatchEngine.ps1, the runner is scripts/lib/TestRunner.ps1.
  Writes Tests/payload-sha256.json (the SHA256 of every file of Mod/).

    powershell -NoProfile -ExecutionPolicy Bypass -File Tests/Test-Moa.ps1
#>
param(
  [string]$GameData = $(if ($env:RIMWORLD_DIR) { Join-Path $env:RIMWORLD_DIR 'Data' } else { 'C:\Program Files (x86)\Steam\steamapps\common\RimWorld\Data' }),
  [string]$Workshop = $(if ($env:RIMWORLD_WORKSHOP) { $env:RIMWORLD_WORKSHOP } else { 'C:\Program Files (x86)\Steam\steamapps\workshop\content\294100' })
)
$ErrorActionPreference = 'Stop'
$repo = Split-Path $PSScriptRoot -Parent
$mod = Join-Path $repo 'Mod'
$protocols = Split-Path $repo -Parent
. (Join-Path $protocols 'scripts\lib\PatchEngine.ps1')
. (Join-Path $protocols 'scripts\lib\TestRunner.ps1')

$BC = 'Better Crossbreeding'
$BCClass = 'DZY.CrossBreeding.Extension'

function Load-Xml([string]$Path) { $x = New-Object System.Xml.XmlDocument; $x.PreserveWhitespace = $false; $x.Load($Path); $x }
function Add-Defs($Doc, [string]$Path) {
  foreach ($c in (Load-Xml $Path).DocumentElement.ChildNodes) { if ($c.NodeType -eq 'Element') { [void]$Doc.DocumentElement.AppendChild($Doc.ImportNode($c, $true)) } }
}
# Core defs plus this mod's own, as the game stacks them before the patches run.
function New-Doc {
  $doc = New-Object System.Xml.XmlDocument
  [void]$doc.AppendChild($doc.CreateElement('Defs'))
  foreach ($folder in (Join-Path $GameData 'Core\Defs'), (Join-Path $mod 'Defs')) {
    foreach ($f in Get-ChildItem $folder -Recurse -Filter *.xml | Sort-Object FullName) { Add-Defs $doc $f.FullName }
  }
  $doc
}
function Apply-Patch($Doc, [string]$Name, [string[]]$Active = @()) { Invoke-PatchFile (Join-Path $mod "Patches\$Name") $Doc -ActiveMods $Active }
function Texts($Doc, [string]$XPath) { @($Doc.SelectNodes($XPath) | ForEach-Object { $_.InnerText }) }
function Crossers($Doc, [string]$Name) { Texts $Doc "/Defs/ThingDef[defName='$Name']/race/canCrossBreedWith/li" }
function Outcomes($Doc, [string]$Kind) {
  $h = @{}
  foreach ($o in $Doc.SelectNodes("/Defs/PawnKindDef[defName='$Kind']/modExtensions/li[@Class='$BCClass']/outcomes/*")) { $h[$o.Name] = $o.FirstChild.Name }
  $h
}
function Same($a, $b) { (@($a) -join '|') -eq (@($b) -join '|') }
function New-AdsDoc {
  $doc = New-Doc
  Add-Defs $doc (Join-Path $Workshop '3238353862\1.6\Defs\AnimalCategories\Animal_Categories.xml')
  $r = $doc.CreateElement('RecipeDef')
  $r.InnerXml = '<defName>Unrelated</defName><recipeUsers><li>Cat</li></recipeUsers>'
  [void]$doc.DocumentElement.AppendChild($r)
  $doc
}
function Ads-Users($Doc, [string]$Cat) { Texts $Doc "/Defs/RecipeDef[@Name='$Cat']/recipeUsers/li" }

Write-Host 'Content'
$defs = New-Object System.Xml.XmlDocument
[void]$defs.AppendChild($defs.CreateElement('Defs'))
foreach ($f in Get-ChildItem (Join-Path $mod 'Defs') -Recurse -Filter *.xml) { Add-Defs $defs $f.FullName }
function Def($Type, $Name) { $defs.SelectSingleNode("/Defs/$Type[defName='$Name']") }
$race = Def 'ThingDef' 'Moa'
$kind = Def 'PawnKindDef' 'Moa'
$about = Load-Xml (Join-Path $mod 'About\About.xml')

Test-That 'the Moa lays an egg whose hatcher is the Moa' {
  $layer = $race.SelectSingleNode("comps/li[@Class='CompProperties_EggLayer']")
  if (-not $layer) { return $false }
  foreach ($f in 'eggFertilizedDef', 'eggUnfertilizedDef') { if (-not (Def 'ThingDef' $layer.SelectSingleNode($f).InnerText)) { throw "missing egg target $f" } }
  $egg = Def 'ThingDef' $layer.SelectSingleNode('eggFertilizedDef').InnerText
  $egg.SelectSingleNode("comps/li[@Class='CompProperties_Hatcher']/hatcherPawn").InnerText -eq 'Moa'
}
Test-That 'the Moa kind points at the Moa race' { $kind.SelectSingleNode('race').InnerText -eq 'Moa' }
Test-That 'Wildness moved to statBases (no race/wildness), within 0 to 1' {
  $w = [double]::Parse($race.SelectSingleNode('statBases/Wildness').InnerText, [Globalization.CultureInfo]::InvariantCulture)
  ($null -eq $race.SelectSingleNode('race/wildness')) -and $w -ge 0 -and $w -le 1
}
It 'every life stage has its north, east and south texture' {
  $tex = @($kind.SelectNodes('lifeStages/li/bodyGraphicData/texPath'))
  if (-not $tex.Count) { 'no texPath found' }
  foreach ($t in $tex) { foreach ($d in 'north', 'east', 'south') { $p = Join-Path $mod "Textures\$($t.InnerText)_$d.png"; if (-not (Test-Path $p)) { "missing $p" } } }
}
Test-That 'package ID is nelim.moa and the description ends with the source link' {
  $url = $about.SelectSingleNode('/ModMetaData/url').InnerText
  ($about.SelectSingleNode('/ModMetaData/packageId').InnerText -eq 'nelim.moa') -and
  $about.SelectSingleNode('/ModMetaData/description').InnerText.Trim().EndsWith("[url=$url]Source code on GitHub[/url]")
}
Test-That 'payload SHA256 manifest written' {
  $m = [ordered]@{}
  foreach ($f in Get-ChildItem $mod -Recurse -File | Sort-Object FullName) {
    $m[$f.FullName.Substring($repo.Length + 1).Replace('\', '/')] = (Get-FileHash $f.FullName -Algorithm SHA256).Hash.ToLower()
  }
  [IO.File]::WriteAllText((Join-Path $PSScriptRoot 'payload-sha256.json'), ((ConvertTo-Json $m) -replace "`r`n", "`n") + "`n")
  $m.Count -gt 0
}

Write-Host 'Patches'
Test-That 'no patch operation carries MayRequire' {
  $n = 0
  foreach ($f in Get-ChildItem (Join-Path $mod 'Patches') -Filter *.xml) { foreach ($op in (Load-Xml $f.FullName).SelectNodes('/Patch/Operation')) { $n++; if ($op.HasAttribute('MayRequire')) { throw $f.Name } } }
  $n -gt 0
}
Test-That 'ADS 2 is a loadBefore, not a dependency' {
  ((Texts $about '/ModMetaData/loadBefore/li') -contains 'SamBucher.ADogSaidAnimalProsthetics2') -and $about.SelectNodes('/ModMetaData/modDependencies/li').Count -eq 0
}
Test-That 'ADS 2: the Moa lands where the Emu is (Cat1, Cat2), not in Cat3, and Unrelated is untouched' {
  $doc = New-AdsDoc
  $emu = @{}; foreach ($c in 'ADS_Cat1', 'ADS_Cat2', 'ADS_Cat3') { $emu[$c] = (Ads-Users $doc $c) -contains 'Emu' }
  if (-not ($emu.ADS_Cat1 -and $emu.ADS_Cat2 -and -not $emu.ADS_Cat3)) { throw 'ADS 2 fixture no longer has the Emu in Cat1+Cat2 only' }
  Apply-Patch $doc 'AnimalProsthetics2.xml'
  foreach ($c in $emu.Keys) { if (((Ads-Users $doc $c) -contains 'Moa') -ne $emu[$c]) { throw "wrong Moa membership in $c" } }
  Same (Texts $doc "/Defs/RecipeDef[defName='Unrelated']/recipeUsers/li") @('Cat')
}
Test-That 'ADS 2 absent: the patch changes nothing' {
  $doc = New-Doc; $before = $doc.OuterXml
  Apply-Patch $doc 'AnimalProsthetics2.xml'
  $doc.OuterXml -eq $before
}
Test-That 'ADS 2 test can fail: the always-true predicate trap reaches Cat3' {
  $doc = New-AdsDoc
  $bad = Load-Xml (Join-Path $mod 'Patches\AnimalProsthetics2.xml')
  foreach ($x in $bad.SelectNodes('//xpath')) { $x.InnerText = $x.InnerText.Replace('[@Name="ADS_Cat2"]', '[@Name="ADS_Cat1" or "ADS_Cat2" or "ADS_Cat3"]') }
  foreach ($op in $bad.SelectNodes('/Patch/Operation')) { Invoke-PatchOperation $op $doc }
  (Ads-Users $doc 'ADS_Cat3') -contains 'Moa'
}
Test-That 'Emu crossbreeding: both ways' {
  $doc = New-Doc
  if (-not (Same (Crossers $doc 'Moa') @('Emu'))) { throw 'Moa must cross with the Emu before the patch' }
  Apply-Patch $doc 'EmuCrossbreeding.xml'
  Same (Crossers $doc 'Emu') @('Moa')
}
Test-That 'Emu crossbreeding: an existing list is appended to, not duplicated' {
  $doc = New-Doc
  $race = $doc.SelectSingleNode("/Defs/ThingDef[defName='Emu']/race")
  $list = $race.AppendChild($doc.CreateElement('canCrossBreedWith'))
  $li = $list.AppendChild($doc.CreateElement('li')); $li.InnerText = 'Cassowary'
  Apply-Patch $doc 'EmuCrossbreeding.xml'
  ($doc.SelectNodes("/Defs/ThingDef[defName='Emu']/race/canCrossBreedWith").Count -eq 1) -and (Same (Crossers $doc 'Emu') @('Cassowary', 'Moa'))
}
Test-That 'Better Crossbreeding absent: the patch changes nothing' {
  $doc = New-Doc; $before = $doc.OuterXml
  Apply-Patch $doc 'BetterCrossbreeding.xml'
  $doc.OuterXml -eq $before
}
Test-That 'Better Crossbreeding present: Random both ways' {
  $doc = New-Doc; Apply-Patch $doc 'BetterCrossbreeding.xml' @($BC)
  $m = Outcomes $doc 'Moa'; $e = Outcomes $doc 'Emu'
  ($m.Count -eq 1 -and $m.Emu -eq 'Random') -and ($e.Count -eq 1 -and $e.Moa -eq 'Random')
}
Test-That 'Better Crossbreeding present: an existing extension is reused' {
  $doc = New-Doc
  $k = $doc.SelectSingleNode("/Defs/PawnKindDef[defName='Emu']")
  $ext = $k.AppendChild($doc.CreateElement('modExtensions')).AppendChild($doc.CreateElement('li'))
  $ext.SetAttribute('Class', $BCClass)
  [void]$ext.AppendChild($doc.CreateElement('outcomes')).AppendChild($doc.CreateElement('Cat')).AppendChild($doc.CreateElement('Paternal'))
  Apply-Patch $doc 'BetterCrossbreeding.xml' @($BC)
  $o = Outcomes $doc 'Emu'
  ($doc.SelectNodes("/Defs/PawnKindDef[defName='Emu']/modExtensions/li[@Class='$BCClass']").Count -eq 1) -and $o.Count -eq 2 -and $o.Cat -eq 'Paternal' -and $o.Moa -eq 'Random'
}
Complete-Tests
