// import 'dart:ui';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:news_sphere/core/configs/images/app_images.dart';
// import 'package:news_sphere/features/auth/presentation/login_page.dart';
//
// import '../../../../common/widgets/basic_app_button.dart';
// import '../../../../core/configs/vectors/app_vectors.dart';
// import '../bloc/theme_cubit.dart';
//
// class ChooseModePage extends StatelessWidget {
//   const ChooseModePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 40, vertical: 45),
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 fit: BoxFit.fill,
//                 image: AssetImage(AppImages.introBG),
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(vertical: 40, horizontal: 40),
//             child: Column(
//               children: [
//                 Align(
//                   alignment: Alignment.topCenter,
//                   child: Image.asset(AppImages.startBG),
//                 ),
//                 Spacer(),
//                 Text(
//                   'Choose Mode',
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                       fontSize: 18),
//                 ),
//                 SizedBox(height: 40),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Column(
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             context
//                                 .read<ThemeCubit>()
//                                 .updateTheme(ThemeMode.dark);
//                           },
//                           child: ClipOval(
//                             child: BackdropFilter(
//                               filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//                               child: Container(
//                                 height: 80,
//                                 width: 80,
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   color: Color(0xff30393c),
//                                 ),
//                                 child: SvgPicture.asset(AppVectors.moon,
//                                     fit: BoxFit.none),
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 15),
//                         Text(
//                           'Dark Mode',
//                           style: TextStyle(
//                               fontSize: 17,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.grey),
//                         )
//                       ],
//                     ),
//                     SizedBox(width: 40),
//                     Column(
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             context
//                                 .read<ThemeCubit>()
//                                 .updateTheme(ThemeMode.light);
//                           },
//                           child: ClipOval(
//                             child: BackdropFilter(
//                               filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//                               child: Container(
//                                 height: 80,
//                                 width: 80,
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   color: Color(0xff30393c),
//                                 ),
//                                 child: SvgPicture.asset(AppVectors.sun,
//                                     fit: BoxFit.none),
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 15),
//                         Text(
//                           'Light Mode',
//                           style: TextStyle(
//                               fontSize: 17,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.grey),
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 50),
//                 BasicAppButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (BuildContext context) => LoginPage()),
//                     );
//                   },
//                   title: 'Continue',
//                   height: 80,
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
