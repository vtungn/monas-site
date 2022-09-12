import 'dart:js' as js;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NumberCounter extends StatefulWidget {
  final Function(int) onChanged;
  const NumberCounter({Key? key, required this.onChanged}) : super(key: key);

  @override
  State<NumberCounter> createState() => _NumberCounterState();
}

class _NumberCounterState extends State<NumberCounter> {
  int number = 0;
  bool tenPlus = false;
  late js.JsObject telegramjs;
  @override
  void initState() {
    super.initState();
    // window.Telegram.WebApp
    if (kIsWeb) {
      var telegram = js.JsObject.fromBrowserObject(js.context['Telegram']);
      telegramjs = telegram['WebApp'];
      telegramjs['BackButton'].callMethod('show', []);
      telegramjs['BackButton'].callMethod('onClick', [
        () {
          Navigator.maybePop(context);
        }
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ToggleButtons(
            onPressed: number == 0
                ? null
                : (index) {
                    telegramjs['HapticFeedback']
                        .callMethod('selectionChanged', []);
                    setState(() {
                      number = number -
                          (index == 0 ? (number < 10 ? number : 10) : 1);
                    });
                    widget.onChanged(number);
                  },
            isSelected: tenPlus ? const [true, false] : const [false],
            // text color
            selectedColor: Colors.black,
            color: Colors.black,
            // bg color
            // selected color
            fillColor: Colors.blue[100],
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            children: tenPlus
                ? const [
                    Text(
                      '-10',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      '-1',
                      style: TextStyle(fontSize: 16),
                    ),
                  ]
                : const [Icon(Icons.remove)],
          ),
          SizedBox(
            width: 100,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '$number',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.blue[900]),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          ToggleButtons(
            onPressed: (index) {
              telegramjs['HapticFeedback'].callMethod('selectionChanged', []);
              setState(() {
                tenPlus = true;
                number = number + (index == 0 ? 1 : 10);
              });
              widget.onChanged(number);
            },
            isSelected: tenPlus ? const [false, true] : const [false],
            // text color
            selectedColor: Colors.black,
            color: Colors.black,
            // bg color
            // selected color
            fillColor: Colors.blue[100],
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            children: tenPlus
                ? const [
                    Text(
                      '+1',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      '+10',
                      style: TextStyle(fontSize: 16),
                    ),
                  ]
                : const [Icon(Icons.add)],
          ),
        ],
      ),
    );
  }
}
