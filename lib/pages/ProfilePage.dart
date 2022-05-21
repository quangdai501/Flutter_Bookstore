import 'package:final_project/controllers/user_controller.dart';
import 'package:flutter/material.dart';
// import 'package:my_app/model/list_profile_section.dart';
import 'package:final_project/customs/CustomTextStyle.dart';
import 'package:final_project/customs/CustomSeparateBox.dart';
import 'package:get/get.dart';

import '../routes/app_routes.dart';
import 'UserInfo.dart';
import 'EditPassword.dart';
import 'HistoryPage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class ListProfileSection {
  String title;
  Color color;
  Widget widget;

  ListProfileSection(this.title, this.color, this.widget);
}

class _ProfilePageState extends State<ProfilePage> {
  List<ListProfileSection> listSection = [];
  final UserController c = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createListItem();
  }

  void createListItem() {
    listSection.add(
        createSection("Thông tin cá nhân", Colors.blue.shade800, UserInfo()));
    listSection.add(createSection(
        "Lịch sử mua hàng", Colors.black.withOpacity(0.8), HistoryPage()));
  }

  createSection(String title, Color color, Widget widget) {
    return ListProfileSection(title, color, widget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      resizeToAvoidBottomInset: true,
      body: Builder(builder: (context) {
        return Obx(() {
          if (!c.isLogin.value) {
            return Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 70,
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    ElevatedButton(
                        onPressed: () => Get.toNamed(AppRoutes.LOGIN),
                        child: const Text("Đăng nhập",
                            style: TextStyle(fontSize: 16))),
                  ],
                ));
          }
          return Stack(
            children: <Widget>[
              buildListView(),
              Container(
                height: 240,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
              ),
              Container(
                width: double.infinity,
                child: Text(
                  "Thông tin cá nhân",
                  textAlign: TextAlign.center,
                  style: CustomTextStyle.textFormFieldBold
                      .copyWith(color: Colors.white, fontSize: 24),
                ),
                margin: const EdgeInsets.only(top: 32),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: Container(),
                    flex: 10,
                  ),
                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        Card(
                            margin: const EdgeInsets.only(
                                top: 50, left: 16, right: 16),
                            color: Colors.white,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16))),
                            child: c.obx((state) => Column(
                                  children: <Widget>[
                                    const SizedBox(
                                      height: 70,
                                    ),
                                    Text(
                                      state!.name,
                                      style: CustomTextStyle.textFormFieldBlack
                                          .copyWith(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w900),
                                    ),
                                    Text(
                                      state.email,
                                      style: CustomTextStyle.textFormFieldMedium
                                          .copyWith(
                                              color: Colors.grey.shade700,
                                              fontSize: 14),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Container(
                                      height: 2,
                                      width: double.infinity,
                                      color: Colors.grey.shade200,
                                    ),
                                    buildListView()
                                  ],
                                ))),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey.shade400, width: 2),
                                shape: BoxShape.circle,
                                image: const DecorationImage(
                                    image: AssetImage("assets/images/user.png"),
                                    fit: BoxFit.contain)),
                            width: 100,
                            height: 100,
                          ),
                        ),
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: Obx(() {
                              if (c.isLogin.value) {
                                return ElevatedButton(
                                    onPressed: () => c.logout(),
                                    child: const Text("Đăng xuất",
                                        style: TextStyle(fontSize: 16)));
                              }
                              return Container();
                            })),
                      ],
                    ),
                    flex: 75,
                  ),
                  Expanded(
                    child: Container(),
                    flex: 05,
                  ),
                ],
              ),
            ],
          );
        });
      }),
    );
  }

  ListView buildListView() {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return createListViewItem(listSection[index]);
      },
      itemCount: listSection.length,
    );
  }

  createListViewItem(ListProfileSection listSection) {
    return Builder(builder: (context) {
      return InkWell(
        splashColor: Colors.teal.shade200,
        onTap: () {
          if (listSection.widget != null) {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => listSection.widget));
          }
        },
        child: Container(
          margin: const EdgeInsets.only(left: 16, right: 12),
          padding: const EdgeInsets.only(top: 12, bottom: 12),
          child: Row(
            children: <Widget>[
              // Image(
              //   image: AssetImage(listSection.icon),
              //   width: 20,
              //   height: 20,
              //   color: Colors.grey.shade500,
              // ),
              // const SizedBox(
              //   width: 12,
              // ),
              Text(
                listSection.title,
                style: CustomTextStyle.textFormFieldBold
                    .copyWith(color: Colors.grey.shade500),
              ),
              const Spacer(
                flex: 1,
              ),
              Icon(
                Icons.navigate_next,
                color: Colors.grey.shade500,
              )
            ],
          ),
        ),
      );
    });
  }
}
