// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
 
// class CarouselSliderScreen extends StatelessWidget {
//   final String flagUrl;
//   final String coatOfArmsUrl;
//   const CarouselSliderScreen({
//     super.key,
//     required this.flagUrl,
//     required this.coatOfArmsUrl,
//   });
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final List<String> images = [flagUrl, coatOfArmsUrl];

//     final CarouselSliderController carouselSliderController =
//         CarouselSliderController();

//     return Stack(
//       children: [
//         CarouselSlider(
//           items:
//               images.map((url) {
//                 return Builder(
//                   builder: (BuildContext context) {
//                     return ClipRRect(
//                       borderRadius: BorderRadius.circular(6),
//                       child: CachedNetworkImage(
//                         imageUrl: url,
//                         fit: BoxFit.cover,
//                         placeholder:
//                             (context, url) => Center(
//                               child: SizedBox(
//                                 width: 30,
//                                 height: 30,
//                                 child: CircularProgressIndicator(
//                                   strokeWidth: 2,
//                                 ),
//                               ),
//                             ),
//                         errorWidget:
//                             (context, url, error) =>
//                                 Center(child: Icon(Icons.flag_circle_rounded)),
//                       ),
//                     );
//                   },
//                 );
//               }).toList(),
//           options: CarouselOptions(
//             height: 250,
//             autoPlay: true,
//             enlargeCenterPage: true,
//             viewportFraction: 0.9,
//             autoPlayInterval: Duration(seconds: 3),
//             onPageChanged: (index, reason) {
//               // setState(() {
//               //   currentIndex = index;
//               // });
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
