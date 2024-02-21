import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_app/constants/color.dart';
import 'package:form_app/helper/data_service.dart';
import 'package:form_app/pages/Successful.dart';
import 'package:form_app/pages/show_details.dart';
import 'package:form_app/widgets/smalltext.dart';


class FormPage extends StatefulWidget {
  const FormPage({super.key,});



  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  String? _gender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColor.appBarColor,
        title: const Text("Personal Details",
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w600,
              color: Colors.white
          ),),
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () { Navigator.pop(context); },
            color: Colors.white,
          );
        },
      ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 30.0,),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30.0,),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                    labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30.0,),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone',border: OutlineInputBorder(),),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30.0,),
              DropdownButtonFormField<String>(
                value: _gender,
                decoration: const InputDecoration(labelText: 'Gender',border: OutlineInputBorder(),),
                items: <String>['Male', 'Female', 'Other']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _gender = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select your gender';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30.0,),
              TextFormField(
                controller: _countryController,
                decoration: const InputDecoration(labelText: 'Country',border: OutlineInputBorder(),),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your country';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30.0,),
              TextFormField(
                controller: _stateController,
                decoration: const InputDecoration(labelText: 'State',border: OutlineInputBorder(),),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your state';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30.0,),
              TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(labelText: 'City',border: OutlineInputBorder(),),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your city';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              SizedBox(
                height: 50,
                width: 300,
                child:  ElevatedButton(
                  // Inside FormPage Widget
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        Map<String, String> result = {
                          'name': _nameController.text,
                          'email': _emailController.text,
                          'phone': _phoneController.text,
                          'gender': _gender ?? '',
                          'country': _countryController.text,
                          'state': _stateController.text,
                          'city': _cityController.text,
                        };

                        print('Form Data to be saved: $result');

                        String formDataJson = jsonEncode(result);
                        print('Encoded Form Data: $formDataJson');

                        await DataService().saveFormData([result]);

                        print('Form Data Saved Successfully');

                        _formKey.currentState!.reset();

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SuccessfulPage()),
                        );
                      }
                    },
                  style: ElevatedButton.styleFrom(
                    primary: AppColor.appBarColor,
                  ),

                  child: const SmallText(text: "Submit")
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}