import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';
import 'base_model.dart';
import 'types.dart';


class ModelBuilder<S, B extends BaseModel> extends StatelessWidget {
  final ModelBuilderWidget<S> builder;
  final B model;

  const ModelBuilder({
    Key? key,
    required this.builder,
    required this.model,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<S>(
      stream: model.state as ValueStream<S>,
      initialData: model.initialState,
      builder: (context, snapshot) {
        return builder(context, snapshot.data as S);
      },
    );
  }
}



