import 'package:over_react/over_react.dart';

// ignore_for_file: uri_has_not_been_generated
import 'basic.over_react.g.dart' as $;
export 'basic.over_react.g.dart';

UiFactory<BasicProps> Basic = $.Basic;

class BasicProps = UiProps with BasicPropsMixin;

mixin BasicPropsMixin on UiProps {
  @deprecated
  @requiredProp
  String basicProp;

  String basic1;
  String basic2;
  String basic3;
  String basic4;
  String basic5;
}

class BasicComponent extends UiComponent2<BasicPropsMixin> {
  @override
  get defaultProps => newProps()..id = 'basic component'
      ..basicProp = 'defaultBasicProps'; // ignore: deprecated_member_use_from_same_package

  @override
  render() {
    return Dom.div()(
        Dom.div()('prop id: ${props.id}'),
        Dom.div()('default prop testing: ${props.basicProp}'), // ignore: deprecated_member_use_from_same_package
        Dom.div()('default prop testing: ${props.basic1}'),
        Dom.div()(null, props.basic4, 'children: ${props.children}' ),
    );
  }
}


