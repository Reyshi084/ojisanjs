import {
  Directive,
  FunctionBody,
  Identifier,
  Literal,
  Pattern,
  Program,
  Statement,
  BlockStatement,
  EmptyStatement,
  IfStatement,
  Expression,
  ForStatement,
  VariableDeclaration,
  VariableDeclarator,
  UnaryExpression,
  UnaryOperator,
  UpdateExpression,
  UpdateOperator,
  BinaryExpression,
  BinaryOperator,
  AssignmentExpression,
  AssignmentOperator,
  CallExpression,
  ExpressionStatement,
  MemberExpression,
} from "./nodes";

class ESTreeBuilder {
  createIdentifier(name: string): Identifier {
    return {
      type: "Identifier",
      name,
    };
  }

  createLiteral(value: string | boolean | null | number): Literal {
    return {
      type: "Literal",
      value,
    };
  }

  createProgram(body: (Directive | Statement)[]): Program {
    return {
      type: "Program",
      body,
    };
  }

  createExpressionStatement(expression: Expression): ExpressionStatement {
    return {
      type: "ExpressionStatement",
      expression,
    };
  }

  createDirective(expression: Literal, directive: string): Directive {
    return {
      type: "ExpressionStatement",
      expression,
      directive,
    };
  }

  createBlockStatement(body: Statement[]): BlockStatement {
    return {
      type: "BlockStatement",
      body,
    };
  }

  createFunctionBody(body: (Directive | Statement)[]): FunctionBody {
    return {
      type: "BlockStatement",
      body,
    };
  }

  createEmptyStatement(): EmptyStatement {
    return {
      type: "EmptyStatement",
    };
  }

  createIfStatement(
    test: Expression,
    consequent: Statement,
    alternate: Statement | null,
  ): IfStatement {
    return {
      type: "IfStatement",
      test,
      consequent,
      alternate,
    };
  }

  createForStatement(
    init: VariableDeclaration | Expression | null,
    test: Expression | null,
    update: Expression | null,
    body: Statement,
  ): ForStatement {
    return {
      type: "ForStatement",
      init,
      test,
      update,
      body,
    };
  }

  createVariableDeclaration(
    declarations: VariableDeclarator[],
  ): VariableDeclaration {
    return {
      type: "VariableDeclaration",
      declarations,
      kind: "var",
    };
  }

  createVariableDeclarator(
    id: Pattern,
    init: Expression | null,
  ): VariableDeclarator {
    return {
      type: "VariableDeclarator",
      id,
      init,
    };
  }

  createUnaryExpression(
    operator: UnaryOperator,
    prefix: boolean,
    argument: Expression,
  ): UnaryExpression {
    return {
      type: "UnaryExpression",
      operator,
      prefix,
      argument,
    };
  }

  createUpdateExpression(
    operator: UpdateOperator,
    argument: Expression,
    prefix: boolean,
  ): UpdateExpression {
    return {
      type: "UpdateExpression",
      operator,
      argument,
      prefix,
    };
  }

  createBinaryExpression(
    operator: BinaryOperator,
    left: Expression,
    right: Expression,
  ): BinaryExpression {
    return {
      type: "BinaryExpression",
      operator,
      left,
      right,
    };
  }

  createAssignmentExpression(
    operator: AssignmentOperator,
    left: Pattern,
    right: Expression,
  ): AssignmentExpression {
    return {
      type: "AssignmentExpression",
      operator,
      left,
      right,
    };
  }

  createMemberExpression(
    object: Expression,
    property: Expression,
    computed: boolean,
  ): MemberExpression {
    return {
      type: "MemberExpression",
      object,
      property,
      computed,
    };
  }

  createCallExpression(callee: Expression, args: Expression[]): CallExpression {
    return {
      type: "CallExpression",
      callee,
      arguments: args,
    };
  }
}

module.exports = new ESTreeBuilder();
