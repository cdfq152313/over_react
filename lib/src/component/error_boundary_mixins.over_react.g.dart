// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_boundary_mixins.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

abstract class ErrorBoundaryPropsMixin implements _$ErrorBoundaryPropsMixin {
  @override
  Map get props;

  static const PropsMeta meta = _$metaForErrorBoundaryPropsMixin;

  /// An optional callback that will be called with an [Error] _(or [Exception])_
  /// and `errorInfo` containing information about which component in the tree
  /// threw when the `componentDidCatch` lifecycle method is called.
  ///
  /// This callback can be used to log component errors like so:
  ///
  ///     (ErrorBoundary()
  ///       ..onComponentDidCatch = (error, errorInfo) {
  ///         // It is up to you to implement the service / thing that calls the service.
  ///         logComponentStackToAService(error, errorInfo);
  ///       }
  ///     )(
  ///       // The rest of your component tree
  ///     )
  ///
  /// > See: <https://reactjs.org/docs/react-component.html#componentdidcatch>
  ///
  /// > Related: [onComponentIsUnrecoverable]
  ///
  /// <!-- Generated from [_$ErrorBoundaryPropsMixin.onComponentDidCatch] -->
  @override
  Function(dynamic error, ReactErrorInfo info) get onComponentDidCatch =>
      props[_$key__onComponentDidCatch___$ErrorBoundaryPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// An optional callback that will be called with an [Error] _(or [Exception])_
  /// and `errorInfo` containing information about which component in the tree
  /// threw when the `componentDidCatch` lifecycle method is called.
  ///
  /// This callback can be used to log component errors like so:
  ///
  ///     (ErrorBoundary()
  ///       ..onComponentDidCatch = (error, errorInfo) {
  ///         // It is up to you to implement the service / thing that calls the service.
  ///         logComponentStackToAService(error, errorInfo);
  ///       }
  ///     )(
  ///       // The rest of your component tree
  ///     )
  ///
  /// > See: <https://reactjs.org/docs/react-component.html#componentdidcatch>
  ///
  /// > Related: [onComponentIsUnrecoverable]
  ///
  /// <!-- Generated from [_$ErrorBoundaryPropsMixin.onComponentDidCatch] -->
  @override
  set onComponentDidCatch(Function(dynamic error, ReactErrorInfo info) value) =>
      props[_$key__onComponentDidCatch___$ErrorBoundaryPropsMixin] = value;

  /// An optional callback that will be called _(when [fallbackUIRenderer] is not set)_
  /// with an [Error] _(or [Exception])_ and `errorInfo` containing information about which component in
  /// the tree threw multiple consecutive errors/exceptions frequently enough that it has the potential
  /// to lock the main thread.
  ///
  /// The locking of the main thread is possible in this scenario because when [fallbackUIRenderer]
  /// is not set, the [ErrorBoundary] simply re-mounts the child when an error occurs to try to "recover" automatically.
  /// However, if multiple identical errors are thrown from the exact same component in the tree - every time
  /// the [ErrorBoundary] re-mounts the tree, a sort of "infinite loop" will occur.
  ///
  /// When this callback is called, the tree wrapped by this [ErrorBoundary] has "crashed" - and is completely
  /// non-functional. Instead of re-mounting the component tree, the [ErrorBoundary] will simply render a
  /// static copy of the render tree's HTML that was captured at the time of the error.
  ///
  /// Once this happens, regaining interactivity within the tree wrapped by this [ErrorBoundary] is possible by:
  ///
  /// 1. Passing in a new child
  ///   _(preferably one that will not repeatedly throw errors when the [ErrorBoundary] mounts it)_.
  /// 2. Calling [ErrorBoundaryComponent.reset].
  ///
  /// > Will never be called when [fallbackUIRenderer] is set.
  ///
  /// > Related: [identicalErrorFrequencyTolerance]
  ///
  /// <!-- Generated from [_$ErrorBoundaryPropsMixin.onComponentIsUnrecoverable] -->
  @override
  Function(dynamic error, ReactErrorInfo info) get onComponentIsUnrecoverable =>
      props[_$key__onComponentIsUnrecoverable___$ErrorBoundaryPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// An optional callback that will be called _(when [fallbackUIRenderer] is not set)_
  /// with an [Error] _(or [Exception])_ and `errorInfo` containing information about which component in
  /// the tree threw multiple consecutive errors/exceptions frequently enough that it has the potential
  /// to lock the main thread.
  ///
  /// The locking of the main thread is possible in this scenario because when [fallbackUIRenderer]
  /// is not set, the [ErrorBoundary] simply re-mounts the child when an error occurs to try to "recover" automatically.
  /// However, if multiple identical errors are thrown from the exact same component in the tree - every time
  /// the [ErrorBoundary] re-mounts the tree, a sort of "infinite loop" will occur.
  ///
  /// When this callback is called, the tree wrapped by this [ErrorBoundary] has "crashed" - and is completely
  /// non-functional. Instead of re-mounting the component tree, the [ErrorBoundary] will simply render a
  /// static copy of the render tree's HTML that was captured at the time of the error.
  ///
  /// Once this happens, regaining interactivity within the tree wrapped by this [ErrorBoundary] is possible by:
  ///
  /// 1. Passing in a new child
  ///   _(preferably one that will not repeatedly throw errors when the [ErrorBoundary] mounts it)_.
  /// 2. Calling [ErrorBoundaryComponent.reset].
  ///
  /// > Will never be called when [fallbackUIRenderer] is set.
  ///
  /// > Related: [identicalErrorFrequencyTolerance]
  ///
  /// <!-- Generated from [_$ErrorBoundaryPropsMixin.onComponentIsUnrecoverable] -->
  @override
  set onComponentIsUnrecoverable(
          Function(dynamic error, ReactErrorInfo info) value) =>
      props[_$key__onComponentIsUnrecoverable___$ErrorBoundaryPropsMixin] =
          value;

  /// A renderer that will be used to render "fallback" UI instead of the child
  /// component tree that crashed.
  ///
  /// > Related: [onComponentIsUnrecoverable], [onComponentDidCatch]
  ///
  /// <!-- Generated from [_$ErrorBoundaryPropsMixin.fallbackUIRenderer] -->
  @override
  ReactElement Function(
      dynamic error,
      ReactErrorInfo
          info) get fallbackUIRenderer =>
      props[_$key__fallbackUIRenderer___$ErrorBoundaryPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// A renderer that will be used to render "fallback" UI instead of the child
  /// component tree that crashed.
  ///
  /// > Related: [onComponentIsUnrecoverable], [onComponentDidCatch]
  ///
  /// <!-- Generated from [_$ErrorBoundaryPropsMixin.fallbackUIRenderer] -->
  @override
  set fallbackUIRenderer(
          ReactElement Function(dynamic error, ReactErrorInfo info) value) =>
      props[_$key__fallbackUIRenderer___$ErrorBoundaryPropsMixin] = value;

  /// The amount of time that is "acceptable" between consecutive identical errors thrown from a component
  /// within the tree wrapped by this [ErrorBoundary].
  ///
  /// If [fallbackUIRenderer] is not set, and more than one identical error is thrown consecutively by
  /// the exact same component anywhere within the tree wrapped by this [ErrorBoundary] -- more often than
  /// the specified duration -- the [ErrorBoundary] will:
  ///
  ///   1. Call [onComponentIsUnrecoverable].
  ///   2. Stop attempting to re-mount the tree (to protect the main thread from being locked up).
  ///   3. Render a static copy of the render tree's HTML that was captured at the time of the error.
  ///
  /// When this happens, recovery can only occur by passing in a new child to
  /// the [ErrorBoundary], or by calling [ErrorBoundaryComponent.reset].
  ///
  /// __DO NOT MODIFY THIS VALUE UNLESS YOU KNOW WHAT YOU ARE DOING.__
  ///
  /// > Default: `const Duration(seconds: 5)`
  ///
  /// <!-- Generated from [_$ErrorBoundaryPropsMixin.identicalErrorFrequencyTolerance] -->
  @override
  Duration get identicalErrorFrequencyTolerance =>
      props[
          _$key__identicalErrorFrequencyTolerance___$ErrorBoundaryPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// The amount of time that is "acceptable" between consecutive identical errors thrown from a component
  /// within the tree wrapped by this [ErrorBoundary].
  ///
  /// If [fallbackUIRenderer] is not set, and more than one identical error is thrown consecutively by
  /// the exact same component anywhere within the tree wrapped by this [ErrorBoundary] -- more often than
  /// the specified duration -- the [ErrorBoundary] will:
  ///
  ///   1. Call [onComponentIsUnrecoverable].
  ///   2. Stop attempting to re-mount the tree (to protect the main thread from being locked up).
  ///   3. Render a static copy of the render tree's HTML that was captured at the time of the error.
  ///
  /// When this happens, recovery can only occur by passing in a new child to
  /// the [ErrorBoundary], or by calling [ErrorBoundaryComponent.reset].
  ///
  /// __DO NOT MODIFY THIS VALUE UNLESS YOU KNOW WHAT YOU ARE DOING.__
  ///
  /// > Default: `const Duration(seconds: 5)`
  ///
  /// <!-- Generated from [_$ErrorBoundaryPropsMixin.identicalErrorFrequencyTolerance] -->
  @override
  set identicalErrorFrequencyTolerance(Duration value) => props[
          _$key__identicalErrorFrequencyTolerance___$ErrorBoundaryPropsMixin] =
      value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor
      _$prop__onComponentDidCatch___$ErrorBoundaryPropsMixin =
      const PropDescriptor(
          _$key__onComponentDidCatch___$ErrorBoundaryPropsMixin);
  static const PropDescriptor
      _$prop__onComponentIsUnrecoverable___$ErrorBoundaryPropsMixin =
      const PropDescriptor(
          _$key__onComponentIsUnrecoverable___$ErrorBoundaryPropsMixin);
  static const PropDescriptor
      _$prop__fallbackUIRenderer___$ErrorBoundaryPropsMixin =
      const PropDescriptor(
          _$key__fallbackUIRenderer___$ErrorBoundaryPropsMixin);
  static const PropDescriptor
      _$prop__identicalErrorFrequencyTolerance___$ErrorBoundaryPropsMixin =
      const PropDescriptor(
          _$key__identicalErrorFrequencyTolerance___$ErrorBoundaryPropsMixin);
  static const String _$key__onComponentDidCatch___$ErrorBoundaryPropsMixin =
      'ErrorBoundaryPropsMixin.onComponentDidCatch';
  static const String
      _$key__onComponentIsUnrecoverable___$ErrorBoundaryPropsMixin =
      'ErrorBoundaryPropsMixin.onComponentIsUnrecoverable';
  static const String _$key__fallbackUIRenderer___$ErrorBoundaryPropsMixin =
      'ErrorBoundaryPropsMixin.fallbackUIRenderer';
  static const String
      _$key__identicalErrorFrequencyTolerance___$ErrorBoundaryPropsMixin =
      'ErrorBoundaryPropsMixin.identicalErrorFrequencyTolerance';

  static const List<PropDescriptor> $props = const [
    _$prop__onComponentDidCatch___$ErrorBoundaryPropsMixin,
    _$prop__onComponentIsUnrecoverable___$ErrorBoundaryPropsMixin,
    _$prop__fallbackUIRenderer___$ErrorBoundaryPropsMixin,
    _$prop__identicalErrorFrequencyTolerance___$ErrorBoundaryPropsMixin
  ];
  static const List<String> $propKeys = const [
    _$key__onComponentDidCatch___$ErrorBoundaryPropsMixin,
    _$key__onComponentIsUnrecoverable___$ErrorBoundaryPropsMixin,
    _$key__fallbackUIRenderer___$ErrorBoundaryPropsMixin,
    _$key__identicalErrorFrequencyTolerance___$ErrorBoundaryPropsMixin
  ];
}

const PropsMeta _$metaForErrorBoundaryPropsMixin = const PropsMeta(
  fields: ErrorBoundaryPropsMixin.$props,
  keys: ErrorBoundaryPropsMixin.$propKeys,
);

abstract class ErrorBoundaryStateMixin implements _$ErrorBoundaryStateMixin {
  @override
  Map get state;

  static const StateMeta meta = _$metaForErrorBoundaryStateMixin;

  /// Whether a component within the tree that the [ErrorBoundary] is wrapping around threw an error.
  ///
  /// * When `true`, and [ErrorBoundaryProps.fallbackUIRenderer] is set, the return value of that callback
  ///   will be rendered instead.
  /// * When `true`, and [ErrorBoundaryProps.fallbackUIRenderer] is not set, the [ErrorBoundary] will re-mount
  ///   the tree to attempt to automatically recover from the error.
  ///
  ///   If an identical error is thrown from an identical component within the tree consecutively
  ///   more frequently than [ErrorBoundaryProps.identicalErrorFrequencyTolerance], a static copy of
  ///   the render tree's HTML that was captured at the time of the error will be rendered.
  ///   See: [ErrorBoundaryProps.onComponentIsUnrecoverable] for more information about this scenario.
  ///
  /// <!-- Generated from [_$ErrorBoundaryStateMixin.hasError] -->
  @override
  bool get hasError =>
      state[_$key__hasError___$ErrorBoundaryStateMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Whether a component within the tree that the [ErrorBoundary] is wrapping around threw an error.
  ///
  /// * When `true`, and [ErrorBoundaryProps.fallbackUIRenderer] is set, the return value of that callback
  ///   will be rendered instead.
  /// * When `true`, and [ErrorBoundaryProps.fallbackUIRenderer] is not set, the [ErrorBoundary] will re-mount
  ///   the tree to attempt to automatically recover from the error.
  ///
  ///   If an identical error is thrown from an identical component within the tree consecutively
  ///   more frequently than [ErrorBoundaryProps.identicalErrorFrequencyTolerance], a static copy of
  ///   the render tree's HTML that was captured at the time of the error will be rendered.
  ///   See: [ErrorBoundaryProps.onComponentIsUnrecoverable] for more information about this scenario.
  ///
  /// <!-- Generated from [_$ErrorBoundaryStateMixin.hasError] -->
  @override
  set hasError(bool value) =>
      state[_$key__hasError___$ErrorBoundaryStateMixin] = value;

  /// Whether to show "fallback" UI when [hasError] is true.
  ///
  /// This value will always be true if [ErrorBoundaryProps.fallbackUIRenderer] is non-null.
  ///
  /// <!-- Generated from [_$ErrorBoundaryStateMixin.showFallbackUIOnError] -->
  @override
  bool get showFallbackUIOnError =>
      state[_$key__showFallbackUIOnError___$ErrorBoundaryStateMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Whether to show "fallback" UI when [hasError] is true.
  ///
  /// This value will always be true if [ErrorBoundaryProps.fallbackUIRenderer] is non-null.
  ///
  /// <!-- Generated from [_$ErrorBoundaryStateMixin.showFallbackUIOnError] -->
  @override
  set showFallbackUIOnError(bool value) =>
      state[_$key__showFallbackUIOnError___$ErrorBoundaryStateMixin] = value;
  /* GENERATED CONSTANTS */
  static const StateDescriptor _$prop__hasError___$ErrorBoundaryStateMixin =
      const StateDescriptor(_$key__hasError___$ErrorBoundaryStateMixin);
  static const StateDescriptor
      _$prop__showFallbackUIOnError___$ErrorBoundaryStateMixin =
      const StateDescriptor(
          _$key__showFallbackUIOnError___$ErrorBoundaryStateMixin);
  static const String _$key__hasError___$ErrorBoundaryStateMixin =
      'ErrorBoundaryStateMixin.hasError';
  static const String _$key__showFallbackUIOnError___$ErrorBoundaryStateMixin =
      'ErrorBoundaryStateMixin.showFallbackUIOnError';

  static const List<StateDescriptor> $state = const [
    _$prop__hasError___$ErrorBoundaryStateMixin,
    _$prop__showFallbackUIOnError___$ErrorBoundaryStateMixin
  ];
  static const List<String> $stateKeys = const [
    _$key__hasError___$ErrorBoundaryStateMixin,
    _$key__showFallbackUIOnError___$ErrorBoundaryStateMixin
  ];
}

const StateMeta _$metaForErrorBoundaryStateMixin = const StateMeta(
  fields: ErrorBoundaryStateMixin.$state,
  keys: ErrorBoundaryStateMixin.$stateKeys,
);
