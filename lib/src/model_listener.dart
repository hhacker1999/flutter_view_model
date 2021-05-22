import 'package:flutter/widgets.dart';
import 'base_model.dart';
import 'types.dart';

class ModelListener<S, B extends BaseModel> extends StatefulWidget {
  final ModelListenerWidget<S> listener;
  final B model;
  const ModelListener({Key? key, required this.listener, required this.model})
      : super(key: key);

  @override
  _ModelListenerState<S, B> createState() => _ModelListenerState<S, B>();
}

class _ModelListenerState<S, B extends BaseModel>
    extends State<ModelListener<S, B>> {
  @override
  void initState() {
    widget.model.state.listen((event) {
      widget.listener(context, event);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}