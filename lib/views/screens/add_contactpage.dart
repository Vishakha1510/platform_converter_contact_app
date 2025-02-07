import 'package:contact_dairy_app/helpers/providers/platform_provider.dart';
import 'package:contact_dairy_app/helpers/providers/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../helpers/providers/contact_provider.dart';
import '../../models/contact_model.dart';

final TextEditingController firstNameController = TextEditingController();
final TextEditingController lastNameController = TextEditingController();
final TextEditingController contactNumberController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController websiteController = TextEditingController();

class AddContactPage extends StatefulWidget {
  const AddContactPage({super.key});

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  int initialstep = 0;

  DateTime currentdatetime = DateTime.now();
  TimeOfDay currenttime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return (Provider.of<PlatformProvider>(context).isIOS == false)
        ? Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back),
              ),
              title: Text('Add Contact Page'),
              actions: [
                IconButton(
                  icon: Icon(
                    Provider.of<ThemeProvider>(context).isdark
                        ? Icons.dark_mode
                        : Icons.light_mode,
                  ),
                  onPressed: () {
                    Provider.of<ThemeProvider>(context, listen: false)
                        .changetheme();
                  },
                ),
              ],
            ),
            body: Column(
              spacing: 30,
              children: [
                Stepper(
                    currentStep: initialstep,
                    onStepContinue: () {
                      setState(() {
                        if (initialstep < 2) {
                          initialstep++;
                        }
                      });
                    },
                    onStepCancel: () {
                      setState(() {
                        if (initialstep > 0) {
                          initialstep--;
                        }
                      });
                    },
                    onStepTapped: (value) {
                      setState(() {
                        initialstep = value;
                      });
                    },
                    controlsBuilder: (context, controldetails) {
                      return Container();
                    },
                    steps: [
                      Step(
                          title: Text('personal info'),
                          content: Column(
                            spacing: 10,
                            children: [
                              TextField(
                                controller: firstNameController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Enter First Name here....',
                                    labelText: 'First Name'),
                              ),
                              TextField(
                                controller: lastNameController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Enter Last Name here....',
                                    labelText: 'Last Name'),
                              )
                            ],
                          )),
                      Step(
                          title: Text('contact info'),
                          content: Column(
                            spacing: 10,
                            children: [
                              TextField(
                                controller: contactNumberController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Enter Contact no. here....',
                                    labelText: 'Contact No.'),
                              ),
                              TextField(
                                controller: emailController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Enter Email here....',
                                    labelText: 'Email'),
                              ),
                              TextField(
                                controller: websiteController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Enter Website here....',
                                    labelText: 'Website'),
                              ),
                            ],
                          )),
                      Step(
                          title: Text("Additional Info"),
                          content: Column(
                            children: [
                              Row(
                                spacing: 20,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("Select Date:"),
                                  Container(
                                    height: 30,
                                    width: 140,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius:
                                            BorderRadius.circular(12.0)),
                                    child: Center(
                                      child: Text(
                                          " ${currentdatetime.day} - ${currentdatetime.month} - ${currentdatetime.year}",
                                          style: TextStyle(fontSize: 20)),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () async {
                                        DateTime? pickeddate =
                                            await showDatePicker(
                                                context: (context),
                                                initialDate: currentdatetime,
                                                firstDate: DateTime(2000),
                                                lastDate: DateTime(2030),
                                                helpText: "Choose Date",
                                                confirmText: "Done",
                                                cancelText: "Dismiss",
                                                initialEntryMode:
                                                    DatePickerEntryMode
                                                        .calendarOnly,
                                                initialDatePickerMode:
                                                    DatePickerMode.day);
                                        setState(() {
                                          if (pickeddate != null) {
                                            currentdatetime = pickeddate;
                                          }
                                        });
                                      },
                                      icon: Icon(Icons.calendar_month)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Divider(),
                                  Text("Select Time:"),
                                  Container(
                                    height: 30,
                                    width: 170,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius:
                                            BorderRadius.circular(12.0)),
                                    child: Center(
                                      child: (currenttime.hour > 12)
                                          ? Text(
                                              "${currenttime.hour - 12} : ${currenttime.minute} ${currenttime.period.name}",
                                              style: TextStyle(fontSize: 20),
                                            )
                                          : Text(
                                              "${currenttime.hour} : ${currenttime.minute} ${currenttime.period.name}",
                                              style: TextStyle(fontSize: 20),
                                            ),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () async {
                                        TimeOfDay? pickedtime =
                                            await showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now(),
                                                helpText: "Choose Time",
                                                confirmText: "Ok",
                                                cancelText: "Dismiss",
                                                initialEntryMode:
                                                    TimePickerEntryMode
                                                        .dialOnly);
                                        setState(() {
                                          if (pickedtime != null) {
                                            currenttime = pickedtime;
                                          }
                                        });
                                      },
                                      icon: Icon(Icons.timer)),
                                ],
                              )
                            ],
                          ))
                    ]),
                OutlinedButton(
                    onPressed: () {
                      Contact contact = Contact(
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                          contactNumber: contactNumberController.text,
                          email: emailController.text,
                          website: websiteController.text);
                      Provider.of<ContactProvider>(context, listen: false)
                          .addcontact(data: contact);

                      firstNameController.clear();
                      lastNameController.clear();
                      contactNumberController.clear();
                      emailController.clear();
                      websiteController.clear();
                    },
                    child: Text("Submit"))
              ],
            ),
          )
        : CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text('Add Contact Page'),
              leading: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Icon(CupertinoIcons.back),
              ),
              trailing: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .changetheme();
                },
                child: Icon(
                  Provider.of<ThemeProvider>(context).isdark
                      ? CupertinoIcons.moon_fill
                      : CupertinoIcons.sun_max_fill,
                ),
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: Column(children: [
                      if (initialstep == 0) ...[
                        // Step 1: Personal Info
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              CupertinoTextField(
                                controller: firstNameController,
                                placeholder: 'Enter First Name here...',
                                padding: EdgeInsets.all(12),
                              ),
                              SizedBox(height: 10),
                              CupertinoTextField(
                                controller: lastNameController,
                                placeholder: 'Enter Last Name here...',
                                padding: EdgeInsets.all(12),
                              ),
                            ],
                          ),
                        ),
                      ] else if (initialstep == 1) ...[
                        // Step 2: Contact Info
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              CupertinoTextField(
                                controller: contactNumberController,
                                placeholder: 'Enter Contact No. here...',
                                padding: EdgeInsets.all(12),
                              ),
                              SizedBox(height: 10),
                              CupertinoTextField(
                                controller: emailController,
                                placeholder: 'Enter Email here...',
                                padding: EdgeInsets.all(12),
                              ),
                              SizedBox(height: 10),
                              CupertinoTextField(
                                controller: websiteController,
                                placeholder: 'Enter Website here...',
                                padding: EdgeInsets.all(12),
                              ),
                            ],
                          ),
                        ),
                      ] else if (initialstep == 2) ...[
                        Row(
                          spacing: 30,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Select Date:",
                              style: TextStyle(fontSize: 20),
                            ),
                            Container(
                              height: 20,
                              width: 130,
                              child: Text(
                                  "${currentdatetime.day} - ${currentdatetime.month} - ${currentdatetime.year}",
                                  style: TextStyle(fontSize: 20)),
                            ),
                            IconButton(
                                icon: Icon(CupertinoIcons.calendar),
                                onPressed: () {
                                  showCupertinoModalPopup(
                                    context: (context),
                                    builder: (context) {
                                      return Container(
                                        height: 240,
                                        child: CupertinoDatePicker(
                                          onDateTimeChanged: (val) {
                                            setState(() {
                                              currentdatetime = val;
                                            });
                                          },
                                          initialDateTime: currentdatetime,
                                          mode: CupertinoDatePickerMode.date,
                                          showDayOfWeek: true,
                                          minimumYear: 2000,
                                          maximumYear: 2050,
                                        ),
                                      );
                                    },
                                  );
                                }),
                          ],
                        ),
                        Row(
                          spacing: 30,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Select Time:",
                              style: TextStyle(fontSize: 20),
                            ),
                            Container(
                              height: 20,
                              width: 130,
                              child: (currentdatetime.hour > 12)
                                  ? Text(
                                      "${currentdatetime.hour - 12} : ${currentdatetime.minute} pm",
                                      style: TextStyle(fontSize: 20))
                                  : Text(
                                      "${currentdatetime.hour} : ${currentdatetime.minute} am",
                                      style: TextStyle(fontSize: 20)),
                            ),
                            IconButton(
                                icon: Icon(CupertinoIcons.clock),
                                onPressed: () {
                                  showCupertinoModalPopup(
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        height: 240,
                                        color: CupertinoColors.white,
                                        child: CupertinoDatePicker(
                                          onDateTimeChanged: (val) {
                                            setState(() {
                                              currentdatetime = val;
                                            });
                                          },
                                          mode: CupertinoDatePickerMode.time,
                                        ),
                                      );
                                    },
                                  );
                                }),
                          ],
                        )
                      ],
                    ]),
                  ),
                  // Navigation Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CupertinoButton(
                        child: Text("Back"),
                        onPressed: initialstep > 0
                            ? () {
                                setState(() {
                                  initialstep--;
                                });
                              }
                            : null,
                      ),
                      CupertinoButton.filled(
                        child: initialstep == 2 ? Text("Submit") : Text("Next"),
                        onPressed: () {
                          if (initialstep < 2) {
                            setState(() {
                              initialstep++;
                            });
                          } else {
                            Contact contact = Contact(
                              firstName: firstNameController.text,
                              lastName: lastNameController.text,
                              contactNumber: contactNumberController.text,
                              email: emailController.text,
                              website: websiteController.text,
                            );

                            Provider.of<ContactProvider>(context, listen: false)
                                .addcontact(data: contact);

                            firstNameController.clear();
                            lastNameController.clear();
                            contactNumberController.clear();
                            emailController.clear();
                            websiteController.clear();

                            Navigator.pop(context);
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}
