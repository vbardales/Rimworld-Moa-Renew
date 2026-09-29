# Pickle suite for Moa Renew

Companion mod `nelim.moa.pickletests` (development only, never published): `Mod/Pickle/Features/*.feature`, step DLL
`Mod/Pickle/Assemblies/MoaRenew.PickleSteps.dll` built from `Source/MoaSteps.cs` (`dotnet build Source/MoaRenew.PickleSteps.csproj -c Release`).
Every local step starts with "Moa Renew:" to stay unique in Pickle's single step namespace. The moa is a ThingDef and a PawnKindDef
of one name, so Pickle's own def steps cannot be used; the local ones name the def type. Scope, passes and what is not played: `../../TESTING.md`.

Check before filing a request: `powershell.exe -ExecutionPolicy Bypass -File Tests/Pickle/Check-Steps.ps1`.
File requests only with `Rimworld-Ticket-Dispatcher/scripts/Submit-PickleRun.ps1`, never a direct launch; see `../../TESTING.md` for the five passes.
