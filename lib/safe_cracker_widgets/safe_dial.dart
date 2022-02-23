

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SafeDial extends StatelessWidget {
  final Function()? onIncrement;
  final Function()? onDecrement;
  final int startingValue;
  const SafeDial(
      {Key? key,
        required this.startingValue,
        this.onIncrement,
        this.onDecrement})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical:8),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),

      constraints: const BoxConstraints(minHeight: 70),
      color: Colors.deepPurpleAccent,
      child: Column(
        children: [
          IconButton(
              onPressed: onIncrement, icon: const Icon(CupertinoIcons.chevron_up, color: Colors.white,)),
          Expanded(
            child: Text(
              "$startingValue",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          IconButton(
              onPressed: onDecrement, icon: const Icon(CupertinoIcons.chevron_down, color: Colors.white)),
        ],
      ),
    );
  }
}