import 'package:barbershop/providers/booking_provider.dart';
import 'package:barbershop/screen/auth/widgets/snackbar.dart';
import 'package:barbershop/screen/home/navbar_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookingService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  // TextEditingController nameCustomer = TextEditingController();
  // TextEditingController nameBarbershop = TextEditingController();
  // TextEditingController noOrder = TextEditingController();
  // TextEditingController messageOrder = TextEditingController();
  // TextEditingController dateOrder = TextEditingController();
  // TextEditingController timeOrder = TextEditingController();

  void tambahData(context) async {
    CollectionReference booking = firestore.collection("booking");
    BookingProvider bookingProvider =
        Provider.of<BookingProvider>(context, listen: false);

    booking.add({
      'name barbershop': bookingProvider.nameBarbershop.text,
      'name Customer': bookingProvider.nameCustomer.text,
      'no Order': bookingProvider.noOrder.text,
      'date': bookingProvider.dateOrder.text,
      'hourse': bookingProvider.hoursOrder.text,
      'message Order': bookingProvider.messageOrder.text,
    });
    showTextMessage(context, 'Booking succesful');
    bookingProvider.nameCustomer.clear();
    bookingProvider.noOrder.clear();
    bookingProvider.dateOrder.clear();
    bookingProvider.messageOrder.clear();
    bookingProvider.hoursOrder.clear();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const NavbarScreen(),
      ),
      (route) => false,
    );
  }

  Stream<QuerySnapshot<Object?>> streamBooking() {
    CollectionReference data = firestore.collection("booking");
    return data.snapshots();
  }

  Future<DocumentSnapshot<Object?>> getBookingByID(String id) {
    DocumentReference docRef = firestore.collection("booking").doc(id);
    return docRef.get();
  }

  void updateBooking(String id, context) {
    BookingProvider bookingProvider =
        Provider.of<BookingProvider>(context, listen: false);
    DocumentReference docRef = firestore.collection("booking").doc(id);

    docRef.update({

      'name Customer': bookingProvider.nameCustomer.text,
      'no Order': bookingProvider.noOrder.text,
      'date': bookingProvider.dateOrder.text,
      'hours': bookingProvider.hoursOrder.text,
      'message Order': bookingProvider.messageOrder.text,
    });

    bookingProvider.nameCustomer.clear();
    bookingProvider.noOrder.clear();
    bookingProvider.dateOrder.clear();
    bookingProvider.messageOrder.clear();
    bookingProvider.hoursOrder.clear();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const NavbarScreen(),
      ),
      (route) => false,
    );
  }

  void hapusData(String id) {
    DocumentReference docRef = firestore.collection("booking").doc(id);
    docRef.delete();
  }
}
