import 'package:barbershop/providers/navbar_provider.dart';
import 'package:barbershop/screen/history/history_screen.dart';
import 'package:barbershop/screen/home/home_screen.dart';
import 'package:barbershop/screen/profile/profile_screen.dart';
import 'package:barbershop/utils/constants/theme.dart';
import 'package:barbershop/screen/location/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavbarScreen extends StatefulWidget {
  const NavbarScreen({Key? key}) : super(key: key);

  @override
  State<NavbarScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<NavbarScreen> {
  List<dynamic> screens = [
    const HomeScreen(),
    const LocationScreen(),
    const HistoryScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    NavBarProvider navBarProvider = Provider.of<NavBarProvider>(context);
    int currentScreenIndex = navBarProvider.fetchCurrentScreenIndex;

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        selectedItemColor: kPrimaryColor,
        elevation: 1.5,
        currentIndex: currentScreenIndex,
        showUnselectedLabels: true,
        onTap: (value) => navBarProvider.updateScreenIndex(value),
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(
                (currentScreenIndex == 0) ? Icons.home : Icons.home_outlined),
          ),
          BottomNavigationBarItem(
            label: 'Location',
            icon: Icon((currentScreenIndex == 1)
                ? Icons.location_on
                : Icons.location_on_outlined),
          ),
          BottomNavigationBarItem(
            label: 'History',
            icon: Icon((currentScreenIndex == 2)
                ? Icons.event_available
                : Icons.event_available_outlined),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon((currentScreenIndex == 3)
                ? Icons.person
                : Icons.person_outline),
          ),
        ],
      ),
      body: screens[currentScreenIndex],
    );
  }
}
