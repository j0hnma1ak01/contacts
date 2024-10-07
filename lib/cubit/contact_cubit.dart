import 'package:contacts/Model/contact_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class ContactCubit extends Cubit<List<ContactModel>> {
  final Box<ContactModel> _contactBox;

  // Constructor
  ContactCubit(this._contactBox) : super([]) {
    loadContact(); // Load contacts on initialization
  }
// Load contacts from Hive when the cubit is initialized
  void loadContact() {
    print('Loading contacts...');
    if (_contactBox.isNotEmpty) {
      final contacts = _contactBox.values.toList();
      emit(contacts);
      print('Loaded contacts from Hive: $contacts');
    } else {
      print('No contacts found in the box');
    }
  }

  void addContact(String name, String phoneNo, String email) {
    print('Adding contact...');
    final newContact = ContactModel(name: name, phoneNo: phoneNo, email: email);
    _contactBox.add(newContact);
    print(
        'Contact added to Hive: ${_contactBox.getAt(_contactBox.length - 1)}');
    emit([...state, newContact]);
  }

  // Update an existing contact by index
  void updateContact(int index, ContactModel updatedContact) {
    _contactBox.putAt(index, updatedContact); // Update Hive data
    final updatedList = [...state];
    updatedList[index] = updatedContact; // Update the local state
    emit(updatedList);
  }

  // Delete a contact by index
  void deleteContact(int index) {
    _contactBox.deleteAt(index); // Delete from Hive
    emit([...state]..removeAt(index)); // Update the UI by emitting new state
  }
}
