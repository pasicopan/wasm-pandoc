import * as rts from './rts.mjs';
import module from './wasm-pandoc.wasm.mjs';
import req from './wasm-pandoc.req.mjs';
import fs from 'fs'

async function handleModule(m) {
  console.log('handleModule: ');
  
  const asterius = await rts.newAsteriusInstance(Object.assign(req, { module: m }));

  const b = fs.readFileSync('../../static/math.docx')
  // const b = fs.readFileSync('../../README.md')
  const r = await asterius.exports.convert('docx', 'html', b)
  console.log('res: ', r);

}

module.then(handleModule);
