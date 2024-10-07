import 'package:contacts/Model/contact_model.dart';
import 'package:contacts/cubit/contact_cubit.dart';
// import 'package:contacts/cubit/contact_cubit.dart';
import 'package:contacts/screens/add_screen.dart';
import 'package:contacts/screens/home_screen.dart';
import 'package:contacts/widgets/card_view.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:device_preview/device_preview.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ContactModelAdapter());
  final contactBox = await Hive.openBox<ContactModel>("contactbox");
  print('Box opened: ${contactBox.isOpen}');
  // Use 'contactbox' everywhere

  runApp(
    MyApp(contactBox: contactBox),
    // DevicePreview(
    //   enabled: !kReleaseMode,
    //   builder: (context) =>
    // ),
  );
}

class MyApp extends StatelessWidget {
  final Box<ContactModel>? contactBox;

  const MyApp({super.key, required this.contactBox});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ContactCubit(contactBox ?? Hive.box<ContactModel>('contactbox')),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // locale: DevicePreview.locale(context),
        // builder: DevicePreview.appBuilder,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        home: const HomeScreen(),
        routes: {
          '/add_screen': (context) => AddScreen(),
          '/card_view': (context) => const CardView(),
        },
      ),
    );
  }
}
