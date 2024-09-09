// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
//
// import 'my_educlass.dart';
//
// class NearbyEventsCarousel extends StatefulWidget {
//   @override
//   _NearbyEventsCarouselState createState() => _NearbyEventsCarouselState();
// }
//
// class _NearbyEventsCarouselState extends State<NearbyEventsCarousel> {
//   final List<Map<String, String>> events = [
//     {'title': 'Plastic-free on the Chalk Lakes', 'date': '16.06.24', 'organizer': 'Cleaners Inc.', 'image': 'assets/browncarouselback.png'},
//     {'title': 'Beach Cleanup Day', 'date': '01.08.24', 'organizer': 'Ocean Protectors', 'image': 'assets/purplebakpic.png'},
//     {'title': 'Tree Planting Workshop', 'date': '10.08.24', 'organizer': 'Green Earth Org', 'image': 'assets/browncarouselback.png'},
//     {'title': 'Sustainable Living Fair', 'date': '15.08.24', 'organizer': 'EcoLife Events', 'image': 'assets/greycarouselsbackpic.png'},
//     {'title': 'Recycling Drive', 'date': '20.08.24', 'organizer': 'Recycle Society', 'image': 'assets/purplebakpic.png'},
//     {'title': 'Organic Farming Seminar', 'date': '25.08.24', 'organizer': 'Farm Fresh', 'image': 'assets/browncarouselback.png'},
//     {'title': 'Energy Conservation Workshop', 'date': '30.08.24', 'organizer': 'EcoEnergy', 'image': 'assets/greycarouselsbackpic.png'},
//     {'title': 'Zero Waste Cooking Class', 'date': '05.09.24', 'organizer': 'Green Kitchen', 'image': 'assets/purplebakpic.png'},
//     {'title': 'Community Garden Day', 'date': '12.09.24', 'organizer': 'Local Growers', 'image': 'assets/browncarouselback.png'},
//     {'title': 'Solar Power Information Session', 'date': '18.09.24', 'organizer': 'Solar Solutions', 'image': 'assets/greycarouselsbackpic.png'},
//     {'title': 'Eco-Friendly Transportation Expo', 'date': '22.09.24', 'organizer': 'Transport for Future', 'image': 'assets/purplebakpic.png'},
//     {'title': 'Green Building Tour', 'date': '30.09.24', 'organizer': 'Sustainable Structures', 'image': 'assets/browncarouselback.png'},
//     {'title': 'Wildlife Conservation Workshop', 'date': '05.10.24', 'organizer': 'Wildlife Guardians', 'image': 'assets/greycarouselsbackpic.png'},
//     {'title': 'Climate Change Awareness Event', 'date': '12.10.24', 'organizer': 'Climate Action Now', 'image': 'assets/purplebakpic.png'},
//     {'title': 'Eco-Fashion Show', 'date': '19.10.24', 'organizer': 'Fashion for Future', 'image': 'assets/browncarouselback.png'},
// ];
//
//   @override
//   Widget build(BuildContext context) {
//     return CarouselSlider(
//       options: CarouselOptions(
//         autoPlay: true,
//         autoPlayInterval: Duration(seconds: 5),
//         enlargeCenterPage: true,
//         aspectRatio: 2.0,
//       ),
//       items: events.map((event) {
//         return GestureDetector(
//           onTap: () {
//             // Navigate to the details page for the tapped event
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => EventDetailsPage(event: event),
//               ),
//             );
//           },
//           child: Card(
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//             child:
//             Container(
//               width: 300,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15.0),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black26,
//                     blurRadius: 10,
//                     offset: Offset(0, 5),
//                   ),
//                 ],
//                 image: DecorationImage(
//                   image: AssetImage(event['image']!),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(event['title']!, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                   Text(event['date']!),
//                   Text('by ${event['organizer']}'),
//                 ],
//               ),
//             ),
//           ),
//         );
//       }).toList(),
//     );
//   }
// }
//
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'; // Add this import

import 'my_educlass.dart';

class NearbyEventsCarousel extends StatefulWidget {
  @override
  _NearbyEventsCarouselState createState() => _NearbyEventsCarouselState();
}

class _NearbyEventsCarouselState extends State<NearbyEventsCarousel> {
  final List<Map<String, String>> events = [
    {'title': 'Plastic-free on the Chalk Lakes', 'date': '16.06.24', 'organizer': 'Cleaners Inc.', 'image': 'assets/browncarouselback.png'},
    {'title': 'Beach Cleanup Day', 'date': '01.08.24', 'organizer': 'Ocean Protectors', 'image': 'assets/purplebakpic.png'},
    {'title': 'Tree Planting Workshop', 'date': '10.08.24', 'organizer': 'Green Earth Org', 'image': 'assets/browncarouselback.png'},
    {'title': 'Sustainable Living Fair', 'date': '15.08.24', 'organizer': 'EcoLife Events', 'image': 'assets/greycarouselsbackpic.png'},
    {'title': 'Recycling Drive', 'date': '20.08.24', 'organizer': 'Recycle Society', 'image': 'assets/purplebakpic.png'},
    {'title': 'Organic Farming Seminar', 'date': '25.08.24', 'organizer': 'Farm Fresh', 'image': 'assets/browncarouselback.png'},
    {'title': 'Energy Conservation Workshop', 'date': '30.08.24', 'organizer': 'EcoEnergy', 'image': 'assets/greycarouselsbackpic.png'},
    {'title': 'Zero Waste Cooking Class', 'date': '05.09.24', 'organizer': 'Green Kitchen', 'image': 'assets/purplebakpic.png'},
    {'title': 'Community Garden Day', 'date': '12.09.24', 'organizer': 'Local Growers', 'image': 'assets/browncarouselback.png'},
    {'title': 'Solar Power Information Session', 'date': '18.09.24', 'organizer': 'Solar Solutions', 'image': 'assets/greycarouselsbackpic.png'},
    {'title': 'Eco-Friendly Transportation Expo', 'date': '22.09.24', 'organizer': 'Transport for Future', 'image': 'assets/purplebakpic.png'},
    {'title': 'Green Building Tour', 'date': '30.09.24', 'organizer': 'Sustainable Structures', 'image': 'assets/browncarouselback.png'},
    {'title': 'Wildlife Conservation Workshop', 'date': '05.10.24', 'organizer': 'Wildlife Guardians', 'image': 'assets/greycarouselsbackpic.png'},
    {'title': 'Climate Change Awareness Event', 'date': '12.10.24', 'organizer': 'Climate Action Now', 'image': 'assets/purplebakpic.png'},
    {'title': 'Eco-Fashion Show', 'date': '19.10.24', 'organizer': 'Fashion for Future', 'image': 'assets/browncarouselback.png'},
  ];

  final CarouselController _carouselController = CarouselController();
  int _activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          carouselController: CarouselSliderControllerImpl(),
          options: CarouselOptions(
            height: 200.0,
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 16 / 9,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            pauseAutoPlayOnTouch: true,
            viewportFraction: 0.8,
            onPageChanged: (index, reason) => setState(() {
              _activeIndex = index;
            }),
          ),
          items: events.map((event) {
            return GestureDetector(
              onTap: () {
                // Navigate to the details page for the tapped event
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventDetailsPage(event: event),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Container(
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                    image: DecorationImage(
                      image: AssetImage(event['image']!),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Center(child: Text(event['title']!,style: GoogleFonts.adamina(fontWeight: FontWeight.w400,fontSize: 25),)),
                      ),
                      Text(event['date']!,style: GoogleFonts.aboreto(fontWeight: FontWeight.w400,fontSize: 20),),
                      Text('by ${event['organizer']}',style: GoogleFonts.mansalva(fontWeight: FontWeight.w400,fontSize: 20),),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 16),
        buildIndicator(),
      ],
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
    activeIndex: _activeIndex,
    count: events.length,
    effect: ExpandingDotsEffect(
      dotWidth: 15,
      dotHeight: 10,
      activeDotColor: Colors.blueGrey,
      dotColor: Colors.grey,
    ),
  );
}
