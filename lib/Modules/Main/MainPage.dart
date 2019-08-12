
import 'package:flutter/material.dart';
import '../Conference/ConfercePage.dart';
import '../Contact/ContactPage.dart';
import '../Mine/MinePage.dart';

class MainPage extends StatefulWidget {

  static final String sName = "main";

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return content();
  }
}

class content extends State<MainPage> with SingleTickerProviderStateMixin {

  TabController _tabController ;

  var tabImages;
  var  _pageList ;
  var _tabIndex = 0 ;
  var appBarTitles = ['首页', '发现', '我的'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(length: 3, vsync: this) ;
    initData() ;
  }
  Text getTabTitle(int curIndex) {
    if (curIndex == _tabIndex) {
      return new Text(appBarTitles[curIndex],
          style: new TextStyle(fontSize: 14.0, color: const Color(0xff1296db)));
    } else {
      return new Text(appBarTitles[curIndex],
          style: new TextStyle(fontSize: 14.0, color: const Color(0xff515151)));
    }
  }

  Image getTabImage(path) {
    return new Image.asset(path, width: 24.0, height: 24.0);
  }

  void initData() {
    /*
     * 初始化选中和未选中的icon
     */
    tabImages = [
      [getTabImage('images/e11.png'), getTabImage('images/e11.png')],
      [getTabImage('images/e2_1.png'), getTabImage('images/e2_1.png')],
      [getTabImage('images/e3_1.png'), getTabImage('images/e3_1.png')]
    ];
    /*
     * 三个子界面
     */
    _pageList = [
       ConferencePage(),
       ContactPage(),
       MinePage(),
    ];
  }
  Image getTabIcon(int curIndex) {
    if (curIndex == _tabIndex) {
      return tabImages[curIndex][1];
    }
    return tabImages[curIndex][0];
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _tabController.dispose() ;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body:_pageList[_tabIndex],
      bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[

         BottomNavigationBarItem(
            icon: getTabIcon(0), title: getTabTitle(0)),
         BottomNavigationBarItem(
             icon: getTabIcon(1), title: getTabTitle(1)),
         BottomNavigationBarItem(
            icon: getTabIcon(2), title: getTabTitle(2)),

          ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _tabIndex,
        onTap: (index){

            setState(() {
              _tabIndex = index ;
            });
        },
      ),
    );
  }

}