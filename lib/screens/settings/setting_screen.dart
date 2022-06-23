import 'package:emedassistantmobile/screens/settings/components/locations_screen.dart';
import 'package:emedassistantmobile/screens/settings/components/s_profile_screen.dart';
import 'package:emedassistantmobile/screens/settings/components/specialities_screen.dart';
import 'package:emedassistantmobile/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

import 'package:emedassistantmobile/config/app_colors.dart';
import 'package:emedassistantmobile/config/app_images.dart';
import 'components/billing_screen.dart';
import 'components/personal_info_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with SingleTickerProviderStateMixin {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  TabController? tabController;
  late SharedPreferences prefs;

  void GetProfile () async{
    prefs = await SharedPreferences.getInstance();
    print(prefs.getString('name'));
  }

  @override
  void initState() {
    tabController = TabController(length: 5, vsync: this);
    super.initState();
    GetProfile();
  }

  @override
  void dispose() {
    super.dispose();
    tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: SvgPicture.asset(AppImages.eMedLogo),
        ),
        leadingWidth: 110.0,
        actions: [
          const CircleAvatar(
            radius: 14.0,
            backgroundImage: AssetImage(AppImages.doctorImage),
          ),
          const SizedBox(width: 8.0),
          const Center(
            child: Text('Lorem Arsh',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w700,
                color: AppColors.lightBlack,
              ),
            ),
          ),
          menuButton(),
        ],
      ),
      endDrawer: DoctorDrawer(),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Text('Settings',
              style: TextStyle(
                fontSize: 25.0,
                color: AppColors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          TabBar(
            controller: tabController,
            isScrollable: true,
            indicatorColor: AppColors.redColor,
            labelColor: AppColors.black,
            unselectedLabelColor: AppColors.secondary,
            tabs: const [
              Tab(
                text: 'Personal Info',
              ),
              Tab(
                text: 'Billing',
              ),
              Tab(
                text: 'Profile',
              ),
              Tab(
                text: 'Specialities',
              ),
              Tab(
                text: 'Locations',
              ),
            ],
          ),

          ///
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: const [
                PersonalInfoScreen(),
                BillingScreen(),
                SProfileScreen(),
                SpecialitiesScreen(),
                LocationsScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget menuButton() => TextButton(
    onPressed: (){
      _scaffoldKey.currentState!.openEndDrawer();
    },
    child: const Icon(Icons.menu, color: AppColors.black, size: 28.0),
  );
}
