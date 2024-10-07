import 'package:contacts/Model/contact_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class ContactDatabase {
  final _myBox =
      Hive.box<ContactModel>('contactbox'); // Use 'contactbox' everywhere

  void addContact(ContactModel contactmodel) {
    _myBox.add(contactmodel);
  }

  List<ContactModel> loadContact() {
    return _myBox.values.toList();
  }
}
