import 'package:hive/hive.dart';

part 'contact_model.g.dart';

@HiveType(typeId: 0)
class ContactModel extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String phoneNo;
  @HiveField(2)
  final String? email;

  ContactModel({required this.name, required this.phoneNo, this.email});

  String getFirstCharacter() {
    return name[0]; // Access the first character directly
  }
}
