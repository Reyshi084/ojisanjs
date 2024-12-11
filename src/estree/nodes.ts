interface Node {
  type: string;
}

interface Identifier extends Expression, Pattern {
  type: "Identifier";
  name: string;
}

interface Literal extends Expression {
  type: "Literal";
  value: string | boolean | null | number; // RegExp
}

interface Program extends Node {
  type: "Program";
  body: (Directive | Statement)[];
}

interface Function extends Node {
  id: Identifier | null;
  params: Pattern[];
  body: FunctionBody;
}

interface Statement extends Node {}

interface ExpressionStatement extends Statement {
  type: "ExpressionStatement";
  expression: Expression;
}

interface Directive extends ExpressionStatement {
  expression: Literal;
  directive: string;
}

interface BlockStatement extends Statement {
  type: "BlockStatement";
  body: Statement[];
}

interface FunctionBody extends BlockStatement {
  body: (Directive | Statement)[];
}

interface EmptyStatement extends Statement {
  type: "EmptyStatement";
}

// DebuggerStatement

// WithStatement

interface ReturnStatement extends Statement {
  type: "ReturnStatement";
  argument: Expression | null;
}

interface LabeledStatement extends Statement {
  type: "LabeledStatement";
  label: Identifier;
  body: Statement;
}

interface BreakStatement extends Statement {
  type: "BreakStatement";
  label: Identifier | null;
}

interface ContinueStatement extends Statement {
  type: "ContinueStatement";
  label: Identifier | null;
}

interface IfStatement extends Statement {
  type: "IfStatement";
  test: Expression;
  consequent: Statement;
  alternate: Statement | null;
}

interface SwitchStatement extends Statement {
  type: "SwitchStatement";
  discriminant: Expression;
  cases: SwitchCase[];
}

interface SwitchCase extends Node {
  type: "SwitchCase";
  test: Expression | null;
  consequent: Statement[];
}

// Exceptions

interface WhileStatement extends Statement {
  type: "WhileStatement";
  test: Expression;
  body: Statement;
}

// DoWhileStatement

interface ForStatement extends Statement {
  type: "ForStatement";
  init: VariableDeclaration | Expression | null;
  test: Expression | null;
  update: Expression | null;
  body: Statement;
}

// ForInStatement

interface Declaration extends Statement {}

interface FunctionDeclaration extends Function, Declaration {
  type: "FunctionDeclaration";
  id: Identifier;
}

interface VariableDeclaration extends Declaration {
  type: "VariableDeclaration";
  declarations: VariableDeclarator[];
  kind: "var";
}

interface VariableDeclarator extends Node {
  type: "VariableDeclarator";
  id: Pattern;
  init: Expression | null;
}

interface Expression extends Node {}

// ThisExpression

interface ArrayExpression extends Expression {
  type: "ArrayExpression";
  elements: (Expression | null)[];
}

interface ObjectExpression extends Expression {
  type: "ObjectExpression";
  properties: Property[];
}

interface Property extends Node {
  type: "Property";
  key: Literal | Identifier;
  value: Expression;
  kind: "init" | "get" | "set";
}

interface FunctionExpression extends Function, Expression {
  type: "FunctionExpression";
}

interface UnaryExpression extends Expression {
  type: "UnaryExpression";
  operator: UnaryOperator;
  prefix: boolean;
  argument: Expression;
}

enum UnaryOperator {
  "-",
  "+",
  "!",
  "~",
  "typeof",
  "void",
  "delete",
}

interface UpdateExpression extends Expression {
  type: "UpdateExpression";
  operator: UpdateOperator;
  argument: Expression;
  prefix: boolean;
}

enum UpdateOperator {
  "++",
  "--",
}

interface BinaryExpression extends Expression {
  type: "BinaryExpression";
  operator: BinaryOperator;
  left: Expression;
  right: Expression;
}

enum BinaryOperator {
  "==",
  "!=",
  "===",
  "!==",
  "<",
  "<=",
  ">",
  ">=",
  "<<",
  ">>",
  ">>>",
  "+",
  "-",
  "*",
  "/",
  "%",
  "|",
  "^",
  "&",
  "in",
  "instanceof",
}

interface AssignmentExpression extends Expression {
  type: "AssignmentExpression";
  operator: AssignmentOperator;
  left: Pattern;
  right: Expression;
}

enum AssignmentOperator {
  "=",
  "+=",
  "-=",
  "*=",
  "/=",
  "%=",
  "<<=",
  ">>=",
  ">>>=",
  "|=",
  "^=",
  "&=",
}

interface LogicalExpression extends Expression {
  type: "LogicalExpression";
  operator: LogicalOperator;
  left: Expression;
  right: Expression;
}

enum LogicalOperator {
  "||",
  "&&",
}

interface MemberExpression extends Expression, Pattern {
  type: "MemberExpression";
  object: Expression;
  property: Expression;
  computed: boolean;
}

interface ConditionalExpression extends Expression {
  type: "ConditionalExpression";
  test: Expression;
  alternate: Expression;
  consequent: Expression;
}

interface CallExpression extends Expression {
  type: "CallExpression";
  callee: Expression;
  arguments: Expression[];
}

// NewExpression

// SequenceExpression

interface Pattern extends Node {}

export {
  Node,
  Identifier,
  Literal,
  Program,
  Function,
  Statement,
  ExpressionStatement,
  Directive,
  BlockStatement,
  FunctionBody,
  EmptyStatement,
  ReturnStatement,
  LabeledStatement,
  BreakStatement,
  ContinueStatement,
  IfStatement,
  SwitchStatement,
  SwitchCase,
  WhileStatement,
  ForStatement,
  Declaration,
  FunctionDeclaration,
  VariableDeclaration,
  VariableDeclarator,
  Expression,
  ArrayExpression,
  ObjectExpression,
  Property,
  FunctionExpression,
  UnaryExpression,
  UnaryOperator,
  UpdateExpression,
  UpdateOperator,
  BinaryExpression,
  BinaryOperator,
  AssignmentExpression,
  AssignmentOperator,
  LogicalExpression,
  LogicalOperator,
  MemberExpression,
  ConditionalExpression,
  CallExpression,
  Pattern,
};
