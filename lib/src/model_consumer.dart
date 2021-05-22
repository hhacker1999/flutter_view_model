import 'package:flutter/widgets.dart';
import 'base_model.dart';
import 'model_builder.dart';
import 'types.dart';

class ModelConsumer<S, B extends BaseModel> extends StatefulWidget {
  final ModelBuilderWidget<S> builder;
  final ModelListenerWidget<S> listener;
  final B model;

  const ModelConsumer({
    Key? key,
    required this.builder,
    required this.listener,
    required this.model,
  }) : super(key: key);

  @override
  _ModelConsumerState<S, B> createState() => _ModelConsumerState<S, B>();
}

class _ModelConsumerState<S, B extends BaseModel>
    extends State<ModelConsumer<S, B>> {
  @override
  void initState() {
    widget.model.state.listen((event) {
      widget.listener(context, event);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ModelBuilder<S, B>(
      model: widget.model,
      builder: (context, state) => widget.builder(context, state),
    );
  }
}
