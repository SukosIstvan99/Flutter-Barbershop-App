import 'package:barbershop/models/barbershop_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingProvider extends ChangeNotifier {
  DateTime currentDate = DateTime.now();
  DateTime? dueDate;
  TimeOfDay? time;
  BarbershopModel? barbershopModel;
  TextEditingController nameCustomer = TextEditingController();
  TextEditingController nameBarbershop = TextEditingController();
  TextEditingController noOrder = TextEditingController();
  TextEditingController messageOrder = TextEditingController();
  TextEditingController dateOrder = TextEditingController();
  TextEditingController hoursOrder = TextEditingController();

  void datePicker(context) async {
    final selectDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(currentDate.year + 5),
    );

    if (selectDate != null) {
      dueDate = selectDate;
      dateOrder.text = DateFormat('dd-MM-yyyy').format(dueDate!);
    }
    notifyListeners();
  }

  void timePicker(context) async {
    final selectTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectTime != null) {
      time = selectTime;
      hoursOrder.text =
          '${time!.hour.toString().padLeft(2, '0')}:${time!.minute.toString().padLeft(2, '0')}';
    }
    notifyListeners();
  }
}
