import 'package:contacts/Model/contact_model.dart';
import 'package:contacts/cubit/contact_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

// import 'package:provider/provider.dart';
class CardView extends StatefulWidget {
  final Box<ContactModel>? contactBox;
  const CardView({super.key, this.contactBox});

  @override
  State<CardView> createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: BlocBuilder<ContactCubit, List<ContactModel>>(
        builder: (context, contactList) {
          return ListView.builder(
            itemCount: contactList.length,
            itemBuilder: (context, index) {
              final contact = contactList[index]; // Get contact model data
              return Dismissible(
                key: Key(contact.name),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  context.read<ContactCubit>().deleteContact(index);
                },
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/add_screen'),
                  child: Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.blue,
                        child: Text(contact.getFirstCharacter()),
                      ),
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            contact.name, // Display name from ContactModel
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 3),
                          Text(contact.phoneNo), // Display phone number
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
