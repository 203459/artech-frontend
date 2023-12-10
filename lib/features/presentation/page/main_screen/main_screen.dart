import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:proyecto_c2/features/presentation/page/activity/activity_page.dart';
import 'package:proyecto_c2/features/presentation/page/post/upload_post_page.dart';
import 'package:proyecto_c2/features/presentation/page/profile/profile_page.dart';
import 'package:proyecto_c2/features/presentation/page/search/search_page.dart';
import '../../../../consts.dart';
import '../../cubit/user/get_single_user/get_single_user_cubit.dart';
import '../home/home_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainScreen extends StatefulWidget {
  final String uid;

  const MainScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  late PageController pageController;

  List<bool> isSelected = [true, false, false, false]; // Lista de estados de íconos

  @override
  void initState() {
    BlocProvider.of<GetSingleUserCubit>(context).getSingleUser(uid: widget.uid);
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void navigationTapped(int index) {
    pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
      isSelected = List.generate(5, (i) => i == index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
      builder: (context, getSingleUserState) {
        if (getSingleUserState is GetSingleUserLoaded) {
          final currentUser = getSingleUserState.user;
          return Scaffold(
            backgroundColor: backGroundColor,
            bottomNavigationBar: Container(
              height: 70.0,
              child: CupertinoTabBar(
                backgroundColor: Color(0xFFAA5EB7),
                items: [
                  _buildTabBarItem('assets/home_page_unpressed.svg', 'assets/home_page_pressed.svg', 0),
                  _buildTabBarItem('assets/chat_page_unpressed.svg', 'assets/chat_page_pressed.svg', 1),
                  _buildTabBarItem('assets/notification_page_unpressed.svg', 'assets/notification_page_pressed.svg', 2),
                  _buildTabBarItem('assets/profile_page_unpressed.svg', 'assets/profile_page_pressed.svg', 3),
                ],
                onTap: navigationTapped,
              ),
            ),
            body: PageView(
              controller: pageController,
              children: [
                HomePage(),
                SearchPage(),
                //UploadPostPage(currentUser: currentUser),
                ActivityPage(),
                ProfilePage(
                  currentUser: currentUser,
                ),
              ],
              onPageChanged: onPageChanged,
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  BottomNavigationBarItem _buildTabBarItem(String normalIconPath, String pressedIconPath, int index) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        isSelected[index] ? pressedIconPath : normalIconPath,
        color: iconColor,
        width: 25.0,
        height: 27.0,
      )
    );
  }
}