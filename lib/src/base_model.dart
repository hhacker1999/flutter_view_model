import 'dart:async';
import 'dart:developer';
import 'package:rxdart/rxdart.dart';

abstract class BaseModel<E, S> {
  late S _initialState;
  late S _oldState;
  late S _newState;
  late E _evenTCalled;
  late StreamSubscription<E> _eventSubscription;
  late StreamSubscription<S> _stateSubscription;
  final BehaviorSubject<E> _eventSubject = BehaviorSubject<E>();
  final BehaviorSubject<S> _stateSubject = BehaviorSubject<S>();

  Future<void> _mapper() async {
    this._eventSubscription = _event.listen((event) async {
      this._evenTCalled = event;
      log('Event Called ${this._evenTCalled}');
      await mapEventToState(event);
    });
  }

  Future<void> _logger() async {
    this._stateSubscription = state.listen((state) {
      this._oldState = this._newState;
      this._newState = state;
      log('State Changed [${this._oldState} => ${this._newState}]');
    });
  }

  Future<void> mapEventToState(E event);
  S get initialState => _initialState;
  ValueStream<S> get state => _stateSubject.stream;
  ValueStream<E> get _event => _eventSubject.stream;
  void Function(E) get add => _eventSubject.add;
  // ignore: unused_element
  void Function(S) get _updateState => _stateSubject.add;

  BaseModel(S initialState, {E? autoEvent}) {
    this._initialState = initialState;
    _stateSubject.add(initialState);

    if (autoEvent != null) this.add(autoEvent);
    _mapper().then(
      (value) => log('View Model Fired with $E and $S'),
    );
    _logger();
  }

  void dispose() {
    _stateSubject.close();
    _eventSubject.close();
    _eventSubscription.cancel();
    _stateSubscription.cancel();
    log('View Model. $E and $S disposed');
  }
}
