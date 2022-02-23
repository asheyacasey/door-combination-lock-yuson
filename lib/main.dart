import 'package:elec2b_review/safe_cracker_widgets/safe_dial.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SP_ELEC2B',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const SafeCrackerView(title: 'SP_ELEC_REVIEW'),
    );
  }
}

class SafeCrackerView extends StatefulWidget {
  const SafeCrackerView({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<SafeCrackerView> createState() => _SafeCrackerViewState();
}

class _SafeCrackerViewState extends State<SafeCrackerView> {
  List<int> values = [0, 0, 0];
  String combination = "420";
  String feedback = '';
  bool isUnlocked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Safe Cracker",
          textAlign: TextAlign.center,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundColor: Colors.redAccent,
              radius: 50,
              child: Icon(
                  isUnlocked
                      ? CupertinoIcons.lock_open_fill
                      : CupertinoIcons.lock_fill,

                  color: Colors.white,
                  size: 48,


                  ),
            ),
            

            Container(
              margin: const EdgeInsets.symmetric(vertical: 32),
              height: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < values.length; i++)
                    SafeDial(
                      startingValue: values[i],
                      onIncrement: () {
                        setState(() {
                          if (values[i] == 9) {
                            values[i] = 0;
                          } else {
                            values[i]++;
                          }
                        });
                      },
                      onDecrement: () {
                        setState(() {
                          if (values[i] == 0) {
                            values[i] = 9;
                          } else {
                            values[i]--;
                          }
                        });
                      },
                    ),
                ],
              ),
            ),
            if (feedback.isNotEmpty) Text(feedback),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 48),
              child: TextButton(
                onPressed: unlockSafe,
                child: const Text("OPEN SAFE", style: TextStyle(fontSize: 18,  fontWeight: FontWeight.w400, )),
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(vertical: 28, horizontal: 40)),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.red)
                        )
                    )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  unlockSafe() {
    if (checkCombination()) {
      setState(() {
        isUnlocked = true;
        feedback = "You unlocked the safe!";
      });
    } else {
      setState(() {
        isUnlocked = false;
        feedback = "Wrong combination, try again!";
      });
    }
  }

  bool checkCombination() {
    String theCurrentValue = convertValuesToComparableString(values);
    bool isUnlocked = (theCurrentValue == combination);
    return isUnlocked;
  }

  String convertValuesToComparableString(List<int> val) {
    String temp = "";
    for (int v in val) {
      temp = temp + "$v";
    }
    return temp;
  }
}

int sumofAllValues(List<int> list) {
  int temp = 0;
  for (int i = 0; i < list.length; i++) {
    temp += list[i];
  }
  for (int number in list) {
    temp = temp + number;
  }
  return temp;
}

class NumberHolder extends StatelessWidget {
  final dynamic content;
  const NumberHolder({Key? key, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(4),
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 60),
      color: Colors.orangeAccent,
      child: Center(
        child: Text(
          "$content",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class IncrementalNumberHolder extends StatefulWidget {
  final Function(int) onUpdate;
  final int startingValue;
  const IncrementalNumberHolder(
      {Key? key, this.startingValue = 0, required this.onUpdate})
      : super(key: key);

  @override
  State<IncrementalNumberHolder> createState() =>
      _IncrementalNumberHolderState();
}

class _IncrementalNumberHolderState extends State<IncrementalNumberHolder> {
  @override
  void initState() {
    currentValue = widget.startingValue;
    super.initState();
  }

  late int currentValue;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              setState(() {
                currentValue--;
              });
              widget.onUpdate(currentValue);
            },
            icon:  const Icon(Icons.chevron_left)),
        Expanded(
          child: Text(
            "$currentValue",
            textAlign: TextAlign.center,
          ),
        ),
        IconButton(
            onPressed: () {
              setState(() {
                currentValue++;
              });
            },
            icon:  const Icon(Icons.chevron_right, color: Colors.white,)),
      ],
    );
  }
}
