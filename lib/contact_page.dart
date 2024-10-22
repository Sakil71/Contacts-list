import 'package:contacts_list/contacts.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  List<Contacts> contacts = List.empty(growable: true);

  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();

  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contact List',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                  hintText: 'Contact Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: contactController,
              keyboardType: TextInputType.number,
              maxLength: 11,
              decoration: const InputDecoration(
                  hintText: 'Contact Number',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () {
                      String name = nameController.text.trim();
                      String contact = contactController.text.trim();

                      if (name.isNotEmpty && contact.isNotEmpty) {
                        setState(() {
                          nameController.clear();
                          contactController.clear();
                          contacts.add(Contacts(name: name, contact: contact));
                        });
                      }
                    },
                    child: const Text('Save')),
                ElevatedButton(
                    onPressed: () {
                      String name = nameController.text.trim();
                      String contact = contactController.text.trim();

                      if (name.isNotEmpty && contact.isNotEmpty) {
                        setState(() {
                          nameController.clear();
                          contactController.clear();
                          contacts[selectedIndex].name = name;
                          contacts[selectedIndex].contact = contact;
                          selectedIndex = -1;
                        });
                      }
                    },
                    child: const Text('Update')),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            contacts.isEmpty
                ? const Text(
                    'No contacts here..',
                    style: TextStyle(fontSize: 18),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) => getRow(index),
                      itemCount: contacts.length,
                    ),
                  )
          ],
        ),
      ),
    );
  }

  Widget getRow(int index) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              index % 2 == 0 ? Colors.deepPurpleAccent : Colors.purple,
          foregroundColor: Colors.white,
          child: Text(contacts[index].name[0]),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              contacts[index].name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(contacts[index].contact)
          ],
        ),
        trailing: SizedBox(
          width: 70,
          child: Row(
            children: [
              InkWell(
                  onTap: () {
                    setState(() {
                      nameController.text = contacts[index].name;
                      contactController.text = contacts[index].contact;
                      setState(() {
                        selectedIndex = index;
                      });
                    });
                  },
                  child: const Icon(Icons.edit)),
              const SizedBox(
                width: 14,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    contacts.removeAt(index);
                  });
                },
                child: const Icon(
                  Icons.delete,
                  color: Colors.redAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
