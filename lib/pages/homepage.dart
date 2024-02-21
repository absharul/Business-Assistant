import 'package:flutter/material.dart';
import 'package:form_app/constants/color.dart';
import 'package:form_app/pages/formpage.dart';
import 'package:form_app/pages/show_details.dart';
import 'package:form_app/widgets/smalltext.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColor.appBarColor,
        title: const Text("Business Assistant", style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text("Services", style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500
              ),),
            )
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                elevation: 20,
                child: Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColor.gstCalculatorColor
                    ),
                    child: const Center(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: SmallText(text: "GST Calculator"),
                        )
                    )
                ),
              ),
              SizedBox(width: 20,),
              Card(
                elevation: 20,
                child: Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColor.gstinvoiceColor
                    ),
                    child: const Center(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: SmallText(text: "GST Invoice"),
                        )
                    )
                ),
              )
            ],
          ),
          const SizedBox(height: 25,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FormPage()));
                },
                child: Card(
                  elevation: 20,
                  child: Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColor.fillfomrColor
                      ),
                      child: const Center(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: SmallText(text: "Fill Form"),
                          )
                      )
                  ),
                ),
              ),
              SizedBox(width: 20,),
              Card(
                elevation: 20,
                child: Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColor.businesscardColor,
                    ),
                    child: const Center(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: SmallText(text: "Create Business Card"),
                        )
                    )
                ),
              ),
            ],
          ),
          const SizedBox(height: 25,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                elevation: 20,
                child:  Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColor.expenseTrColor
                    ),
                    child: const Center(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: SmallText(text: "Expense Tracker"),
                        )
                    )
                ),
              ),
              SizedBox(width: 20,),
              Card(
                elevation: 20,
                child: Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColor.khataColor
                    ),
                    child: const Center(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: SmallText(text: "Khata Book"),
                        )
                    )
                ),
              ),
            ],
          )
        ],
      ),

    );
  }
}
