import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_app/constants/color.dart';
import 'package:form_app/helper/data_service.dart';
import 'package:share_plus/share_plus.dart';


class ShowDetails extends StatefulWidget {
  @override
  _ShowDetailsState createState() => _ShowDetailsState();
}

class _ShowDetailsState extends State<ShowDetails> {
  late DataService _dataService;
  List<Map<String, String>> _users = [];
  bool _selectAll = false;
  bool _showDeleteButton = false;


  @override
  void initState() {
    super.initState();
    _dataService = DataService();
    _loadFormData();
  }

  Future<void> _loadFormData() async {
    print('Loading form data...');
    List<Map<String, String>>? formData = await _dataService.getFormData();
    print('Decoded form data: $formData');
    if (formData != null && formData.isNotEmpty) {
      setState(() {
        _users = formData;
      });
    }
    print('Form data loaded: $_users');
  }

  void _selectAllUsers(bool isSelected) {
    setState(() {
      _selectAll = isSelected;
      for (var user in _users) {
        user['selected'] = isSelected.toString();
      }
      _showDeleteButton = isSelected;  /// chnages made here
    });
  }

  void deleteUserAtIndex(int index) {
    setState(() {
      _users.removeAt(index);
    });
    _dataService.deleteFormDataAtIndex(index);
  }


  void _deleteSelectedUsers() async {
    List<Map<String, String>> remainingUsers = [];
    for (var user in _users) {
      if (user['selected'] != 'true') { // Check for 'true' as a String
        remainingUsers.remove(user);
      }
    }
    setState(() {
      _users = remainingUsers;
      _showDeleteButton = false;
    });
    _dataService.clearFormData();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColor.appBarColor,
        title: const Text('User List', style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),),
        actions: [
          if(!_showDeleteButton)
            const Text("Select All",style: TextStyle(color: Colors.white),),
          if(_showDeleteButton)
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Confirm Delete"),
                        content: const Text("Are you sure you want delete all the records"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              _deleteSelectedUsers();
                              Navigator.of(context).pop();
                            },
                            child: const Text("Delete"),
                          ),
                        ],
                      );
                    }
                );
              },
              icon: const Icon(Icons.delete),
              color: AppColor.fillfomrColor,
              tooltip: "Delete",
            ),

          Checkbox(
              value: _selectAll,
              onChanged: (value) {
                _selectAllUsers(value ?? false);
              },
            checkColor: Colors.white,
          ),
        ],
      ),
      body: _users.isEmpty
          ? const Center(
        child: Text('No user details found'),
      )
          : ListView.builder(
        itemCount: _users.length,
        itemBuilder: (BuildContext context, int index) {
          final user = _users[index];
          return Dismissible(
            key: UniqueKey(),
            background: Container(color: Colors.red),
            confirmDismiss: (direction) async {
              return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Confirm Delete'),
                    content: const Text('Are you sure you want to delete this user?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: const Text('Delete'),
                      ),
                    ],
                  );
                },
              );
            },
            onDismissed: (direction) {
              setState(() {
                deleteUserAtIndex(index);
                // _dataService.saveFormData(_users); // Save updated data
              });
            },
            child: Card(
              margin: const EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name: ${user['name']}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Text('Email: ${user['email']}'),
                        const SizedBox(height: 5),
                        Text('Phone no: ${user['phone']}'),
                        const SizedBox(height: 5),
                        Text('Gender: ${user['gender']}'),
                        const SizedBox(height: 5),
                        Text('Country: ${user['country']}'),
                        const SizedBox(height: 5),
                        Text('State: ${user['state']}'),
                        const SizedBox(height: 5),
                        Text('City: ${user['city']}'),
                      ],
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 100,),
                        IconButton(
                          onPressed: ()  {
                            shareUserInfo(user, context);
                          },
                          icon: const Icon(Icons.share),
                          color: AppColor.shareColor,
                        ),
                        const Text("Share",style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w500
                        ),)
                      ],
                    )
                  ],
                )
              ),
            ),
          );
        },
      ),
    );
  }
  void shareUserInfo(Map<String, dynamic> user, BuildContext context) {
    String userInfo = '''
    Name: ${user['name']}
    Email: ${user['email']}
    Phone no: ${user['phone']}
    Gender: ${user['gender']}
    Country: ${user['country']}
    State: ${user['state']}
    City: ${user['city']}
    ''';

    Share.share(userInfo, subject: 'User Info'); // Use the share_plus package to share the content
  }
}
