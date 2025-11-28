// import 'package:flutter/material.dart';
// import 'package:money_tracker/core/constants/app_assets.dart';
// import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

// class CustomBottomNavBar extends StatefulWidget {
//   const CustomBottomNavBar({super.key});

//   @override
//   State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
// }

// class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
//   @override
//   Widget build(BuildContext context) {
//     return StylishBottomBar(
//       items: [
//         BottomBarItem(
//           icon: Image.asset(AppAssets.home, height: 28, width: 28),
//           title: const Text('home'),
//         ),
//         BottomBarItem(
//           icon: const Icon(Icons.safety_divider),
//           title: const Text('Safety'),
//           backgroundColor: Colors.orange,
//         ),
//         BottomBarItem(
//           icon: const Icon(Icons.cabin),
//           title: const Text('Cabin'),
//           backgroundColor: Colors.purple,
//         ),
//       ],
//       fabLocation: StylishBarFabLocation.end,
//       hasNotch: true,
//       currentIndex: 1,
//       onTap: (index) {},
//       option: DotBarOptions(),
//     );
//   }
// }
