// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:stream4videos/generated/assets.dart';
//
// class PlanHeroSlider extends StatefulWidget {
//   const PlanHeroSlider({super.key});
//
//   @override
//   State<PlanHeroSlider> createState() => _PlanHeroSliderState();
// }
//
// class _PlanHeroSliderState extends State<PlanHeroSlider> {
//   int current = 0;
//
//   final List<String> images = [
//     Assets.imageRamSetu,
//     Assets.imageRamSetu,
//     Assets.imageRamSetu,
//     Assets.imageRamSetu,
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.bottomCenter,
//       children: [
//         CarouselSlider.builder(
//           itemCount: images.length,
//           itemBuilder: (context, index, realIdx) {
//             return Stack(
//               children: [
//                 Positioned.fill(
//                   child: Image.asset(
//                     images[index],
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//
//                 Positioned.fill(
//                   child: Container(
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment.bottomCenter,
//                         end: Alignment.center,
//                         colors: [
//                           Colors.black,
//                           Colors.black.withOpacity(0.85),
//                           Colors.transparent,
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           },
//           options: CarouselOptions(
//             height: MediaQuery.of(context).size.height * 0.55,
//             viewportFraction: 1,
//             autoPlay: true,
//             autoPlayInterval: const Duration(seconds: 4),
//             autoPlayAnimationDuration: const Duration(milliseconds: 900),
//             onPageChanged: (i, _) => setState(() => current = i),
//           ),
//         ),
//
//         /// Page Indicators
//         Positioned(
//           bottom: 25,
//           child: Row(
//             children: List.generate(
//               images.length,
//                   (i) => AnimatedContainer(
//                 duration: const Duration(milliseconds: 300),
//                 width: current == i ? 20 : 7,
//                 height: 6,
//                 margin: const EdgeInsets.symmetric(horizontal: 3),
//                 decoration: BoxDecoration(
//                   color: current == i
//                       ? Colors.white
//                       : Colors.white.withOpacity(0.4),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
