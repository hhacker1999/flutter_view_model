import 'dart:developer';
import 'package:rxdart/rxdart.dart';

abstract class BaseModel<E, S> {
  late S _initialState;
  late S _oldState;
  late S _newState;
  late E _evenTCalled;
  final BehaviorSubject<E> _eventSubject = BehaviorSubject<E>();
  final BehaviorSubject<S> _stateSubject = BehaviorSubject<S>();
  Future<void> _mapper() async {
    _event.listen((event) {
      this._evenTCalled = event;
      this._oldState = state.value;
      mapEventToState(event);
      this._newState = state.value;
      log('Event Called $_evenTCalled => [oldstate $_oldState, newstate $_newState]');
    });
  }

  Future<void> mapEventToState(E event);
  S get initialState => _initialState;
  ValueStream<S> get state => _stateSubject.stream;
  ValueStream<E> get _event => _eventSubject.stream;
  Function(E) get add => _eventSubject.add;
  // ignore: unused_element
  Function(S) get _updateState => _stateSubject.add;

  BaseModel(S initialState, {E? autoEvent}) {
    this._initialState = initialState;
    _stateSubject.add(initialState);

    if (autoEvent != null) this.add(autoEvent);
    _mapper().then(
      (value) => log('View Model Fired with $E and $S'),
    );
  }

  void dispose() {
    _stateSubject.close();
    _eventSubject.close();
    log('View Model. $E and $S disposed');
  }
}
