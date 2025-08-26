import 'package:doctor_demo/l10n/app_localizations.dart';
import 'package:doctor_demo/res/scroll_offset/scroll_offset.dart';
import 'package:doctor_demo/view/all_section_view/all_section_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dental Web',
      locale: const Locale('en'), // default language
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.ltr, // LTR lock
          child: child!,
        );
      },

      home: BlocProvider(
        create: (context) => DisplayOffset(ScrollOffset(scrollOffsetValue: 0)),
        child: const AllSectionView(),
      ),
    );
  }
}
