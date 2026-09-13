import json
from pathlib import Path
from PIL import Image
root = Path(__file__).resolve().parent
p = json.loads((root/'preview-palette.json').read_text(encoding='utf-8-sig'))
layout = json.loads((root/'preview-layout-check.json').read_text())
bg = Image.open(root/'Preview-background-check.png').convert('RGB')
def lum(rgb):
    a = [v/255 for v in rgb]
    a = [v/12.92 if v<=.04045 else ((v+.055)/1.055)**2.4 for v in a]
    return sum(v*w for v,w in zip(a,(.2126,.7152,.0722)))
def rgb(h): return tuple(int(h[i:i+2],16) for i in (1,3,5))
def contrast(a,b):
    x,y=sorted((lum(a),lum(b)))
    return (y+.05)/(x+.05)
results={}
for key,color in [('h1','inkPrimary'),('h1 span','inkSecondary'),('p','inkPrimary')]:
    b=layout['boxes'][key]
    ratios=[contrast(rgb(p[color]),bg.getpixel((x,y))) for x in range(int(b['x']),min(896,int(b['x']+b['width'])+1)) for y in range(int(b['y']),min(504,int(b['y']+b['height'])+1))]
    results[key]=round(min(ratios),3)
results['badge']=round(contrast(rgb(p['badgeInk']),rgb(p['accent'])),3)
image=Image.open(root/'../Mod/About/Preview.png')
results.update(size=list(image.size),bytes=(root/'../Mod/About/Preview.png').stat().st_size,font=layout['font'])
assert image.size==(896,504)
assert results['bytes']<1000000
assert all(results[k]>=4.5 for k in ('h1','h1 span','p','badge'))
(root/'preview-validation.json').write_text(json.dumps(results,indent=2))
print(json.dumps(results))
