import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_keep_clone/mock_data.dart';
import 'package:google_keep_clone/screens/add_note_screen.dart';

class AlmostEndFloatFabLocation extends StandardFabLocation
    with FabEndOffsetX, FabFloatOffsetY {
  @override
  double getOffsetX(
      ScaffoldPrelayoutGeometry scaffoldGeometry, double adjustment) {
    final double directionalAdjustment =
        scaffoldGeometry.textDirection == TextDirection.ltr ? -20.0 : 0.0;
    return super.getOffsetX(scaffoldGeometry, adjustment) +
        directionalAdjustment;
  }

  @override
  double getOffsetY(
      ScaffoldPrelayoutGeometry scaffoldGeometry, double adjustment) {
    final double directionalAdjustment =
        scaffoldGeometry.textDirection == TextDirection.ltr ? 32.0 : 0.0;

    return super.getOffsetY(scaffoldGeometry, adjustment) +
        directionalAdjustment;
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var rng = Random();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  var data = mockData;

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: buildFloatingButton(),
      floatingActionButtonLocation: AlmostEndFloatFabLocation(),
      bottomNavigationBar: buildBottomBar(),
      drawer: buildDrawer(),
      body: CustomScrollView(
        slivers: [
          buildAppBar(statusBarHeight, context),
          SliverPadding(
              padding: const EdgeInsets.all(15),
              sliver: SliverMasonryGrid.count(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childCount: mockData.length,
                itemBuilder: ((context, index) {
                  int randHeight = rng.nextInt(100) + 100;
                  int randInt = rng.nextInt(7);
                  List<Color> colorsss = [
                    Colors.red.shade900.withOpacity(0.5),
                    Colors.yellow.shade900.withOpacity(0.5),
                    Colors.blue.shade900.withOpacity(0.5),
                    Colors.orange.shade900.withOpacity(0.5),
                    Colors.green.shade900.withOpacity(0.5),
                    Colors.cyan.shade900.withOpacity(0.5),
                    Colors.pink.shade900.withOpacity(0.5),
                  ];
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AddNoteScreen()));
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: colorsss[randInt],
                          border: Border.all(
                              color: Theme.of(context)
                                  .primaryColorLight
                                  .withOpacity(0.4))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              padding:
                                  EdgeInsets.only(right: 10, left: 10, top: 10),
                              child: Text(
                                data[index]['title'],
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              )),
                          Divider(),
                          Container(
                              padding: EdgeInsets.only(
                                  right: 10, left: 10, bottom: 10),
                              child: Text(data[index]['description'])),
                        ],
                      ),
                    ),
                  );
                }),
              )),
        ],
      ),
    );
  }

  Drawer buildDrawer() => Drawer(
        child: Container(
          padding: EdgeInsets.only(top: 16, right: 16),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: RichText(
                  text: TextSpan(
                      text: 'D',
                      style: GoogleFonts.ubuntu(
                        textStyle: TextStyle(
                          color: Color(0xff00a1f1),
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                        ),
                      ),
                      children: [
                        letter('a', Color(0xfff65314)),
                        letter('n', Color(0xffffbb00)),
                        letter('i', Color(0xff00a1f1)),
                        letter('e', Color(0xff7cbb00)),
                        letter('l', Color(0xfff65314)),
                        letter('\'', Color(0xffffbb00)),
                        letter('s', Color(0xff00a1f1)),
                        TextSpan(
                          text: ' Keep',
                          style: GoogleFonts.ubuntu(
                            textStyle: TextStyle(
                              color: Theme.of(context).primaryColorLight,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        )
                      ]),
                ),
              ),
              Divider(),
              ListTile(
                visualDensity: VisualDensity(vertical: -3),
                leading: Icon(Icons.lightbulb_outline),
                title: Text("Notes"),
                onTap: () {},
              ),
              ListTile(
                visualDensity: VisualDensity(vertical: -3),
                leading: Icon(Icons.notifications_none_outlined),
                title: Text("Reminders"),
                onTap: () {},
              ),
              ListTile(
                visualDensity: VisualDensity(vertical: -3),
                leading: Icon(Icons.add),
                title: Text("Create new label"),
                onTap: () {},
              ),
              ListTile(
                visualDensity: VisualDensity(vertical: -3),
                leading: Icon(Icons.archive_outlined),
                title: Text("Archive"),
                onTap: () {},
              ),
              ListTile(
                visualDensity: VisualDensity(vertical: -3),
                leading: Icon(Icons.delete_outline),
                title: Text("Trash"),
                onTap: () {},
              ),
              ListTile(
                visualDensity: VisualDensity(vertical: -3),
                leading: Icon(Icons.settings),
                title: Text("Settings"),
                onTap: () {},
              ),
              ListTile(
                visualDensity: VisualDensity(vertical: -3),
                leading: Icon(Icons.help_outline),
                title: Text("Help & feedback"),
                onTap: () {},
              ),
            ],
          ),
        ),
      );

  TextSpan letter(String s, Color c) {
    return TextSpan(
      text: s,
      style: GoogleFonts.ubuntu(textStyle: TextStyle(color: c)),
    );
  }

  SliverAppBar buildAppBar(double statusBarHeight, BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      expandedHeight: 70,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(20),
        child: Container(),
      ),
      flexibleSpace: Container(
        padding:
            EdgeInsets.only(left: 15, right: 15, top: statusBarHeight + 20),
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).secondaryHeaderColor,
              borderRadius: BorderRadius.circular(20)),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: IconButton(
                        icon: const Icon(Icons.menu),
                        onPressed: () {
                          _scaffoldKey.currentState?.openDrawer();
                        },
                        splashRadius: 20,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        "Search your notes",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Material(
                      color: Colors.transparent,
                      child: IconButton(
                        icon: const Icon(Icons.grid_view),
                        onPressed: () {},
                        splashRadius: 20,
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: const CircleAvatar(
                            radius: 15,
                            backgroundImage:
                                NetworkImage("https://unsplash.it/300"),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floating: true,
    );
  }

  FloatingActionButton buildFloatingButton() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => AddNoteScreen()));
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Icon(Icons.add, size: 34),
    );
  }

  BottomAppBar buildBottomBar() {
    return BottomAppBar(
      shape: AutomaticNotchedShape(
        const RoundedRectangleBorder(),
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
          side: BorderSide.none,
        ),
      ),
      notchMargin: 7,
      child: Row(
        children: [
          const SizedBox(
            width: 15,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.check_box_outlined),
            splashRadius: 20,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.brush_outlined),
            splashRadius: 20,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.mic_outlined),
            splashRadius: 20,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.image_outlined),
            splashRadius: 20,
          ),
          const Opacity(
            opacity: 0,
            child: IconButton(
              onPressed: null,
              icon: Icon(Icons.search),
            ),
          ),
        ],
      ),
    );
  }
}
