import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:perfqse/Views/gestion/ies/widgets/impacts_societaux.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../../../../constants/colors.dart';
import '../../../../models/common/user_model.dart';
import '../../../../models/pilotage/acces_pilotage_model.dart';
import '../../../../widgets/customtext.dart';
import 'widgets/export_widgets_ies.dart';

class Ies extends StatefulWidget {

  @override
  State<Ies> createState() => _IesState();
}

class _IesState extends State<Ies> with SingleTickerProviderStateMixin {
  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'Impacts envrironnementaux'),
    Tab(text: 'Impacts sociétaux'),
    Tab(text: 'Ajouter un impact'),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(vsync: this, length: myTabs.length, initialIndex: 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: SizedBox(
              width: double.maxFinite,
              child: ContainedTabBarView(
                tabBarViewProperties: const TabBarViewProperties(
                  physics: BouncingScrollPhysics(),
                  dragStartBehavior: DragStartBehavior.start,
                ),
                tabBarProperties: TabBarProperties(
                    alignment: TabBarAlignment.start,
                    isScrollable: true,
                    labelColor: Colors.black,
                    labelPadding:
                    const EdgeInsets.only(left: 0, right: 30),
                    unselectedLabelColor: Colors.amber,
                    indicator: MaterialIndicator(
                      color: Colors.amber,
                      paintingStyle: PaintingStyle.fill,
                    )),
                tabs: const [
                  CustomText(
                    text: "Impacts envrironnementaux",
                    size: 15,
                  ),
                  CustomText(
                    text: "Impacts sociétaux",
                    size: 15,
                  ),
                  CustomText(
                    text: "Ajouter un impact",
                    size: 15,
                  ),
                ],
                views: [
                  Container(child: ImpactsEnvironnementaux(),),
                  Container(child: ImpactsSocietaux(),),
                  Container(child: AjoutImpacts(),)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
