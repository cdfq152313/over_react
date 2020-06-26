import 'package:analyzer/dart/ast/ast.dart';
import 'package:over_react_analyzer_plugin/src/component_usage.dart';
import 'package:over_react_analyzer_plugin/src/util/util.dart';
import 'package:test/test.dart';

import '../../../test_util.dart';
import 'test_data.dart';

void main() {
  group('component_usage', () {
    group('getComponentUsage', () {
      group('accurately detects and collects information on usages of OverReact components:', () {
        group('components with no cascades:', () {
          buildersToTest.forEach((name, builderSource) {
            test('$name', () async {
              final source = '${builderSource.source}()';

              final expressionNode = await parseExpressionResolved(source, imports: builderSource.imports);
              final componentUsage = getComponentUsage(expressionNode);

              checkComponentUsage(componentUsage, builderSource, source);
            });
          });
        });

        group('components with cascades:', () {
          buildersToTest.forEach((name, builderSource) {
            test('$name', () async {
              var cascadeSource = '${builderSource.source}..id = \'123\'';
              var source = '($cascadeSource)()';

              var expressionNode = await parseExpressionResolved(source, imports: builderSource.imports);
              var componentUsage = getComponentUsage(expressionNode);

              checkComponentUsage(componentUsage, builderSource, source, cascadeSource);
            });
          });
        });

        group('components with no cascade but extra parens:', () {
          buildersToTest.forEach((name, builderSource) {
            test('$name', () async {
              var source = '(${builderSource.source})()';

              var expressionNode = await parseExpressionResolved(source, imports: builderSource.imports);
              var componentUsage = getComponentUsage(expressionNode);

              checkComponentUsage(componentUsage, builderSource, source);
            });
          });
        });

        group('components with no children:', () {
          buildersToTest.forEach((name, builderSource) {
            test('$name', () async {
              var source = '${builderSource.source}()';

              var expressionNode = await parseExpressionResolved(source, imports: builderSource.imports);
              var componentUsage = getComponentUsage(expressionNode);

              checkComponentUsage(componentUsage, builderSource, source);

              expect(componentUsage.childArgumentCount, 0);
              expect(componentUsage.hasVariadicChildren, false);
            });
          });
        });

        group('components with a single child:', () {
          buildersToTest.forEach((name, builderSource) {
            test('$name', () async {
              var source = '${builderSource.source}("foo")';

              var expressionNode = await parseExpressionResolved(source, imports: builderSource.imports);
              var componentUsage = getComponentUsage(expressionNode);

              checkComponentUsage(componentUsage, builderSource, source);

              expect(componentUsage.childArgumentCount, 1);
              expect(componentUsage.hasVariadicChildren, true);
            });
          });
        });

        group('components with more than one child:', () {
          buildersToTest.forEach((name, builderSource) {
            test('$name', () async {
              var source = '${builderSource.source}("foo", "bar")';

              var expressionNode = await parseExpressionResolved(source, imports: builderSource.imports);
              var componentUsage = getComponentUsage(expressionNode);

              checkComponentUsage(componentUsage, builderSource, source);

              expect(componentUsage.childArgumentCount, 2);
              expect(componentUsage.hasVariadicChildren, true);
            });
          });
        });

        group('components with list literal children:', () {
          buildersToTest.forEach((name, builderSource) {
            test('$name', () async {
              var source = '${builderSource.source}(["foo", "bar"])';

              var expressionNode = await parseExpressionResolved(source, imports: builderSource.imports);
              var componentUsage = getComponentUsage(expressionNode);

              checkComponentUsage(componentUsage, builderSource, source);

              expect(componentUsage.childArgumentCount, 1);
              expect(componentUsage.hasVariadicChildren, false);
            });
          });
        });
      });

      test('returns null for invocations that aren\'t fluent interface usages', () {
        Future<void> verifyUsage(String source, String reason) async {
          final expressionNode = await parseExpressionResolved(source);
          var componentUsage = getComponentUsage(expressionNode);
          expect(componentUsage, isNull, reason: '$source is $reason');
        }

        const {
          'Dom.h1()': 'not full invocation',
          'Foo()': 'not full invocation',
          'fooFactory()': 'not full invocation',
          'foo()': 'not a valid builder',
          'foo.bar()': 'not a valid builder',
          'foo()()': 'not a valid builder',
          '_foo()()': 'not a valid builder',
        }.forEach(verifyUsage);
      });
    });

    group('hasChildComponent', () {
      group('detects components within an argument list', () {
        group('when there is a single child that is a component', () {
          buildersToTest.forEach((name, builderSource) {
            test('and the child component uses a $name', () {
              var childSource = '${builderSource.source}()';
              var source = 'SomeOtherComponent()($childSource)';

              final expressionNode = parseExpression(source);

              expect(hasChildComponent(expressionNode.argumentList), isTrue);
            });
          });
        });

        group('when there are multiple children, and only one is a component', () {
          buildersToTest.forEach((name, builderSource) {
            test('and the child component uses a $name', () {
              var childSource = '${builderSource.source}()';
              var source = 'SomeOtherComponent()("other child 1", $childSource, "other child 2")';

              final expressionNode = parseExpression(source);

              expect(hasChildComponent(expressionNode.argumentList), isTrue);
            });
          });
        });
      });

      group('even when the components have any number of extra wrapping parens', () {
        buildersToTest.forEach((name, builderSource) {
          test('and the child component uses a $name', () {
            var childSource = '${builderSource.source}()';
            var childSourceWithExtraParens = '((($childSource)))';
            var source = 'SomeOtherComponent()($childSourceWithExtraParens)';

            final expressionNode = parseExpression(source);

            expect(hasChildComponent(expressionNode.argumentList), isTrue);
          });
        });
      });

      test('returns false when there are only non-component arguments', () {
        var source = 'SomeOtherComponent()(1, "non-component child", {})';
        final expressionNode = parseExpression(source);

        expect(hasChildComponent(expressionNode.argumentList), isFalse);
      });

      test('returns false when there are nested components, but no top-level ones', () {
        var source = 'SomeOtherComponent()([Foo()()])';
        final expressionNode = parseExpression(source);

        expect(hasChildComponent(expressionNode.argumentList), isFalse);
      });
    });

    group('identifyUsage', () {
      group('returns correct FluentComponentUsage usage when', () {
        buildersToTest.forEach((name, builderSource) {
          group('node inside $name', () {
            final cascadeSource = '${builderSource.source}..id = \'123\'';
            final source = '($cascadeSource)(\'stringChild\')';
            InvocationExpression expressionNode;

            setUpAll(() async {
              expressionNode = await parseExpressionResolved(source, imports: builderSource.imports);
            });

            test('is already a component usage', () {
              final componentUsage = identifyUsage(expressionNode);
              checkComponentUsage(componentUsage, builderSource, source, cascadeSource);
            });

            test('is props cascade expression', () {
              final cascadeExpression = getComponentUsage(expressionNode).cascadeExpression.cascadeSections.firstOrNull;
              expect(cascadeExpression.toSource(), '..id = \'123\'');
              final componentUsage = identifyUsage(cascadeExpression);
              checkComponentUsage(componentUsage, builderSource, source, cascadeSource);
            });

            test('is a child', () {
              final child = expressionNode.argumentList.arguments.firstOrNull;
              expect(child.toSource(), '\'stringChild\'');
              final componentUsage = identifyUsage(child);
              checkComponentUsage(componentUsage, builderSource, source, cascadeSource);
            });
          });
        });
      });

      group('returns null node has no parent component usage', () {
        final unit = parseAndGetUnit(/*language=dart*/ r'''
          class Foo {
            void foo() {
              var a = 'abc';
            }
          }
        ''');
        FluentComponentUsage componentUsage;
        ClassDeclaration classDecl;
        MethodDeclaration methodDecl;
        InvocationExpression expressionNode;

        test('and node is a class declaration', () {
          expect(unit.declarations.length, 1);
          expect(unit.declarations.firstOrNull, isA<ClassDeclaration>());
          classDecl = unit.declarations.firstOrNull as ClassDeclaration;

          componentUsage = identifyUsage(classDecl);
          expect(componentUsage, isNull);
        });

        test('and node is a method declaration', () {
          final classMembers = classDecl.members;
          expect(classMembers.length, 1);
          expect(classMembers.firstOrNull, isA<MethodDeclaration>());
          methodDecl = classMembers.firstOrNull as MethodDeclaration;

          componentUsage = identifyUsage(methodDecl);
          expect(componentUsage, isNull);
        });

        test('and node is a variable declaration', () {
          final methodStatements = (methodDecl.body as BlockFunctionBody).block.statements;
          expect(methodStatements.length, 1);
          final variableDeclaration = methodStatements.firstOrNull;
          expect(variableDeclaration, isA<VariableDeclarationStatement>());

          componentUsage = identifyUsage(variableDeclaration);
          expect(componentUsage, isNull);
        });

        test('and node is an invocation expression', () async {
          expressionNode = await parseExpressionResolved('Foo.foo(() => \'abc\')');

          componentUsage = identifyUsage(expressionNode);
          expect(componentUsage, isNull);
        });

        test('and node is an argument of an invocation expression', () {
          final arg = expressionNode.argumentList.arguments.firstOrNull;
          expect(arg, isNotNull);

          componentUsage = identifyUsage(arg);
          expect(componentUsage, isNull);
        });
      });
    });
  });
}

void checkComponentUsage(FluentComponentUsage componentUsage, BuilderTestCase builderSource, String source, [String cascadeSource]) {
  expect(componentUsage, isNotNull);
  expect(componentUsage.builder.toSource(), builderSource.source);
  expect(componentUsage.node.toSource(), source);
  expect(componentUsage.componentName, builderSource.componentName);
  expect(componentUsage.isDom, builderSource.isDom);
  expect(componentUsage.isSvg, builderSource.isSvg);
  expect(componentUsage.cascadeExpression?.toSource(), cascadeSource ?? isNull);
}
