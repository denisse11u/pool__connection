import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


class PinTextForm extends StatefulWidget {
  const PinTextForm({super.key, required this.onfinish});
  final Function(String) onfinish;

  @override
  State<PinTextForm> createState() => _PinTextFormState();
}

class _PinTextFormState extends State<PinTextForm> {
  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
              appContext: context,
              length: 4,
              keyboardType: TextInputType.number,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(10),
                fieldHeight: 60,
                fieldWidth: 60,
                selectedColor: Colors.blue,
                inactiveColor: Colors.grey
              ),
              onCompleted: (value) => widget.onfinish(value),
          );
  }
}