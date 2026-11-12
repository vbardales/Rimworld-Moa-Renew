# Preview composition

`Preview-source.png`, `echo.png` and `ModIcon-source.png` are the retained generation
sources. Copy, palette and placement live in `Preview.config.json`.

Render from the mod root with `node ../scripts/Render-Preview.cjs`. The shared renderer writes
`Mod/About/Preview.png`, `Art/Gallery/0-preview.png`, `Art/Preview.ico` and `Art/ModIcon.ico`;
temporary reproducible checks are generated under `Art/.render/`.

`Moa` uses the RimWorld title font; `Renew` and the description use Segoe UI. The moa-and-nest
line-art is flipped horizontally, while the transparent ModIcon remains bottom-left at 15 degrees.
