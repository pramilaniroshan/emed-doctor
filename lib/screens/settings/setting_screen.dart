import 'package:emedassistantmobile/screens/settings/components/locations_screen.dart';
import 'package:emedassistantmobile/screens/settings/components/s_profile_screen.dart';
import 'package:emedassistantmobile/screens/settings/components/specialities_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

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

  @override
  void initState() {
    tabController = TabController(length: 5, vsync: this);
    super.initState();
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
      endDrawer: Drawer(
        backgroundColor: AppColors.white,
        elevation: 0.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 40.0),
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                onPressed: (){
                  Get.back();
                },
                icon: SvgPicture.asset(
                  AppImages.closeIcon,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            ListTile(
              onTap: (){},
              leading: Padding(
                padding: const EdgeInsets.only(top: 6.0, left: 12.0),
                child: SvgPicture.asset(
                  AppImages.supportIcon,
                  height: 13.0,
                  width: 13.0,
                  fit: BoxFit.scaleDown,
                  color: AppColors.secondary,
                ),
              ),
              title: const Align(
                alignment: Alignment(-1.3, 0),
                child: Text('Support',
                  style: TextStyle(
                    fontSize: 21.0,
                    color: AppColors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            ListTile(
              onTap: (){},
              leading: Padding(
                padding: const EdgeInsets.only(top: 6.0, left: 12.0),
                child: SvgPicture.asset(
                  AppImages.contactIcon,
                  height: 13.0,
                  width: 13.0,
                  fit: BoxFit.scaleDown,
                  color: AppColors.secondary,
                ),
              ),
              title: const Align(
                alignment: Alignment(-1.3, 0),
                child: Text('Contact',
                  style: TextStyle(
                    fontSize: 21.0,
                    color: AppColors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            ListTile(
              onTap: (){},
              leading: Padding(
                padding: const EdgeInsets.only(top: 6.0, left: 12.0),
                child: SvgPicture.asset(
                  AppImages.termsIcon,
                  height: 13.0,
                  width: 13.0,
                  fit: BoxFit.scaleDown,
                  color: AppColors.secondary,
                ),
              ),
              title: const Align(
                alignment: Alignment(-1.3, 0),
                child: Text('Terms',
                  style: TextStyle(
                    fontSize: 21.0,
                    color: AppColors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            ListTile(
              onTap: (){},
              leading: Padding(
                padding: const EdgeInsets.only(top: 6.0, left: 12.0),
                child: SvgPicture.asset(
                  AppImages.linkIcon,
                  height: 13.0,
                  width: 13.0,
                  fit: BoxFit.scaleDown,
                  color: AppColors.secondary,
                ),
              ),
              title: const Align(
                alignment: Alignment(-1.3, 0),
                child: Text('eMed.com',
                  style: TextStyle(
                    fontSize: 21.0,
                    color: AppColors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.06),
            ListTile(
              onTap: (){},
              leading: Padding(
                padding: const EdgeInsets.only(top: 6.0, left: 12.0),
                child: SvgPicture.asset(
                  AppImages.globeIcon,
                  height: 13.0,
                  width: 13.0,
                  fit: BoxFit.scaleDown,
                  color: AppColors.secondary,
                ),
              ),
              title: const Align(
                alignment: Alignment(-1.1, 0),
                child: Text('English',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: AppColors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              trailing: const Icon(Icons.keyboard_arrow_down_outlined, color: AppColors.black),
            ),
          ],
        ),
      ),

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
