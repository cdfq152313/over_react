import 'package:analyzer/dart/ast/ast.dart';
import 'package:transformer_utils/transformer_utils.dart';

import '../parsing.dart';
import '../util.dart';
import 'accessors_generator.dart';
import 'names.dart';
import 'util.dart';

class FlutterStyleExtension extends BoilerplateDeclarationGenerator {
  FlutterStyleExtension(FlutterStyleExtensionDeclaration decl)
      : member = decl.mixin,
        names = TypedMapNames(decl.mixin.name.name),
        version = decl.version,
        type = TypedMapType.propsMixin;

  final functionRegExp = RegExp(r'Function\((.+)\)');

  final TypedMapType type;

  final BoilerplateTypedMapMember member;

  final TypedMapNames names;

  ClassOrMixinDeclaration get node => member.node as ClassOrMixinDeclaration;

  TypeParameterList get typeParameters => member.nodeHelper.typeParameters;

  @override
  final Version version;

  @override
  void generate() {
    if (version.isLegacy) {
      return;
    }
    outputContentsBuffer.writeln('');
    final typeParamsOnClass = typeParameters?.toSource() ?? '';
    outputContentsBuffer.write('extension ${names.flutterStyleExtensionName} on UiFactory<${names.publicName}>{');
    final arguments = _getArguments();
    outputContentsBuffer.write(_generateG(arguments, typeParamsOnClass));
    outputContentsBuffer.write(_generateProps(arguments, typeParamsOnClass));
    outputContentsBuffer.write('}');
    outputContentsBuffer.writeln('');
  }

  String _generateG(List<ArgumentPair> arguments, String typeParamsOnClass) {
    final buffer = StringBuffer();
    buffer.write('ReactElement g$typeParamsOnClass({key, children,');
    _writeGeneral(buffer, arguments, typeParamsOnClass);
    buffer.write('return children == null ? __builder() : __builder(autoKey(children));');
    buffer.write('}');
    return buffer.toString();
  }

  String _generateProps(List<ArgumentPair> arguments, String typeParamsOnClass) {
    final buffer = StringBuffer();
    buffer.write('${names.publicName} props$typeParamsOnClass({key,');
    _writeGeneral(buffer, arguments, typeParamsOnClass);
    buffer.write('return __builder;');
    buffer.write('}');
    return buffer.toString();
  }

  void _writeGeneral(StringBuffer buffer, List<ArgumentPair> arguments, String typeParamsOnClass) {
    for (final argument in arguments) {
      buffer.write('${argument.type} ${argument.name},');
    }
    buffer.write('}){');
    buffer.write('final __builder = this();');

    for (final argument in arguments) {
      if (typeParamsOnClass != '' && argument.type.contains('Function') && argument.type.contains('(')) {
        final params = functionRegExp.firstMatch(argument.type)?.group(1)?.split(',');
        if (params != null) {
          final paramStr = [for (int i = 0; i < params.length; ++i) 'a$i'].join(',');
          buffer.write('if (${argument.name} != null) __builder.${argument.name} = ($paramStr) => ${argument.name}($paramStr);');
        } else {
          buffer.write('if (${argument.name} != null) __builder.${argument.name} = ${argument.name};');
        }
      } else {
        buffer.write('if (${argument.name} != null) __builder.${argument.name} = ${argument.name};');
      }
    }
    buffer.write('if(key != null) __builder.key = key;');
  }

  List<ArgumentPair> _getArguments() {
    List<ArgumentPair> arguments = [];
    node.members.whereType<FieldDeclaration>().where((field) => !field.isStatic).forEach((field) {
      field.fields.variables.forEach((variable) {
        if (variable.initializer != null) {
          logger.severe(messageWithSpan(
              'Fields are stubs for generated setters/getters and should not have initializers.\n'
              'Instead, initialize ${type.isProps ? 'prop values within defaultProps' : 'state values within initialState'}.',
              span: getSpan(sourceFile, variable)));
        }

        String accessorName = variable.name.name;
        final typeSource = field.fields.type?.toSource();
        final typeString = typeSource == null ? '' : '$typeSource ';
        arguments.add(ArgumentPair(typeString, accessorName));
      });
    });
    return arguments;
  }
}

class ArgumentPair {
  ArgumentPair(this.type, this.name);

  final String type;
  final String name;
}
