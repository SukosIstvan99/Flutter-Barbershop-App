import 'package:barbershop/providers/booking_provider.dart';
import 'package:barbershop/service/booking_service.dart';
import 'package:barbershop/utils/constants/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditBookingScreen extends StatelessWidget {
  final String idDoc;
  const EditBookingScreen({
    Key? key,
    required this.idDoc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BookingProvider bookingProvider = Provider.of<BookingProvider>(context);
    BookingService bookingService = BookingService();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder<DocumentSnapshot<Object?>>(
            future: bookingService.getBookingByID(idDoc),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                final data = snapshot.data!.data() as Map<String, dynamic>;
                bookingProvider.nameBarbershop.text = data['name barbershop'];
                bookingProvider.nameCustomer.text = data['name customer'];
                bookingProvider.noOrder.text = data['no order'];
                bookingProvider.dateOrder.text = data['date'];
                bookingProvider.hoursOrder.text = data['hours'];
                bookingProvider.messageOrder.text = data['order message'];
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Edit Booking',
                        style: blackTextStyle.copyWith(
                          fontSize: 24,
                          fontWeight: semiBold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Name Barbershop',
                        style: blackTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: regular,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: bookingProvider.nameBarbershop,
                              readOnly: true,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                hintStyle: greyTextStyle.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Name Customer',
                              style: blackTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: regular,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: bookingProvider.nameCustomer,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                hintText: 'Enter Name',
                                hintStyle: greyTextStyle.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Phone nr ',
                              style: blackTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: regular,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: bookingProvider.noOrder,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                hintText: 'Enter Phone nr ',
                                hintStyle: greyTextStyle.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Select Booking Date',
                              style: blackTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: regular,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Consumer<BookingProvider>(
                              builder: (_, booking, child) {
                                return TextFormField(
                                  onTap: () {
                                    booking.datePicker(context);
                                  },
                                  controller: booking.dateOrder,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    hintText: 'Select Booking Date',
                                    hintStyle: greyTextStyle.copyWith(
                                      fontSize: 14,
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Select Booking Hours',
                              style: blackTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: regular,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Consumer<BookingProvider>(
                              builder: (_, booking, child) {
                                return TextFormField(
                                  onTap: () {
                                    booking.timePicker(context);
                                  },
                                  controller: booking.hoursOrder,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    hintText: 'Select Booking Hours',
                                    hintStyle: greyTextStyle.copyWith(
                                      fontSize: 14,
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Please write down what you want to be treated',
                              style: blackTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: regular,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: bookingProvider.messageOrder,
                              maxLines: 6,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                hintText: 'Example: Haircut',
                                hintStyle: greyTextStyle.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 20),
                              height: 70,
                              width: 400,
                              child: ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Confirm'),
                                      content: SingleChildScrollView(
                                        child: Text(
                                          'Are you sure the data entered is correct?',
                                          style: blackTextStyle,
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            bookingService.updateBooking(
                                                idDoc, context);
                                          },
                                          child: const Text('Yes'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('No'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: kPrimaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  'Next',
                                  style: whiteTextStyle.copyWith(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
