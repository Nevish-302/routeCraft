import 'package:ai_travel_planner/features/travel/screen/Discover/DiscoverScreen.dart';
import 'package:ai_travel_planner/features/travel/screen/final/finalScreen.dart';
import 'package:ai_travel_planner/features/travel/screen/suggestions/SuggestionScreen.dart';
import 'package:ai_travel_planner/features/travel/screen/translate/translate.dart';
import 'package:ai_travel_planner/features/travel/screen/user/personality.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'features/travel/screen/home/homescreen.dart';
import 'features/travel/screen/home/widgets/voice_command_floating_button.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationMenuController());
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBarTheme(
          data: NavigationBarThemeData(
            labelTextStyle: MaterialStateProperty.resolveWith<TextStyle>(
              (Set<MaterialState> states) =>
                  states.contains(MaterialState.selected)
                      ? const TextStyle(color: Colors.white)
                      : const TextStyle(color: Colors.grey),
            ),
          ),
          child: NavigationBar(
              backgroundColor: Colors.black,
              indicatorColor: Colors.black,
              selectedIndex: controller.selectedIndex.value,
              onDestinationSelected: (index) =>
                  controller.selectedIndex.value = index,
              destinations: [
                NavigationDestination(
                    icon: Icon(Iconsax.home),
                    selectedIcon: Icon(
                      Iconsax.home5,
                      color: Colors.white,
                    ),
                    label: "Home"),
                NavigationDestination(
                    icon: Icon(Iconsax.translate),
                    selectedIcon: Icon(
                      Iconsax.translate,
                      color: Colors.white,
                    ),
                    label: "Translate"),
                NavigationDestination(
                    icon: Icon(Iconsax.location),
                    selectedIcon: Icon(
                      Iconsax.location5,
                      color: Colors.white,
                    ),
                    label: "Search"),
                NavigationDestination(
                  icon: Icon(Iconsax.profile_2user4),
                  selectedIcon: Icon(
                    Iconsax.profile_2user5,
                    color: Colors.white,
                  ),
                  label: "Profile",
                ),
              ]),
        ),
      ),

      ///We will have to wrap the body with the OBX so that it listens to the changes in the controller or navigation menu controller
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: VoiceCommandFloatingButton(),
    );
  }
}

class NavigationMenuController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final screens = [
    const HomeScreen(),
    const Translation(),
    const DiscoverScreen(),
    const SuggestionScreen(),
  ];
}

///So here we are not using the sad state because the sad state will redraw the whole screen and that is what we don't want because it will take resources if they ask so many widgets to be rebuilt. Instead of that we are using the get X controller and to be exact we are we are creating a class now called navigation menu controller which is extending or we can say inheriting the gate X controller so it'll be listening to the index.
///But how exactly will it be listening to the index of the navigation menu bar well for that they get its controller half the EOPS method that actually listens to the variable
///So what about changes that will be happening to the instance of that OBS variable in the car X controller will be listening to it
///Samina motive is not to use the sad state function so how are we exactly going to rebuild the screen well to do that we will wrap the navigation menu bar with the OB ex widget which comes under the getx controller
///OB ex message of Capex controller will rebuild the navigation bar and will be listening to the state changes
