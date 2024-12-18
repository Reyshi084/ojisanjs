import { parse } from "./parser";
import { generate } from "escodegen";
import * as fs from "fs";

if (process.argv.length !== 3) {
  console.log(`usage: ${process.argv[0]} ${process.argv[1]} src`);
  process.exit(1);
}

const fileName = process.argv[2];

const ojjs = String(fs.readFileSync(fileName));
const result = parse(ojjs, {});
fs.writeFileSync("./ast.json", JSON.stringify(result));
const resultJS = generate(result);
fs.writeFileSync("./output.js", resultJS);
