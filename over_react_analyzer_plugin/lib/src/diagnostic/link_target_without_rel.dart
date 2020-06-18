import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:analyzer_plugin/utilities/pair.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/fluent_interface_util.dart';

/// A warning that appears when the `target` prop is set, but `rel = 'noreferrer noopener'` is not.
///
/// > See: ["The most underestimated vulnerability ever"](https://www.jitbit.com/alexblog/256-targetblank---the-most-underestimated-vulnerability-ever/)
///
/// {@category Diagnostics}
/// {@subCategory Warnings}
class LinkTargetUsageWithoutRelDiagnostic extends ComponentUsageDiagnosticContributor {
  static final code = DiagnosticCode(
    'over_react_avoid_link_target_vulnerability',
    "A target is set for links opening '{0}', which is a security vulnerability.",
    AnalysisErrorSeverity.WARNING,
    AnalysisErrorType.STATIC_WARNING,
    correction: 'Always add rel="noopener noreferrer" when using a target for a link.',
    url: 'https://www.jitbit.com/alexblog/256-targetblank---the-most-underestimated-vulnerability-ever/',
  );

  static final fixKind = FixKind(code.name, 200, 'Add rel="noopener noreferrer"');

  @override
  computeErrorsForUsage(result, collector, usage) async {
    String hrefValue;
    Pair<PropertyAccess, Expression> targetPropSection;
    Pair<PropertyAccess, Expression> relPropSection;
    forEachCascadedProp(usage, (lhs, rhs) {
      final propName = lhs.propertyName.name;
      if (propName == 'href') {
        hrefValue = rhs.staticType.isDartCoreNull
            ? null
            : rhs.toString(); //rhs.staticType is StringLiteral ? (rhs.staticType as StringLiteral).stringValue;
      } else if (propName == 'target') {
        targetPropSection = Pair(lhs, rhs);
      } else if (propName == 'rel') {
        relPropSection = Pair(lhs, rhs);
      }
    });

    if (hrefValue == null || targetPropSection == null || targetPropSection.last.staticType.isDartCoreNull) return;

    const requiredRelValues = [
      'noopener',
      'noreferrer',
    ];
    var actualRelValues = <String>[];
    var missingRequiredRelValues = List.of(requiredRelValues);
    if (relPropSection != null && relPropSection.last.staticType.isDartCoreString) {
      actualRelValues = (relPropSection.last as StringLiteral).stringValue.split(' ');
    }
    for (final value in actualRelValues) {
      if (requiredRelValues.contains(value)) {
        missingRequiredRelValues.remove(value);
      }
    }

    if (missingRequiredRelValues.isNotEmpty) {
      await collector.addErrorWithFix(
        code,
        result.location(offset: targetPropSection.first.offset, end: targetPropSection.last.end),
        errorMessageArgs: [hrefValue],
        fixKind: fixKind,
        computeFix: () => buildFileEdit(result, (builder) {
          if (relPropSection == null) {
            addProp(usage, builder, result.content, result.lineInfo,
                name: 'rel', value: "'${requiredRelValues.join(' ')}'");
          } else {
            builder.addSimpleReplacement(
              SourceRange(relPropSection.last.offset, relPropSection.last.length),
              "'${[...actualRelValues, ...missingRequiredRelValues].join(' ')}'",
            );
          }
        }),
      );
    }
  }
}
