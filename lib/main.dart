import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layouts/cubit/cubit.dart';
import 'package:social_app/layouts/cubit/states.dart';
import 'package:social_app/layouts/home_layout.dart';
import 'package:social_app/modules/login/login_screen.dart';
import 'package:social_app/shared/bloc_observer.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('notification on background : ' + message.data.toString());
  showToast(msg: 'onBackgroundMessage', color: Colors.green);
}
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp();
  var token = await FirebaseMessaging.instance.getToken();
  print("Token : " + token);
  
  FirebaseMessaging.onMessage.listen((event) {
    print('notification : ' + event.data.toString());
    showToast(msg: 'onMessage', color: Colors.green);
  });
  
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('notification opened : ' + event.data.toString());
    showToast(msg: 'onMessageOpenedApp', color: Colors.green);
  });
  
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await CacheHelper.init();
  uId = CacheHelper.getData(key: 'uId');
  Widget widget;
  if(uId != null){
    widget = HomeLayout();
  }else{
    widget = LoginScreen();
  }
  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  Widget widget;
  MyApp(this.widget);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getUserData()..getPosts(),
      child: BlocConsumer<HomeCubit,HomeStates>(
        listener:(context, state) {},
        builder: (context, state) {
          return  MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Social App',
            theme: ThemeData(
                scaffoldBackgroundColor: Colors.white,
                primarySwatch: Colors.deepPurple,
                accentColor: Colors.deepPurpleAccent,
                appBarTheme: AppBarTheme(
                    backwardsCompatibility: false,
                    backgroundColor: Colors.white,
                    elevation: 0,
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.white,
                      statusBarIconBrightness: Brightness.dark,
                    )),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  selectedItemColor: Colors.deepPurple,
                  unselectedItemColor: Colors.grey,
                  type: BottomNavigationBarType.fixed,
                )
            ),

            home: widget,
          );
        },
      ),
    );
  }
}
