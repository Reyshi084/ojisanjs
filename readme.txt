[使用方法]
1. 必要なモジュールのインポート
$ npm i
2. おじさんJSからJavaScriptへコンパイル（output.jsに書き込まれる）
$ npm run compile xxx.ojjs
3. 生成されたJavaScriptの実行
$ npm run exec

＊ ハローワールドの動作確認
$ npm run compile samples/hello.ojjs
$ npm run exec

＊ fizzbuzzの動作確認
$ npm run compile samples/fizzbuzz.ojjs
$ npm run exec

[サンプルコード一覧]
samples/hello.ojjs : ハローワールド
samples/fizzbuzz.ojjs : fizzbuzz問題
samples/leap_year.ojjs : うるう年判定
samples/calc.ojjs : 算術計算の例