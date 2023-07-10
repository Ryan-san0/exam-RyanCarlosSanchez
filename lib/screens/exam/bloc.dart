export 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:mobile_exam/core/app/bloc.dart' as base;
import 'package:mobile_exam/core/extensions/common.dart';
import 'package:mobile_exam/core/extensions/map.dart';
import 'package:mobile_exam/core/services/server.dart';

import 'views/main.dart' as main_view;
import 'views/loading.dart' as loading_view;
import 'views/error.dart' as error_view;

extension Extension on BuildContext {
  Bloc get bloc => read<Bloc>();
}

class Bloc extends base.Bloc {
  Bloc(BuildContext context)
      : super(loading_view.ViewState(), context: context);

  get msg => null;

  @override
  void init() async {
    final arg = context.arguments;
    final key = await arg?.tryGet("key");
    final service = context.server;
    final msg = await service.data;
    int code = msg["status_code"];

    if (key != await service.accessKey || code != 200) {
      String message = msg["error_message"];
      emit(error_view.ViewState(message));
      return;
    }
    String message = msg["message"];
    String image = msg["image"];
    int count = msg["count"];
    emit(main_view.ViewState(message,image,code,count));
  }

  
}
