import 'package:flutter_weather/commom_import.dart';

class GiftPage extends StatefulWidget {
  final Function openDrawer;

  GiftPage({@required this.openDrawer});

  @override
  State createState() => GiftState(openDrawer: openDrawer);
}

class GiftState extends PageState<GiftPage> {
  final Function openDrawer;

  GiftState({@required this.openDrawer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scafKey,
      appBar: CustomAppBar(
        showShadowLine: false,
        title: Text(
          AppText.of(context).gift,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        color: AppColor.colorMain,
        leftBtn: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: openDrawer,
        ),
      ),
      body: DefaultTabController(
        length: 6,
        child: Container(
          color: AppColor.colorMain,
          child: Column(
            children: <Widget>[
              TabBar(
                labelColor: Colors.white,
                indicatorColor: Colors.white,
                isScrollable: true,
                tabs: [
                  Tab(text: AppText.of(context).mostHot),
                  Tab(text: AppText.of(context).sexGirl),
                  Tab(text: AppText.of(context).japanGirl),
                  Tab(text: AppText.of(context).taiwanGirl),
                  Tab(text: AppText.of(context).beachGirl),
                  Tab(text: AppText.of(context).selfGirl),
                ],
              ),
              Container(height: 1, color: AppColor.colorShadow),
              Expanded(
                child: Container(
                  color: AppColor.colorRead,
                  child: TabBarView(
                    children: [
                      GiftMziPage(typeUrl: "hot"),
                      GiftMziPage(typeUrl: "xinggan"),
                      GiftMziPage(typeUrl: "japan"),
                      GiftMziPage(typeUrl: "taiwan"),
                      GiftMziPage(typeUrl: "mm"),
                      GiftMziPage(typeUrl: "share"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
