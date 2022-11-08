// ignore_for_file: library_private_types_in_public_api, prefer_typing_uninitialized_variables, empty_catches, use_build_context_synchronously

import 'dart:async';
import 'dart:io';

import 'package:tictactoe/Helper/color.dart';
import 'package:tictactoe/Helper/constant.dart';
import 'package:tictactoe/Helper/string.dart';
import 'package:tictactoe/Helper/utils.dart';
import 'package:tictactoe/functions/dialoges.dart';
import 'package:tictactoe/functions/getCoin.dart';
import 'package:tictactoe/functions/playbgm.dart';
import 'package:tictactoe/main.dart';
import 'package:tictactoe/screens/how_to_play.dart';
import 'package:tictactoe/screens/login_with_email.dart';
import 'package:tictactoe/screens/moreGamesListing.dart';

import 'package:tictactoe/screens/privacy_policy.dart';
import 'package:tictactoe/widgets/alertDialoge.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'gamehistory.dart';
import 'splash.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<Profile> {
  int? coin = 0;
  int? matchPlayedCount = 0;
  int? score = 0;
  int? matchWon = 0;
  int? selectedLanguage;
  bool sound = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final InAppReview _inAppReview = InAppReview.instance;
  Utils localValue = Utils();
  late String platform;
  String profilePic = guestProfilePic, username = "", name = "";

  List<String?> languageList = [];
  var imageFile;
  File? _imageFile;
  final picker = ImagePicker();
  bool isLoading = false;
  final _nameFieldKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      platform = "Android";
    }
    if (Platform.isIOS) {
      platform = "IOS";
    }
    getSound();
    getFieldValue("matchplayed", (e) => matchPlayedCount = e,
        (e) => matchPlayedCount = e);
    getFieldValue("coin", (e) => coin = e, (e) => coin = e);
    getFieldValue("score", (e) => score = e, (e) => score = e);
    getFieldValue("matchwon", (e) => matchWon = e, (e) => matchWon = e);
    getFieldValue("profilePic", (e) => profilePic = e, (e) => profilePic = e);
    getFieldValue("username", (e) => username = e, (e) => username = e);

    Future.delayed(Duration.zero, () {
      _getLanguageList();

      _getSavedLanguage();
    });
  }

  getFieldValue(
    String fieldName,
    void Function(dynamic count) callback,
    void Function(dynamic count) update,
  ) async {
    var init;
    try {
      var ins = GetUserInfo();
      init = await (await ins.getFieldValue(fieldName));
      if (mounted) {
        setState(() {
          callback(init);
        });
      }

      await ins.detectChange(fieldName, (val) {
        if (mounted) {
          if (isLoading) {
            isLoading = false;
          }
          setState(() {
            update(val);
          });
        }
      });
    } catch (err) {}
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _openStoreListing() => _inAppReview.openStoreListing(
        appStoreId: appStoreId,
        microsoftStoreId: 'microsoftStoreId',
      );

  @override
  Widget build(BuildContext context) {
    _getLanguageList();
    var height = MediaQuery.of(context).padding.top;
    return WillPopScope(
        onWillPop: () async {
          music.play(click);
          return Future.value(true);
        },
        child: Scaffold(
          body: Stack(
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      Container(
                          height: MediaQuery.of(context).size.height / 4.5,
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    secondaryColor,
                                    primaryColor,
                                  ]),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(40),
                                  bottomRight: Radius.circular(40)))),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: height + 10),
                              child: Text("${utils.limitChar(username)}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                          color: white,
                                          fontWeight: FontWeight.bold)),
                            ),
                            Text(
                                _auth.currentUser!.email == null
                                    ? ""
                                    : "${_auth.currentUser!.email}",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(color: white)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/coin_symbol.png",
                                ),
                                Text(
                                  "  $coin",
                                  style: const TextStyle(color: white),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Positioned.directional(
                          textDirection: Directionality.of(context),
                          top: height + 3,
                          start: 3,
                          child: IconButton(
                            onPressed: () {
                              music.play(click);
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              color: white,
                              size: 25,
                            ),
                          )),
                      Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * .22 - 55),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "$matchPlayedCount",
                                    style: const TextStyle(color: white),
                                  ),
                                  Text(
                                    utils.getTranslated(context, "matchPlayed"),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "$matchWon",
                                    style: const TextStyle(color: white),
                                  ),
                                  Text(
                                    utils.getTranslated(context, "matchWonLbl"),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: ListView(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                                // margin: EdgeInsets.only(top: 10),
                                padding: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(
                                    color: white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    InkWell(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                      onTap: () async {
                                        changeValue(true);
                                        music.play(click);
                                        setState(() {
                                          sound = true;
                                        });
                                        if (Music.status != null &&
                                            Music.status == "playing") {
                                        } else {
                                          await music.play(backMusic);
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        decoration: BoxDecoration(
                                            color: sound ? primaryColor : white,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20))),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            getSvgImage(
                                                imageName: 'soundon_dark',
                                                imageColor: sound
                                                    ? white
                                                    : primaryColor,
                                                height: 10,
                                                width: 10),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                utils.getTranslated(
                                                    context, "soundOn"),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption!
                                                    .copyWith(
                                                        color: sound
                                                            ? white
                                                            : primaryColor),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        decoration: BoxDecoration(
                                            color: sound ? white : primaryColor,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20))),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            getSvgImage(
                                                imageName: 'soundoff_dark',
                                                imageColor: sound
                                                    ? primaryColor
                                                    : white,
                                                height: 10,
                                                width: 10),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                utils.getTranslated(
                                                    context, "soundOff"),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption!
                                                    .copyWith(
                                                        color: sound
                                                            ? primaryColor
                                                            : white),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      onTap: () async {
                                        if (Music.status != null &&
                                            Music.status == "playing") {
                                          await music.stop();
                                        }
                                        changeValue(false);
                                        setState(() {
                                          sound = false;
                                        });
                                      },
                                    ),
                                  ],
                                )),
                          ),
                          getTile(utils.getTranslated(context, "history"),
                              "history_icon", true),
                          if (!_auth.currentUser!.isAnonymous) ...[
                            getTile(utils.getTranslated(context, "shop"),
                                "shop_icon", true),
                            getTile(utils.getTranslated(context, "skin"),
                                "skin_icon", true),
                          ],
                          if (_auth.currentUser!.isAnonymous) ...[
                            InkWell(
                              onTap: () async {
                                music.play(click);
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            const LoginWithEmail()));
                              },
                              child: ListTile(
                                leading: const Icon(
                                  Icons.login,
                                  color: primaryColor,
                                  size: 22,
                                ),
                                title: Text(
                                  utils.getTranslated(context, "signInNow"),
                                  style: const TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                          getTile(
                              utils.getTranslated(context, "changeLanguage"),
                              "language_icon",
                              true),
                          getTile(utils.getTranslated(context, "playMoreGames"),
                              "", false),
                          getTile(utils.getTranslated(context, "contactUs"),
                              "contactus_icon", true),
                          getTile(utils.getTranslated(context, "aboutUs"),
                              "aboutus_icon", true),
                          getTile(utils.getTranslated(context, "termCond"),
                              "termscond_icon", true),
                          getTile(utils.getTranslated(context, "privacy"),
                              "privacypolicy_icon", true),
                          getTile(
                              utils.getTranslated(context, "howToPlayHeading"),
                              "help_icon",
                              true),
                          getTile(utils.getTranslated(context, "rate"),
                              "rateus_icon", true),
                          getTile(utils.getTranslated(context, "share"),
                              "share_app", true),
                          getTile(utils.getTranslated(context, "logout"),
                              "logout_icon", true),
                          getTile(utils.getTranslated(context, "deleteAccount"),
                              "delete_user", true),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * .22 - 50,
                left: MediaQuery.of(context).size.width / 2.5,
                child: GestureDetector(
                  onTap: () {
                    if (!_auth.currentUser!.isAnonymous) {
                      openEditProfileBottomSheet();
                    }
                  },
                  child: Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          backgroundColor: primaryColor,
                          radius: 40,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(profilePic),
                            radius: 35,
                          ),
                        ),
                        _auth.currentUser!.isAnonymous
                            ? Container()
                            : Positioned.directional(
                                textDirection: Directionality.of(context),
                                bottom: 8,
                                end: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(2.0),
                                  decoration: BoxDecoration(
                                      color: grey,
                                      borderRadius:
                                          BorderRadius.circular(50.0)),
                                  child: const Icon(
                                    Icons.edit,
                                    size: 20,
                                    color: primaryColor,
                                  ),
                                ))
                      ],
                    ),
                  ),
                ),
              ),
              utils.showCircularProgress(isLoading, secondarySelectedColor),
            ],
          ),
        ));
  }

  _imgFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = File(pickedFile!.path);
    });

    uploadImageToFirebase(context);
    Navigator.pop(context);
  }

  void changeUserNameInFirebase() async {
    Navigator.of(context).pop();
    final form = _nameFieldKey.currentState!;
    form.save();
    if (form.validate()) {
      var ins = GetUserInfo();
      await ins.setUsername(name);
    }
  }

  Future uploadImageToFirebase(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    var fileName = _imageFile!.path.split('/').last;

    var ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('userProfiles')
        .child('/$fileName');

    final metadata = firebase_storage.SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': fileName});
    firebase_storage.UploadTask uploadTask;
    uploadTask = ref.putFile(File(_imageFile!.path), metadata);

    await Future.value(uploadTask).then((value) async {
      var data = await value.ref.getDownloadURL();
      var ins = GetUserInfo();
      await ins.setProfilePic(data);

      utils.setSnackbar(
          context, utils.getTranslated(context, "ProfileUpdatedSuccessfully"));
      setState(() {
        isLoading = false;
      });
    }).onError((error, stackTrace) {
      if (mounted) {
        utils.setSnackbar(
            context, utils.getTranslated(context, "SomethingWentWrong"));
      }

      setState(() {
        isLoading = false;
      });
    });
  }

  changeValue(bool val) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setBool("${appName}SFX-ENABLED", val);
  }

  getTile(String title, String img, bool isSVGImage) {
    return ListTile(
      leading: title != utils.getTranslated(context, 'playMoreGames')
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                isSVGImage
                    ? getSvgImage(
                        imageName: img,
                      )
                    : Image.asset('assets/images/$img.png')
              ],
            )
          : const Icon(
              Icons.games,
              color: primaryColor,
              size: 20,
            ),
      title: Text(
        title,
        style:
            const TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
      ),
      onTap: () async {
        try {
          music.play(click);

          if (title == utils.getTranslated(context, "history")) {
            await InternetAddress.lookup('google.com');
            Navigator.of(context).push(
              CupertinoPageRoute(
                  builder: (context) {
                    return GameHistory();
                  },
                  fullscreenDialog: true),
            );
          } else if (title == utils.getTranslated(context, "shop")) {
            await InternetAddress.lookup('google.com');
            Navigator.pushNamed(context, "/shop");
          } else if (title == utils.getTranslated(context, "skin")) {
            await InternetAddress.lookup('google.com');
            Navigator.of(context).pushNamed("/skin");
          }
        } on SocketException catch (_) {
          var dialog = Dialoge();
          dialog.error(context);
        }
        if (title == utils.getTranslated(context, "aboutUs")) {
          music.play(click);
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => PrivacyPolicy(
                        title: utils.getTranslated(context, "aboutUs"),
                      )));
        } else if (title == utils.getTranslated(context, "playMoreGames")) {
          music.play(click);
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => const MoreGamesListing()));
        } else if (title == utils.getTranslated(context, "contactUs")) {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => PrivacyPolicy(
                        title: utils.getTranslated(context, "contactUs"),
                      )));
        } else if (title == utils.getTranslated(context, "termCond")) {
          music.play(click);
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => PrivacyPolicy(
                        title: utils.getTranslated(context, "termCond"),
                      )));
        } else if (title == utils.getTranslated(context, "privacy")) {
          music.play(click);
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => PrivacyPolicy(
                        title: utils.getTranslated(context, "privacy"),
                      )));
        } else if (title == utils.getTranslated(context, "howToPlayHeading")) {
          music.play(click);
          Navigator.push(context,
              CupertinoPageRoute(builder: (context) => const HowToPlay()));
        } else if (title == utils.getTranslated(context, "rate")) {
          _openStoreListing();
        } else if (title == utils.getTranslated(context, "share")) {
          var str =
              "$appName\n\n$appFind$androidLink$packageName\n\n iOS:\n$iosLink$iosPackage";

          Share.share(str);
        } else if (title == utils.getTranslated(context, "logout")) {
          showDialog(
              context: context,
              builder: (context) {
                var color = secondaryColor;

                return Alert(
                  title: Text(
                    utils.getTranslated(context, "logout"),
                    style: const TextStyle(color: white),
                  ),
                  isMultipleAction: true,
                  defaultActionButtonName: utils.getTranslated(context, "ok"),
                  onTapActionButton: () {},
                  content: Text(
                    utils.getTranslated(context, "areYouSure"),
                    style: const TextStyle(color: white),
                  ),
                  multipleAction: [
                    TextButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(color)),
                        onPressed: () async {
                          var userID = FirebaseAuth.instance.currentUser!.uid;
                          if (FirebaseAuth.instance.currentUser!.isAnonymous) {
                            Dialoge.removeChild("users", userID);
                          }

                          localValue.setSkinValue("user_skin", "");
                          localValue.setSkinValue("opponent_skin", "");
                          await utils.setUserLoggedIn("isLoggedIn", false);

                          await utils.getUserLoggedIn("isLoggedIn");

                          await FirebaseAuth.instance.signOut();

                          await GoogleSignIn().signOut();

                          music.play(click);

                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/authscreen', (Route<dynamic> route) => false);
                        },
                        child: Text(utils.getTranslated(context, "yes"),
                            style: const TextStyle(color: white))),
                    TextButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(color)),
                        onPressed: () async {
                          music.play(click);

                          Navigator.pop(context);
                        },
                        child: Text(utils.getTranslated(context, "no"),
                            style: const TextStyle(color: white)))
                  ],
                );
              });
        } else if (title == utils.getTranslated(context, 'changeLanguage')) {
          openChangeLanguageBottomSheet();
        } else if (title == utils.getTranslated(context, 'deleteAccount')) {
          deleteAccount(context);
        }
        // }
      },
    );
  }

  Future<void> getSound() async {
    sound = await (utils.getSfxValue());
    setState(() {});
  }

  _getSavedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String getlanguage = prefs.getString(LAGUAGE_CODE) ?? "";

    selectedLanguage = langCode.indexOf(getlanguage == "" ? "fr" : getlanguage);

    if (mounted) setState(() {});
  }

  void _changeLan(String language, BuildContext ctx) async {
    Locale locale = await utils.setLocale(language);
    MyApp.setLocale(ctx, locale);
  }

  void openChangeLanguageBottomSheet() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0))),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Wrap(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Form(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      bottomSheetHandle(),
                      bottomsheetLabel("changeLanguage"),
                      StatefulBuilder(
                        builder:
                            (BuildContext context, StateSetter setModalState) {
                          return SingleChildScrollView(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: getLngList(context, setModalState)),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

  void openEditProfileBottomSheet() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0))),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Wrap(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Form(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      bottomSheetHandle(),
                      bottomsheetLabel("editProfile"),
                      StatefulBuilder(
                        builder:
                            (BuildContext context, StateSetter setModalState) {
                          return SingleChildScrollView(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: _imgFromGallery,
                                    child: Center(
                                      child: Stack(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: primaryColor,
                                            radius: 40,
                                            child: CircleAvatar(
                                              backgroundImage:
                                                  NetworkImage(profilePic),
                                              radius: 39,
                                            ),
                                          ),
                                          Positioned.directional(
                                              textDirection:
                                                  Directionality.of(context),
                                              bottom: 0,
                                              end: 0,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                decoration: BoxDecoration(
                                                    color: grey,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50.0)),
                                                child: const Icon(
                                                  Icons.edit,
                                                  size: 20,
                                                  color: primaryColor,
                                                ),
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: TextFormField(
                                      key: _nameFieldKey,
                                      keyboardType: TextInputType.text,
                                      style: const TextStyle(
                                        color: primaryColor,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      textInputAction: TextInputAction.next,
                                      initialValue: username,
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return utils.getTranslated(
                                              context, "usernameRequired");
                                        }
                                        return null;
                                      },
                                      onSaved: (String? value) {
                                        name = value ?? username;
                                      },
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(
                                          Icons.account_circle_outlined,
                                          color: primaryColor,
                                          size: 20,
                                        ),
                                        hintText: utils.getTranslated(
                                            context, "username"),
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(
                                                color: primaryColor,
                                                fontWeight: FontWeight.normal),
                                        filled: true,
                                        fillColor: white,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 5,
                                        ),
                                        prefixIconConstraints:
                                            const BoxConstraints(
                                          minWidth: 40,
                                          maxHeight: 20,
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(7.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                        bottom: 20.0, end: 20.0, start: 20.0),
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    primaryColor)),
                                        onPressed: changeUserNameInFirebase,
                                        child: Text(
                                          utils.getTranslated(context, "save"),
                                          style: const TextStyle(color: white),
                                        )),
                                  )
                                ]),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

  List<Widget> getLngList(BuildContext ctx, StateSetter setModalState) {
    return languageList
        .asMap()
        .map(
          (index, element) => MapEntry(
              index,
              InkWell(
                onTap: () {
                  if (mounted) {
                    selectedLanguage = index;
                    _changeLan(langCode[index], ctx);
                    setModalState(() {});
                    setState(() {});

                    Navigator.pop(context);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 25.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: selectedLanguage == index
                                    ? secondaryColor
                                    : white,
                                border: Border.all(color: secondaryColor)),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: selectedLanguage == index
                                  ? const Icon(
                                      Icons.check,
                                      size: 17.0,
                                      color: white,
                                    )
                                  : const Icon(
                                      Icons.check_box_outline_blank,
                                      size: 15.0,
                                      color: white,
                                    ),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsetsDirectional.only(
                                start: 15.0,
                              ),
                              child: Text(
                                languageList[index]!,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(color: primaryColor),
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              )),
        )
        .values
        .toList();
  }

  Widget bottomSheetHandle() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0), color: secondaryColor),
        height: 5,
        width: MediaQuery.of(context).size.width * 0.3,
      ),
    );
  }

  Widget bottomsheetLabel(String labelName) => Padding(
      padding: const EdgeInsets.only(top: 30.0, bottom: 20),
      child: Text(
        utils.getTranslated(context, labelName),
        style: Theme.of(context)
            .textTheme
            .headline6!
            .copyWith(fontWeight: FontWeight.bold),
      ));

  void _getLanguageList() {
    languageList = [
      utils.getTranslated(context, 'ENGLISH_LAN'),
      utils.getTranslated(context, 'FRENCH_LAN'),
      utils.getTranslated(context, 'SPANISH_LAN'),
      utils.getTranslated(context, 'HINDI_LAN'),
      utils.getTranslated(context, 'ARABIC_LAN'),
      utils.getTranslated(context, 'RUSSIAN_LAN'),
      utils.getTranslated(context, 'JAPANISE_LAN'),
      utils.getTranslated(context, 'GERMAN_LAN')
    ];
  }

  deleteAccount(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          var color = secondaryColor;

          return Alert(
            title: Text(
              utils.getTranslated(context, "deleteAccount"),
              style: const TextStyle(color: white),
            ),
            isMultipleAction: true,
            defaultActionButtonName: utils.getTranslated(context, "ok"),
            onTapActionButton: () {},
            content: Text(
              utils.getTranslated(context, "areYouSure"),
              style: const TextStyle(color: white),
            ),
            multipleAction: [
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(color)),
                  onPressed: () async {
                    music.play(click);
                    try {
                      var currentUser = FirebaseAuth.instance.currentUser!;

                      await currentUser.delete().then((value) {
                        utils.setSnackbar(
                            context,
                            utils.getTranslated(
                                context, 'accountDeletedSuccess'));
                      });
                      localValue.setSkinValue("user_skin", "");
                      localValue.setSkinValue("opponent_skin", "");
                      await utils.setUserLoggedIn("isLoggedIn", false);

                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/authscreen', (Route<dynamic> route) => false);
                    } catch (e) {
                      Navigator.pop(context);
                      if (e
                          .toString()
                          .contains('firebase_auth/requires-recent-login')) {
                        utils.setSnackbar(
                            context,
                            utils.getTranslated(
                                context, 'loginAgainToDeleteAccount'));
                      }
                    }
                  },
                  child: Text(utils.getTranslated(context, "yes"),
                      style: const TextStyle(color: white))),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(color)),
                  onPressed: () async {
                    music.play(click);

                    Navigator.pop(context);
                  },
                  child: Text(utils.getTranslated(context, "no"),
                      style: const TextStyle(color: white)))
            ],
          );
        });
  }
}
