import 'package:flutter/material.dart';

import '../../assets/theme.dart';
import '../../assets/widgets/customsearchbar.dart';
import '../../assets/widgets/customtexticoncard.dart';
// Import your reusable widgets and SQLite helper here
// import 'reusable_search_bar.dart';
// import 'text_icon_card.dart';
// import 'xxlarge_circular_button.dart';
// import 'your_sqlite_helper.dart';

class EmergencyContactsPage extends StatefulWidget {
  const EmergencyContactsPage({super.key});

  @override
  _EmergencyContactsPageState createState() => _EmergencyContactsPageState();
}

class _EmergencyContactsPageState extends State<EmergencyContactsPage> {
  List<Map<String, dynamic>> contacts = [];
 
  @override
  void initState() {
    super.initState();
    loadContacts();
  }

  void loadContacts() async {
    // Fetch contacts from SQLite database and update the state
    // For now, we'll use an empty list to simulate no contacts
    setState(() {
      contacts = []; // Replace with actual data fetched from SQLite
    });
  }

  void deleteContact(int id) async {
    // Delete contact from SQLite database and update the state
    loadContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Contacts'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: ReusableSearchBar(
            onSearch: (query) {
              // Implement search functionality if needed
            },
          ),
        ),
      ),
      body: contacts.isEmpty
          ? const Center(
              child: Text('No contacts yet saved'),
            )
          : ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                var contact = contacts[index];
                return TextIconCard(
                  text: '${contact['name']} - ${contact['number']}',
                  icon: Icons.delete,
                  onTap: () => deleteContact(contact['id']),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the page where a new contact can be added
        },
        backgroundColor: AppTheme.secondaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
