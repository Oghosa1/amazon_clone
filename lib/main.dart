import 'dart:async';

import 'package:amazon_clone/admin/screens/admin_screen.dart';
import 'package:amazon_clone/screens/auth_screen.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:amazon_clone/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'common/global_variable.dart';
import 'services/auth_service.dart';
import 'router.dart';
import 'services/hello_services.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => UserProvider())],
      child: const MyApp()));
}

// void main() {
//   runApp(const ProviderScope(child: MyApp()));
// }

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  // userData() async {
  //   await authService.getUserData(context);
  // }

  @override
  void initState() {
    super.initState();
    // userData();
    authService.getUserData(context);
    // Use a Timer to initiate the keepServerAlive function every 10 minutes
    Timer.periodic(const Duration(minutes: 10), (Timer timer) {
      keepServerAlive(context: context);
    });
    // authService.startTokenValidityChecker(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Amazon Clone',
        // theme: ThemeData(primarySwatch: Colors.blue),
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: GlobalVariables.backgroundColor,
          colorScheme:
              const ColorScheme.light(primary: GlobalVariables.secondaryColor),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
          ),
        ),
        onGenerateRoute: (settings) => generateRoute(settings),
        home: Provider.of<UserProvider>(context).user.token.isNotEmpty
            ? Provider.of<UserProvider>(context).user.type == 'user'
                ? const BottomBar()
                : const AdminScreen()
            : const AuthScreen()
        // home: Builder(builder: (context) {
        //   return FutureBuilder(
        //     future: authService.getUserData(context),
        //     builder: (context, snapshot) {
        //       if (snapshot.connectionState == ConnectionState.done) {
        //         return Provider.of<UserProvider>(context).user.token.isNotEmpty
        //             ? const BottomBar()
        //         : const AuthScreen();
        //       }
        //       // return const AuthScreen();
        //       return const Center(child: CircularProgressIndicator());
        //     },
        //   );
        // }),
        );
  }
}



// home: Provider.of<UserProvider>(context).user.token.isNotEmpty
//           ? const BottomBar()
//           : const AuthScreen(),
