import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_exam/core/app/view.dart' as base;
import 'package:mobile_exam/core/services/server.dart';
import 'package:mobile_exam/screens/exam/cubit/counter_cubit.dart';

class ViewState extends base.ViewState {
  final String msg, image;
  final int code, count;

  ViewState(this.msg, this.image, this.code, this.count);

  @override
  Widget content(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          const SizedBox(height: 20),
          Image.network(image),
          Center(child: Text(msg)),
          Row(
            children: [
              SizedBox(width: 20,),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).increment();
                    context.server.addToCount(1);
                  },
                  child: Icon(Icons.add), // Replaced "Add" with an icon
                ),
              ),
              SizedBox(width: 25,),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).decrement();
                    context.server.addToCount(-1);
                  },
                  child: Icon(Icons.remove), // Replaced "Add" with an icon
                ),
              ),
              SizedBox(width: 20,),
            ],
          ),
          Center(
            child: BlocBuilder<CounterCubit, CounterState>(
              builder: (context, state) {
                return Text(
                  state.counterValue.toString(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
