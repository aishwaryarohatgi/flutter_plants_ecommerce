import 'package:flutter/material.dart';
import 'package:flutter_plants_ecommerce/models/constants.dart';
import 'package:flutter_plants_ecommerce/models/plant_data.dart';
import 'package:flutter_plants_ecommerce/pages/details_page.dart';
import 'package:flutter_plants_ecommerce/widgets/plant_widget.dart';
import 'package:page_transition/page_transition.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    int selectedIndex = 0;
    Size size = MediaQuery.of(context).size;

    List<Plant> plantList = Plant.plantList;

    //Plants category
    List<String> plantTypes = [
      'Recommended',
      'Indoor',
      'Outdoor',
      'Garden',
      'Supplement',
    ];

    //Toggle Favorite button
    bool toggleIsFavorited(bool isFavorited) {
      return !isFavorited;
    }

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  width: size.width * .9,
                  decoration: BoxDecoration(
                    color: Constants.primaryColor.withOpacity(.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.black54.withOpacity(.6),
                      ),
                      const Expanded(
                          child: TextField(
                        showCursor: false,
                        decoration: InputDecoration(
                          hintText: 'Search Plant',
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      )),
                      Icon(
                        Icons.mic,
                        color: Colors.black54.withOpacity(.6),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            height: 50.0,
            width: size.width,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: plantTypes.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Text(
                        plantTypes[index],
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: selectedIndex == index
                              ? FontWeight.bold
                              : FontWeight.w300,
                          color: selectedIndex == index
                              ? Constants.primaryColor
                              : Constants.blackColor,
                        ),
                      ),
                    ),
                  );
                }),
          ),
          SizedBox(
            height: size.height * .3,
            child: ListView.builder(
                itemCount: plantList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: DetailPage(
                                plantId: plantList[index].plantId,
                              ),
                              type: PageTransitionType.bottomToTop));
                    },
                    child: Container(
                      width: 200,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Constants.primaryColor.withOpacity(.8),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 10,
                            right: 20,
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    bool isFavorited = toggleIsFavorited(
                                        plantList[index].isFavorited);
                                    plantList[index].isFavorited = isFavorited;
                                  });
                                },
                                icon: Icon(
                                  plantList[index].isFavorited == true
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Constants.primaryColor,
                                ),
                                iconSize: 30,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 50,
                            right: 50,
                            top: 50,
                            bottom: 50,
                            child: Image.asset(plantList[index].imageURL),
                          ),
                          Positioned(
                            bottom: 15,
                            left: 20,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  plantList[index].category,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  plantList[index].plantName,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 15,
                            right: 20,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                r'$' + plantList[index].price.toString(),
                                style: TextStyle(
                                    color: Constants.primaryColor,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
          Container(
            padding: const EdgeInsets.only(left: 16, bottom: 20, top: 20),
            child: const Text(
              'New Plants',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            height: size.height * .5,
            child: ListView.builder(
                itemCount: plantList.length,
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return PlantWidget(index: index, plantList: plantList);
                }),
          ),
        ],
      ),
    ));
  }
}




// import 'package:flutter/material.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int pageIndex = 0;

//   final pages = [
//     const Page1(),
//     const Page2(),
//     const Page3(),
//     const Page4(),
//     const Page5(),
//     const Page6(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Welcome'),
//         actions: [
//           IconButton(
//               onPressed: () {
//                 setState(() {
//                   pageIndex = 4;
//                 });
//               },
//               icon: const Icon(Icons.shopping_cart_outlined)),
//           IconButton(
//               onPressed: () {
//                 setState(() {
//                   pageIndex = 5;
//                 });
//               },
//               icon: const Icon(Icons.person)),
//         ],
//       ),
//       bottomNavigationBar: Container(
//         height: 60,
//         decoration: BoxDecoration(
//           color: Theme.of(context).primaryColor,
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//           ),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             IconButton(
//               enableFeedback: false,
//               onPressed: () {
//                 setState(() {
//                   pageIndex = 0;
//                 });
//               },
//               icon: pageIndex == 0
//                   ? const Icon(
//                       Icons.home_filled,
//                       color: Colors.white,
//                       size: 35,
//                     )
//                   : const Icon(
//                       Icons.home_outlined,
//                       color: Colors.white,
//                       size: 35,
//                     ),
//             ),
//             IconButton(
//               enableFeedback: false,
//               onPressed: () {
//                 setState(() {
//                   pageIndex = 1;
//                 });
//               },
//               icon: pageIndex == 1
//                   ? const Icon(
//                       Icons.work_rounded,
//                       color: Colors.white,
//                       size: 35,
//                     )
//                   : const Icon(
//                       Icons.work_outline_outlined,
//                       color: Colors.white,
//                       size: 35,
//                     ),
//             ),
//             IconButton(
//               enableFeedback: false,
//               onPressed: () {
//                 setState(() {
//                   pageIndex = 2;
//                 });
//               },
//               icon: const Icon(
//                 Icons.description_outlined,
//                 color: Colors.white,
//                 size: 35,
//               ),
//             ),
//             IconButton(
//               enableFeedback: false,
//               onPressed: () {
//                 setState(() {
//                   pageIndex = 3;
//                 });
//               },
//               icon: const Icon(
//                 Icons.notifications_outlined,
//                 color: Colors.white,
//                 size: 35,
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: pages[
//           pageIndex], // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }

// class Page1 extends StatelessWidget {
//   const Page1({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // final mobile = ResponsiveWrapper.of(context).isMobile;

//     return const Center(
//       child: Text(
//         "Home",
//         style: TextStyle(
//           fontSize: 45,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//     );
//   }
// }

// class Page2 extends StatelessWidget {
//   const Page2({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text(
//         "Search",
//         style: TextStyle(
//           fontSize: 45,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//     );
//   }
// }

// class Page3 extends StatelessWidget {
//   const Page3({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text(
//         "Blogs",
//         style: TextStyle(
//           fontSize: 45,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//     );
//   }
// }

// class Page4 extends StatelessWidget {
//   const Page4({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text(
//         "Notifications",
//         style: TextStyle(
//           fontSize: 45,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//     );
//   }
// }

// class Page5 extends StatelessWidget {
//   const Page5({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text(
//         "Shopping Cart",
//         style: TextStyle(
//           fontSize: 45,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//     );
//   }
// }

// class Page6 extends StatelessWidget {
//   const Page6({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text(
//         "Profile",
//         style: TextStyle(
//           fontSize: 45,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//     );
//   }
// }
