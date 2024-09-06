import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';


part 'test_event.dart';

part 'test_state.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  TextEditingController annualController = TextEditingController();
  TextEditingController acController = TextEditingController();
  TextEditingController roomController = TextEditingController();
  TextEditingController otherController = TextEditingController();

  TestBloc() : super(TestState()) {
  }



  void cal() {
    num annual = annualController.text.isEmpty ? 0 : num.parse(annualController.text);
    num acUsage = acController.text.isEmpty ? 0 : num.parse(acController.text);
    num roomUsage = roomController.text.isEmpty ? 0 : num.parse(roomController.text);
    num otherUsage = otherController.text.isEmpty ? 0 : num.parse(otherController.text);

    // Condition 1: (1) should always be equal to (2) + (3) + (4)
    if (annual != (acUsage + roomUsage + otherUsage)) {
      // Determine which field to update based on which field was changed

      // Case: (1) was changed, update the other fields
      if (acUsage == 0 && roomUsage == 0) {
        otherController.text = (annual).toString();
      } else if (acUsage != 0 || roomUsage != 0) {
        annualController.text = (acUsage + roomUsage + otherUsage).toString();
        otherController.text = (num.parse(annualController.text.toString()) - (acUsage + roomUsage)).toString();
      }

      // If ((2) + (3) > (1)), otherUsage should be zero
      if (acUsage + roomUsage > annual) {
        otherController.text = "0";
      }

      // Update (1) if (4) is greater than 0
      if (otherUsage > 0) {
        annualController.text = (acUsage + roomUsage + otherUsage).toString();
      }
    } else {
      annualController.text = (acUsage + roomUsage + otherUsage).toString();
    }
  }
}
