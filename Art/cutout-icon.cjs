// Flood-fills the near-black background of ModIcon-source.png from its border inward, so only the background
// becomes transparent (the mascot's own near-black outline never touches the frame and stays). Writes
// ModIcon-cutout.png, the icon composited onto the Preview by render-preview.cjs. Run by hand if the icon changes.
// Needs sharp: NODE_PATH=<folder with node_modules> node cutout-icon.cjs
const sharp = require('sharp');
const path = require('path');
(async () => {
  const { data, info } = await sharp(path.join(__dirname, 'ModIcon-source.png')).ensureAlpha().raw().toBuffer({ resolveWithObject: true });
  const { width: w, height: h, channels: c } = info;
  const isBg = i => data[i] < 40 && data[i + 1] < 40 && data[i + 2] < 40;
  const seen = new Uint8Array(w * h);
  const stack = [];
  for (let x = 0; x < w; x++) stack.push([x, 0], [x, h - 1]);
  for (let y = 0; y < h; y++) stack.push([0, y], [w - 1, y]);
  let removed = 0;
  while (stack.length) {
    const [x, y] = stack.pop();
    if (x < 0 || y < 0 || x >= w || y >= h) continue;
    const p = y * w + x;
    if (seen[p] || !isBg(p * c)) continue;
    seen[p] = 1; data[p * c + 3] = 0; removed++;
    stack.push([x + 1, y], [x - 1, y], [x, y + 1], [x, y - 1]);
  }
  console.log(`removed ${removed} of ${w * h} pixels (${(100 * removed / (w * h)).toFixed(1)}%)`);
  await sharp(data, { raw: { width: w, height: h, channels: c } }).resize(480, 480).png({ compressionLevel: 9 }).toFile(path.join(__dirname, 'ModIcon-cutout.png'));
})();
