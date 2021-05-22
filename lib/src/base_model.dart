import 'dart:developer';
import 'package:rxdart/rxdart.dart';

abstract class BaseModel<E, S> {
  late S _initialState;
  final BehaviorSubject<E> _eventSubject = BehaviorSubject<E>();
  final BehaviorSubject<S> _stateSubject = BehaviorSubject<S>();
  Future<void> _mapper() async {
    _event.listen((event) {
      mapEventToState(event);
    });
  }

  Future<void> mapEventToState(E event);
  S get initialState => _initialState;
  ValueStream<S> get state => _stateSubject.stream;
  ValueStream<E> get _event => _eventSubject.stream;
  Function(E) get add => _eventSubject.add;
  Function(S) get addState => _stateSubject.add;

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
