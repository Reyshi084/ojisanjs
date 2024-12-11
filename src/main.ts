import { parse } from "./parser";
import { generate } from "escodegen";
import * as fs from "fs";

const fileName = "./samples/calc.ojjs";

const ojjs = String(fs.readFileSync(fileName));
const result = parse(ojjs, {});
fs.writeFileSync("./ast.json", JSON.stringify(result));
const resultJS = generate(result);
fs.writeFileSync("./output.js", resultJS);
