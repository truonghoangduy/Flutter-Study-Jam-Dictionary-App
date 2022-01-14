import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_study_jam/config/themes/app_colors.dart';
import 'package:flutter_study_jam/page/dictionary/model.dart';
import 'package:flutter_study_jam/page/dictionary/services/api_service.dart';
import 'package:flutter_study_jam/page/dictionary/widget/content_search.dart';
import 'package:flutter_study_jam/page/dictionary/widget/drawer_widget.dart';
import 'package:flutter_study_jam/page/dictionary/widget/keyword_search.dart';
import "package:flutter_study_jam/Services/firebase_auth.dart";
import 'package:flutter_study_jam/page/dictionary/widget/search_input.dart';

class DictionaryPage extends StatefulWidget {
  const DictionaryPage({Key? key}) : super(key: key);

  @override
  _DictionaryPageState createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> {
  // User? loggedinUser;
  // Future<User?> user = FirebaseAuthService.getCurrentUser();

  void initState() {
    super.initState();
    // getCurrentUser();
    // getCurrentUser();
  }

  //using this function you can use the credentials of the user
  // void getCurrentUser() async {
  //   try {
  //     final user = await FirebaseAuthService.getCurrentUser();
  //     if (user != null) {
  //       loggedinUser = user;
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // void logout() {
  //   _auth.signOut();
  //   Navigator.pop(context);
  //   //Navigator.pushNamed(context, "LoginPage");
  // }

  // the logout function
  void logout() async {
    await FirebaseAuthService.signOut();
    //Navigator.pop(context);
    Navigator.pushReplacementNamed(context, "LoginPage");
  }

  var sreachedText = "community";
  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;
    DateTime _lastExitTime = DateTime.now();
    return WillPopScope(
      onWillPop: () async {
        if (DateTime.now().difference(_lastExitTime) >= Duration(seconds: 2)) {
          //showing message to user
          const snack = SnackBar(
            content: Text("Press the back button again to exist the app"),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snack);
          _lastExitTime = DateTime.now();
          return false; // disable back press
        } else {
          return true; //  exit the app
        }
      },
      child: Scaffold(
        drawer: DrawerWidget(
          email: "aaa",
          //logout:,
          //logout: logout,
        ),
        appBar: AppBar(
          backgroundColor: AppColors.primaryBuleColor,
          title: const Text(
            'Dictionary',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SizedBox(
            height: mediaQuery.height,
            width: mediaQuery.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 28.h,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 27.w),
                    child: SearchInput(
                      onSubmit: (text) => {
                        setState(() {
                          sreachedText = text;
                        })
                      },
                    )),
                SizedBox(
                  height: 28.h,
                ),
                FutureBuilder<DictModel?>(
                    future: ApiService.getword(this.sreachedText),
                    builder: (context, snaphot) {
                      if (snaphot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (!snaphot.hasData) {
                        return const Center(child: Text("No Word found"));
                      }
                      final model = snaphot.data!;
                      final menaings = model.meanings!;
                      return Expanded(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30.w),
                              child: KeywordSearch(
                                  audioUrl: model.phonetics![0].audio!,
                                  keyWordSearch: model.word!,
                                  phonetic: model.phonetic!),
                            ),
                            SizedBox(
                              height: 38.h,
                            ),
                            Expanded(
                              child: Container(
                                color: Colors.white,
                                child: ListView.builder(
                                    itemCount: menaings.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 34.w),
                                        child: ContentSearch(
                                          wordDefinition:
                                              menaings[index].definitions!,
                                          attribute:
                                              menaings[index].partOfSpeech!,
                                        ),
                                      );
                                    }),
                              ),
                            ),
                            //
                          ],
                        ),
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
