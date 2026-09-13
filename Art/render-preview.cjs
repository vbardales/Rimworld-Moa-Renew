const fs = require('fs');
const path = require('path');
const { chromium } = require(process.env.PLAYWRIGHT_MODULE || 'playwright');
(async () => {
 const dir = __dirname;
 const p = JSON.parse(fs.readFileSync(path.join(dir,'preview-palette.json'),'utf8').replace(/^\uFEFF/,''));
 const html = `<!doctype html><meta charset="utf-8"><style>
 *{box-sizing:border-box}html,body{margin:0;width:896px;height:504px;overflow:hidden;font-family:"Segoe UI",system-ui,sans-serif}
 body{background:url('Preview.png') center/cover no-repeat}
 .veil{position:absolute;inset:0;background:linear-gradient(90deg,${p.veil}f5 0%,${p.veil}ed 42%,${p.veil}80 58%,${p.veil}00 78%)}
 .copy{position:absolute;left:50px;top:54px;color:${p.inkPrimary};text-shadow:0 3px 10px rgba(0,0,0,.75)}
 h1{margin:0;font-size:46px;font-weight:600;line-height:1.1;letter-spacing:0}h1 span{font-size:.65em;color:${p.inkSecondary}}
 .rule{width:58px;height:3px;background:${p.accent};margin-top:20px;margin-bottom:16px}
 p{margin:0;width:430px;font-size:21px;font-weight:400;line-height:1.45;letter-spacing:0}
 .badge{position:absolute;right:0;top:0;width:80px;height:80px;background:${p.accent};clip-path:polygon(0 0,100% 0,100% 100%)}
 .version{position:absolute;left:869px;top:27px;transform:translate(-50%,-50%) rotate(45deg);font-size:26px;font-weight:700;line-height:1;color:${p.badgeInk}}
 </style><div class="veil"></div><div class="copy"><h1>Moa <span>Renew</span></h1><div class="rule"></div><p>Flightless birds from Reach.<br>Raise a flock for meat and eggs.</p></div><div class="badge"></div><div class="version">1.6</div>`;
 fs.writeFileSync(path.join(dir,'preview.html'),html);
 const browser = await chromium.launch({headless:true,executablePath:process.env.CHROME_PATH || 'C:/Program Files/Google/Chrome/Application/chrome.exe'});
 try {
  const page = await browser.newPage({viewport:{width:896,height:504},deviceScaleFactor:1});
  await page.goto('file:///'+path.join(dir,'preview.html').replace(/\\/g,'/'));
  await page.evaluate(()=>document.fonts.ready);
  const font = await page.evaluate(()=>({available:document.fonts.check('46px "Segoe UI"'),family:getComputedStyle(document.querySelector('h1')).fontFamily}));
  if(!font.available)throw Error('Segoe UI missing');
  await page.screenshot({path:path.join(dir,'../Mod/About/Preview.png')});
  const thumbnail = await browser.newPage({viewport:{width:268,height:151},deviceScaleFactor:1});
  const png = fs.readFileSync(path.join(dir,'../Mod/About/Preview.png')).toString('base64');
  await thumbnail.setContent(`<style>body{margin:0}img{display:block;width:268px;height:151px}</style><img src="data:image/png;base64,${png}">`);
  await thumbnail.locator('img').evaluate(img=>img.decode());
  await thumbnail.screenshot({path:path.join(dir,'Preview-check-268.png')});
  await thumbnail.close();
  const boxes = await page.evaluate(()=>Object.fromEntries(['h1','h1 span','p','.version'].map(s=>{const r=document.querySelector(s).getBoundingClientRect();return [s,{x:r.x,y:r.y,width:r.width,height:r.height}]})));
  await page.addStyleTag({content:'.copy,.version{visibility:hidden}'});
  await page.screenshot({path:path.join(dir,'Preview-background-check.png')});
  fs.writeFileSync(path.join(dir,'preview-layout-check.json'),JSON.stringify({font,boxes},null,2));
 } finally {await browser.close()}
})();


