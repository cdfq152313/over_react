import 'package:redux/redux.dart';

/////////////////////////////// SHARED ///////////////////////////////

/// An action class can be created to add typing to the actions passed into dispatch.
///
/// While it can make life easier, this practice is optional as all as the
/// reducer receives a valid type and value parameter.
class Action {
  Action({this.type, this.value});

  final String type;
  final dynamic value;

  /// Used to encode the data structure for the Redux DevTools.
  ///
  /// The DevTools expect plain JavaScript objects with the `type` property. To
  /// facilitate that, a method such as [toJson] is necessary.
  /// > See: <https://github.com/MichaelMarner/dart-redux-remote-devtools#encoding-actions-and-state>
  toJson() {
    return {'type': this.type, 'value': this.value};
  }
}

/// Actions to be passed into `dispatch`.
///
/// Note that the value can be hardcoded or passed into the constructor.
class SmallIncrementAction extends Action {
  SmallIncrementAction():super(type: 'SMALL_INCREMENT_ACTION', value: 1);
}

class SmallDecrementAction extends Action {
  SmallDecrementAction():super(type: 'SMALL_DECREMENT_ACTION', value: 1);
}

class BigIncrementAction extends Action {
  BigIncrementAction():super(type: 'BIG_INCREMENT_ACTION', value: 100);
}

class BigDecrementAction extends Action {
  BigDecrementAction():super(type: 'BIG_DECREMENT_ACTION', value: 100);
}

/////////////////////////////// STORE 1 "Counter" ///////////////////////////////

/// The application store.
///
/// It takes in a reducer and the initial state. This store is also connected
/// to the Redux DevTools, but could also be implemented without them:
Store store = Store<CounterState>(smallCountReducer, initialState: CounterState.defaultState());

/// The store state class with the properties that make up the entire store.
class CounterState {
  final int smallCount;
  final int bigCount;
  final String name;

  CounterState({
    this.smallCount,
    this.bigCount,
    this.name,
  });

  /// A default state constructor.
  ///
  /// This is optional and is just useful for creating the initial state or
  /// resetting the state to default (if you ever need to).
  CounterState.defaultState({this.smallCount = 1, this.bigCount = 100, this.name = "Counter"});

  /// Used for syntactically simple updates within the reducer.
  ///
  /// Because Redux is pure and does not allow direct state mutations, a constructor
  /// that defaults to setting properties to the old state allows for DRYer code
  /// in the reducers.
  CounterState.updateState(CounterState oldState, {int smallCount, int bigCount, String name})
      : this.smallCount = smallCount ?? oldState.smallCount,
        this.bigCount = bigCount ?? oldState.bigCount,
        this.name = name ?? oldState.name;

  toJson() {
    return {
      'smallCount': this.smallCount,
      'bigCount': this.bigCount,
      'name': this.name
    };
  }
}

/// The reducer used to update the store.
///
/// This can be a switch, if, or use [combineReducers] as seen below.
CounterState smallCountReducer(CounterState oldState, dynamic action) {
  if (action is SmallDecrementAction) {
    return CounterState.updateState(oldState, smallCount: oldState.smallCount - action.value);
  } else if (action is SmallIncrementAction) {
    return CounterState.updateState(oldState, smallCount: oldState.smallCount + action.value);
  } else if (action is BigDecrementAction) {
    return CounterState.updateState(oldState, bigCount: oldState.bigCount - action.value);
  } else if (action is BigIncrementAction) {
    return CounterState.updateState(oldState, bigCount: oldState.bigCount + action.value);
  } else {
    return oldState;
  }
}