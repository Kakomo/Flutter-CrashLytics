import 'package:bytebank/screens/language_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart' show kDebugMode;

import 'components/theme.dart';



void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  if(kDebugMode){
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  }else{
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    FirebaseCrashlytics.instance.setUserIdentifier('alura123');
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  }

  runApp(ByteBank());
}

class LogObserver extends BlocObserver{
  @override
  void onChange(Cubit cubit, Change change) {
    print("${cubit.runtimeType}> $change");
    super.onChange(cubit, change);
  }
}

class ByteBank extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Bloc.observer = LogObserver();
    return MaterialApp(
      theme: bytebankTheme,
      home: LanguageScreen()

    );
  }
}



