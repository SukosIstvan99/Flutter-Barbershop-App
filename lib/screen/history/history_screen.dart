import 'package:barbershop/models/booking_model.dart';
import 'package:barbershop/screen/edit_booking/edit_booking_screen.dart';
import 'package:barbershop/screen/history/widget/history_card.dart';
import 'package:barbershop/service/booking_service.dart';
import 'package:barbershop/utils/constants/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BookingService bookingService = BookingService();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              Text(
                'Booking History',
                style: blackTextStyle.copyWith(
                  fontSize: 24,
                  fontWeight: semiBold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              StreamBuilder<QuerySnapshot<Object?>>(
                stream: bookingService.streamBooking(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    var data = snapshot.data!.docs;
                    return Expanded(
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final dataBooking =
                              data[index].data() as Map<String, dynamic>;
                          return HistoryCard(
                            BookingModel(
                              nameCustomer: dataBooking['customer name'],
                              nameBarbershop: dataBooking['name barbershop'],
                              date: dataBooking['date'],
                              hours: dataBooking['hours'],
                              no: dataBooking['order no'],
                              message: dataBooking['order message'],
                            ),
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditBookingScreen(
                                    idDoc: data[index].id,
                                  ),
                                ),
                              );
                            },
                            () {
                              bookingService.hapusData(data[index].id);
                            },
                          );
                        },
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
