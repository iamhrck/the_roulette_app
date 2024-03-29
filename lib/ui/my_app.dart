import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:the_roulette_app/ui/components/app_bar.dart';
import 'package:the_roulette_app/shared/constants/strings.dart';
import 'package:the_roulette_app/shared/router/app_router.dart';
import 'package:device_preview/device_preview.dart';
import 'package:the_roulette_app/ui/screen/entry/entry_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    if (kReleaseMode) {
      return _buildMyApp();
    } else {
      return _buildDebugMyApp(context);
    }
  }

  Widget _buildMyApp() {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      onGenerateRoute: AppRouter.generateRoute,
      home: const EntryScreen(),
    );
  }

  Widget _buildDebugMyApp(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Flutter Debug Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      onGenerateRoute: AppRouter.generateRoute,
      home: const EntryScreen(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: Strings.appTitle),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, AppRouter.setup);
                },
                child: const Text(
                  'Start',
                  style: TextStyle(fontSize: 20),
                ))
          ],
        ),
      ),
    );
  }
}
