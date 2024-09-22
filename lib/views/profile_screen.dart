import 'package:e_commerce_app/constants/color-codes.dart';
import 'package:e_commerce_app/controllers/auth_controller.dart';
import 'package:e_commerce_app/views/components/custom_button.dart';
import 'package:e_commerce_app/views/components/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCodes.primaryBg,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.arrow_back,color: Colors.black,size: 20,),
                      ),
                    ),

                    Text(
                      "profile",
                      style: FontManager.getTextStyle(context,
                          fontSize: 20,
                          // color: Colors.black,
                          lWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                FutureBuilder(
                  future: profileRow(context),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data ?? Container();
                    } else {
                      return Container();
                    }
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                const Divider(
                  indent: 10,
                  endIndent: 10,
                  // color: ColorCodes.black.withOpacity(0.1),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Settings",
                  style: FontManager.getTextStyle(context,
                      fontSize: 20,
                      color: Colors.black,
                      lWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 20,
                ),
                settingsRow(
                  context,
                  Icons.person_2_outlined,
                  "personalInformation",
                  () {
                    // Get.toNamed(RouteManagement.personalInformation);
                  },
                ),
                settingsRow(
                  context,
                  Icons.favorite_border_outlined,
                  "favourites",
                  () {},
                ),
                settingsRow(
                  context,
                  Icons.notifications_none_outlined,
                  "notifications",
                  () {},
                  // image: 'assets/images/home/profile.svg'
                ),
                settingsRow(
                  context,
                  Icons.help_outline,
                  "helpCenter",
                  () {},
                  // image: 'assets/images/home/profile.svg'
                ),
                settingsRow(
                  context,
                  Icons.language,
                  "language",
                  () {
                    // language(context);
                  },
                ),
                const Spacer(),
                Center(
                  child: InkWell(
                    onTap: () async {
                      await Provider.of<AuthProvider>(context, listen: false)
                          .logout();
                      
                      Navigator.pushNamed(context, "/login");
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: ColorCodes.primaryButtonBg,
                          border:
                              Border.all(color: ColorCodes.greyBr, width: 2),
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 50),
                      child: Text(
                        "Logout",
                        style: FontManager.getTextStyle(context,
                            fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<Widget> profileRow(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userName = prefs.getString("name");
    return Row(
      children: [
        CircleAvatar(
          radius: 35,
          child: Container(
            width: 150.0,
            height: 150.0,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                'assets/images/profile_photo.png',
                height: 150,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userName!,
              style: FontManager.getTextStyle(context,
                  fontSize: 16, color: Colors.black, lWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "showProfile",
              style: FontManager.getTextStyle(context,
                  fontSize: 14, color: Colors.grey, lWeight: FontWeight.w400),
            ),
          ],
        ),
        const Spacer(),
        IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_forward_ios_outlined,
                size: 15, color: Colors.black))
      ],
    );
  }

  Widget settingsRow(
    context,
    icon,
    text,
    onTap, {
    String? image,
  }) {
    return InkWell(
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      onTap: onTap,
      child: Column(
        children: [
          Row(
            children: [
              image == null
                  ? Icon(
                      icon,
                    )
                  : Image.asset(image),
              const SizedBox(
                width: 15,
              ),
              Text(
                text,
                style: FontManager.getTextStyle(context,
                    fontSize: 16,
                    color: Colors.black,
                    lWeight: FontWeight.w500),
              ),
              const Spacer(),
              const IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 15,
                    color: ColorCodes.black,
                  ))
            ],
          ),
          // const SizedBox(
          //   height: 10,
          // ),
          Divider(
            indent: 0,
            endIndent: 20,
            color: ColorCodes.black.withOpacity(0.1),
          ),
        ],
      ),
    );
  }
}
