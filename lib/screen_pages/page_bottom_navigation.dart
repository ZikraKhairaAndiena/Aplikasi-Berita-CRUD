
import 'package:flutter/material.dart';
import 'package:uas_zikra_2037/screen_pages/page_list_berita.dart';
import 'package:uas_zikra_2037/screen_pages/page_list_mahasiswa.dart';
import 'package:uas_zikra_2037/screen_pages/page_profile_user.dart';

import '../utils/cek_session.dart';


class PageBottomNavigationBar extends StatefulWidget {
  const PageBottomNavigationBar({Key? key});

  @override
  State<PageBottomNavigationBar> createState() =>
      _PageBottomNavigationBarState();
}

class _PageBottomNavigationBarState extends State<PageBottomNavigationBar>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  Color? containerColor;
  late SessionManager sessionManager;

  @override
  void initState() {
    super.initState();
    sessionManager = SessionManager();
    sessionManager.getSession();
    tabController = TabController(length: 3, vsync: this);
    containerColor = Colors.transparent;
    tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {
      containerColor = Colors.blue;
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          setState(() {
            containerColor = Colors.blue;
          });
        },
        child: TabBarView(
          controller: tabController,
          children: [
            // content
            PageListBerita(),
            PageUtama(),
            PageProfileUser()
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 20,
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: TabBar(
            controller: tabController,
            labelColor: Colors.cyan,
            tabs: const [
              Tab(
                text: "Berita",
                // icon: Icon(Icons.book_online),
              ),
              Tab(
                text: "Mahasiswa",
                // icon: Icon(Icons.group),
              ),
              Tab(
                text: "Profil",
                // icon: Icon(Icons.person),
              ),
            ],
          ),
        ),
      ),
    );
  }
}