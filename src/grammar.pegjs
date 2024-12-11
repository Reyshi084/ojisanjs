{
    const ESTreeBuilder = require("./estree/estree-builder");
}

start
    = _ program:Program _ { return program; }

Program
    = body:SourceElements? {
        return ESTreeBuilder.createProgram(body);
    }

SourceElements
    = head:SourceElement tail:(_ SourceElement)* {
        return [head].concat(tail.map((v: string) => v[1]));
    }

SourceElement
    = source:(Directive / Statement) {
        return source;
    }

Directive
    = "オヂサン厳格モードだゾ" Emoji+ {
        return ESTreeBuilder.createDirective(
            ESTreeBuilder.createLiteral("use strict"),
            "use strict"
        );
    }

Statements
    = stats:(Statement _?)+ {
        return ESTreeBuilder.createBlockStatement(stats.map((v: any) => v[0]));
    }

Statement
    = ForStatement
    / IfStatement
    / Declaration
    / ConsoleLogStatement
    / AssignmentStatement

ForStatement
    = ForStartToken init:Expression ForInitToken test:Expression ForTestToken updateExpression:Expression ForUpdateToken Emoji+ _ body:Statements _ EndToken Emoji+ {
        return ESTreeBuilder.createForStatement(init, test, updateExpression, body);
    }

IfStatement
    = IfStartToken test:Expression IfTestToken Emoji+ _ consequent:Statements alternate:(ElseIfStatement / ElseStatement / EndToken Emoji+) {
        return ESTreeBuilder.createIfStatement(test, consequent, alternate ?? null);
    }

ElseIfStatement
    = ElseIfStartToken test:Expression IfTestToken Emoji+ _ consequent:Statements alternate:(ElseIfStatement / ElseStatement / EndToken Emoji+) {
        return ESTreeBuilder.createIfStatement(test, consequent, alternate ?? null);
    }

ElseStatement
    = ElseStartToken Emoji+ _ consequent:Statements EndToken Emoji+ {
        return consequent;
    }

Declaration
    = VariableDeclaration

VariableDeclaration
    = VarToken name:Identifier "は" init:Expression "だヨ" Emoji+ {
        return ESTreeBuilder.createVariableDeclaration(
            [ESTreeBuilder.createVariableDeclarator(name, init)]
        )
    }
    / VarToken name:Identifier Emoji+ {
        return ESTreeBuilder.createVariableDeclaration(
            [ESTreeBuilder.createVariableDeclarator(name, null)]
        )
    }

Identifier
    = !Keyword chars:(Hiragana)+ "チャン" {
        return ESTreeBuilder.createIdentifier(chars.join(""));
    }

ConsoleLogStatement
    = expr:Expression "を見せちゃおうかナ" Emoji+  {
        return ESTreeBuilder.createExpressionStatement(
            ESTreeBuilder.createCallExpression(
                ESTreeBuilder.createMemberExpression(
                    ESTreeBuilder.createIdentifier("console"),
                    ESTreeBuilder.createIdentifier("log"),
                    false
                ),
                [expr]
            )
        );
    }

AssignmentStatement
    = assignment:AssignmentExpression "だヨ" Emoji+ {
        return ESTreeBuilder.createExpressionStatement(assignment);
    }

Expression
    = AssignmentExpression
    / UpdateExpression
    / ComparisonExpression
    / ArithmeticExpression
    / Identifier
    / Literal

Literal
    = str:StringLiteral {
        return ESTreeBuilder.createLiteral(str);
    }
    / num:NumberLiteral {
        return ESTreeBuilder.createLiteral(num);
    }

StringLiteral
    = "「" chars:(!"」" .)* "」" {
        return chars.map((v: string) => v[1]).join("");
    }

NumberLiteral
    = digits:Number+ {
        return parseInt(digits.join(""));
    }

AssignmentExpression
    = name:Identifier op:AssignmentOperator expr:Expression {
        return ESTreeBuilder.createAssignmentExpression(op, name, expr);
    }

AssignmentOperator
    = "は" { return "=" }

UpdateExpression
    = name:Identifier op:UpdateOperator {
        return ESTreeBuilder.createUpdateExpression(op, name, false);
    }

ComparisonExpression
    = left:Value "が" right:Value op:ComparisonOperator {
        return ESTreeBuilder.createBinaryExpression(op, left, right);
    }

ComparisonOperator
    = "と同じ" {return "==="}
    / "以下" {return "<="}
    / "以上" {return ">="}

Value
    = ArithmeticExpression
    / Identifier
    / Literal

ArithmeticExpression
    = Add
    / Sub
    / Mul
    / Div
    / Mod

Add
    = left:(Identifier / Literal) "に" right:Value "を足した値" {
        return ESTreeBuilder.createBinaryExpression("+", left, right);
    }

Sub
    = left:(Identifier / Literal) "から" right:Value "を引いた値" {
        return ESTreeBuilder.createBinaryExpression("-", left, right);
    }

Mul
    = left:(Identifier / Literal) "に" right:Value "を掛けた値" {
        return ESTreeBuilder.createBinaryExpression("*", left, right);
    }

Div
    = left:(Identifier / Literal) "を" right:Value "で割った値" {
        return ESTreeBuilder.createBinaryExpression("/", left, right);
    }

Mod
    = left:(Identifier / Literal) "を" right:Value "で割ったあまり" {
        return ESTreeBuilder.createBinaryExpression("%", left, right);
    }

UpdateOperator
    = "増加" { return "++" }
    / "減少" { return "--" }

Comment
    = "コメントだヨ" Emoji+ (!"コメント終わりだヨ" .)* "コメント終わりだヨ" Emoji+

/* Keyword */

Keyword
    = ForStartToken
    / ForInitToken
    / ForTestToken
    / ForUpdateToken
    / EndToken
    / IfStartToken
    / IfTestToken
    / ElseIfStartToken
    / ElseStartToken
    / VarToken

ForStartToken
    = "ここからは、"

ForInitToken
    = "から始まって、"

ForTestToken
    = "まで、"

ForUpdateToken
    = "をずっと続けるヨ"

EndToken
    = "ここまでだヨ" {
        return null;
    }

IfStartToken
    = "もしも、"

IfTestToken
    = "だったらネ"

ElseIfStartToken
    = "じゃなくてもしも、"

ElseStartToken
    = "じゃなかったらネ"


VarToken
    = "はじめまして、"

Emoji
    = "😀" / "😃" / "😄" / "😁" / "😆" / "🥹" / "😅" / "😂"
    / "🤣" / "🥲" / "☺️" / "😊" / "😇" / "🙂" / "🙃" / "😉"
    / "😌" / "😍" / "🥰" / "😘" / "😗" / "😙" / "😚" / "😋"
    / "😛" / "😝" / "😜" / "🤪" / "🤨" / "🧐" / "🤓" / "😎"
    / "🥸" / "🤩" / "🥳" / "🙂‍↕️" / "😏" / "😒" / "🙂‍↔️" / "😞"
    / "😔" / "😟" / "😕" / "🙁" / "☹️" / "😣" / "😖" / "😫"
    / "😩" / "🥺" / "😢" / "😭" / "😤" / "😠" / "😡" / "🤬"
    / "🤯" / "😳" / "🥵" / "🥶" / "😶‍🌫️" / "😱" / "😨" / "😰"
    / "😥" / "😓" / "🤗" / "🤔" / "🫣" / "🤭" / "🫢" / "🫡"
    / "🤫" / "🫠" / "🤥" / "😶" / "🫥" / "😐" / "🫤" / "😑"
    / "🫨" / "😬" / "🙄" / "😯" / "😦" / "😧" / "😮" / "😲"
    / "🥱" / "😴" / "🤤" / "😪" / "😮‍💨" / "😵" / "😵‍💫" / "🤐"
    / "🥴" / "🤢" / "🤮" / "🤧" / "😷" / "🤒" / "🤕" / "🤑"

Hiragana
    = ("え〜" / "えい") {return "a"}
    / ("び〜" / "びい") {return "b"}
    / ("し〜" / "しい") {return "c"}
    / ("えふ") {return "f"}
    / "あい" {return "i"}
    / ("じぇ〜" / "じぇい") {return "j"}
    / ("け〜" / "けい") {return "k"}
    / ("ぴ〜" / "ぴい") {return "p"}
    / "えす" {return "s"}
    / "てぃ〜" {return "t"}
    / "えっくす" {return "x"}
    / "わい" {return "y"}
    / "ぜっと" {return "z"}
    / "あ" {return "a"}
    / "い" {return "i"}
    / "う" {return "u"}
    / "え" {return "e"}
    / "お" {return "o"}
    / "か" {return "ka"}
    / "き" {return "ki"}
    / "く" {return "ku"}
    / "け" {return "ke"}
    / "こ" {return "ko"}
    / "さ" {return "sa"}
    / "し" {return "si"}
    / "す" {return "su"}
    / "せ" {return "se"}
    / "そ" {return "so"}
    / "た" {return "ta"}
    / "ち" {return "ti"}
    / "つ" {return "tu"}
    / "て" {return "te"}
    / "と" {return "to"}
    / "な" {return "na"}
    / "に" {return "ni"}
    / "ぬ" {return "nu"}
    / "ね" {return "ne"}
    / "の" {return "no"}
    / "は" {return "ha"}
    / "ひ" {return "hi"}
    / "ふ" {return "hu"}
    / "へ" {return "he"}
    / "ほ" {return "ho"}
    / "ま" {return "ma"}
    / "み" {return "mi"}
    / "む" {return "mu"}
    / "め" {return "me"}
    / "も" {return "mo"}
    / "や" {return "ya"}
    / "ゐ" {return "yi"}
    / "ゆ" {return "yu"}
    / "ゑ" {return "ye"}
    / "よ" {return "yo"}
    / "ら" {return "ra"}
    / "り" {return "ri"}
    / "る" {return "ru"}
    / "れ" {return "re"}
    / "ろ" {return "ro"}
    / "わ" {return "wa"}
    / "を" {return "wo"}
    / "ん" {return "nn"}
    / "が" {return "ga"}
    / "ぎ" {return "gi"}
    / "ぐ" {return "gu"}
    / "げ" {return "ge"}
    / "ご" {return "go"}
    / "ざ" {return "za"}
    / "じ" {return "zi"}
    / "ず" {return "zu"}
    / "ぜ" {return "ze"}
    / "ぞ" {return "zo"}
    / "だ" {return "da"}
    / "ぢ" {return "di"}
    / "づ" {return "du"}
    / "で" {return "de"}
    / "ど" {return "do"}
    / "ば" {return "ba"}
    / "び" {return "bi"}
    / "ぶ" {return "bu"}
    / "べ" {return "be"}
    / "ぼ" {return "bo"}
    / "ぱ" {return "pa"}
    / "ぴ" {return "pi"}
    / "ぷ" {return "pu"}
    / "ぺ" {return "pe"}
    / "ぽ" {return "po"}
    / "〜" {return "_"}
    / "ゃ" {return "lya"}
    / "ゅ" {return "lyu"}
    / "ょ" {return "lyo"}
    / "っ" {return "ltu"}
    / "ぁ" {return "la"}
    / "ぃ" {return "li"}
    / "ぅ" {return "lu"}
    / "ぇ" {return "le"}
    / "ぉ" {return "lo"}

Number
    = "０" {return "0"}
    / "１" {return "1"}
    / "２" {return "2"}
    / "３" {return "3"}
    / "４" {return "4"}
    / "５" {return "5"}
    / "６" {return "6"}
    / "７" {return "7"}
    / "８" {return "8"}
    / "９" {return "9"}

/** SKIP **/

_ "skip"
    = (Whitespace / LineTerminatorSequence / Comment)*;

Whitespace "whitespace"
    = "　"

LineTerminatorSequence "end of line"
  = "\n"