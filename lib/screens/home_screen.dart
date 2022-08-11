import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      floatingActionButton: buildFloatingButton(),
      floatingActionButtonLocation: AlmostEndFloatFabLocation(),
      bottomNavigationBar: buildBottomBar(),
      body: CustomScrollView(
        slivers: [
          buildAppBar(statusBarHeight, context),
          SliverPadding(
              padding: const EdgeInsets.all(15),
              sliver: SliverMasonryGrid.count(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                itemBuilder: ((context, index) {
                  int randHeight = rng.nextInt(100) + 100;
                  return InkWell(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.5))),
                      height: randHeight.toDouble(),
                    ),
                  );
                }),
              )),
        ],
      ),
    );
  }

  SliverAppBar buildAppBar(double statusBarHeight, BuildContext context) {
    return SliverAppBar(
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
                        onPressed: () {},
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
      onPressed: () {},
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
