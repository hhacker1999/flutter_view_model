import 'package:flutter/widgets.dart';

typedef ModelBuilderWidget<S> = Widget Function(BuildContext context, S state);

typedef ModelListenerWidget<S> = void Function(BuildContext context, S state);