import 'package:barbershop/utils/constants/theme.dart';
import 'package:flutter/material.dart';

class KetentuanScreen extends StatelessWidget {
  const KetentuanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Text(
                    'PROVISION BOOKING',
                    style: blackTextStyle.copyWith(
                      fontSize: 24,
                      fontWeight: semiBold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  '1. It is expected to arrive 10 minutes before your booking time',
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  '2.It is hoped that it will come according to the time that has been booked',
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  '3.Make sure you bring your cell phone for proof of booking',
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
