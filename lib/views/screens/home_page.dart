import 'package:contact_dairy_app/helpers/providers/contact_provider.dart';
import 'package:contact_dairy_app/helpers/providers/platform_provider.dart';
import 'package:contact_dairy_app/helpers/providers/theme_provider.dart';
import 'package:contact_dairy_app/models/contact_model.dart';
import 'package:contact_dairy_app/views/screens/add_contactpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    ContactProvider obj = Provider.of<ContactProvider>(context);
    return (Provider.of<PlatformProvider>(context, listen: false).isIOS ==
            false)
        ? Scaffold(
            appBar: AppBar(
              title: Text("Home Page"),
              centerTitle: false,
              actions: [
                IconButton(
                  onPressed: () async {
                    LocalAuthentication localAuthentication =
                        LocalAuthentication();

                    bool isBiometricAvailable =
                        await localAuthentication.canCheckBiometrics;

                    bool isDeviceSupported =
                        await localAuthentication.isDeviceSupported();

                    if (isBiometricAvailable || isDeviceSupported) {
                      bool isAuthenticated =
                          await localAuthentication.authenticate(
                              localizedReason:
                                  "Please provide your authenticity");

                      if (isAuthenticated == true) {
                        Navigator.of(context).pushNamed('hidden_contact_page');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Authentication is wrong")));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Authentication is not supported")));
                    }

                    Navigator.of(context).pushNamed('hidden_contact_page');
                  },
                  icon: Icon(Icons.lock),
                ),
                IconButton(
                  onPressed: () {
                    Provider.of<ThemeProvider>(context, listen: false)
                        .changetheme();
                  },
                  icon: Icon(
                    Provider.of<ThemeProvider>(context, listen: true).isdark
                        ? Icons.dark_mode
                        : Icons.light_mode,
                    size: 24,
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed('add_contact_page');
              },
              child: Icon(Icons.add),
            ),
            body: ListView.builder(
                padding: EdgeInsets.all(12.0),
                itemCount: obj.allcontact.length,
                itemBuilder: (context, i) {
                  return Card(
                    elevation: 5,
                    shadowColor: Colors.blue,
                    child: ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, 'detail_screen_page',
                            arguments: obj.allcontact[i]);
                      },
                      trailing: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Edit Contact"),
                                      actions: [
                                        TextField(
                                          controller: firstNameController,
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: "First name",
                                              labelText: "First name"),
                                        ),
                                        SizedBox(height: 10),
                                        TextField(
                                          controller: lastNameController,
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: "last name",
                                              labelText: "last name"),
                                        ),
                                        SizedBox(height: 10),
                                        TextField(
                                          controller: contactNumberController,
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: "Contact no.",
                                              labelText: "Contact no."),
                                        ),
                                        SizedBox(height: 10),
                                        TextField(
                                          controller: emailController,
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: "Email",
                                              labelText: "Email"),
                                        ),
                                        SizedBox(height: 10),
                                        TextField(
                                          controller: websiteController,
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: "Website",
                                              labelText: "Website"),
                                        ),
                                        Center(
                                          child: OutlinedButton(
                                            onPressed: () {
                                              Contact contact = Contact(
                                                  firstName:
                                                      firstNameController.text,
                                                  lastName:
                                                      lastNameController.text,
                                                  contactNumber:
                                                      contactNumberController
                                                          .text,
                                                  email: emailController.text,
                                                  website:
                                                      websiteController.text);

                                              Provider.of<ContactProvider>(
                                                      context,
                                                      listen: false)
                                                  .updatecontact(
                                                      data: contact, id: i);

                                              firstNameController.clear();
                                              lastNameController.clear();
                                              contactNumberController.clear();
                                              emailController.clear();
                                              websiteController.clear();

                                              Navigator.of(context).pop();
                                            },
                                            child: Text("Submit"),
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: Icon(Icons.edit)),
                          IconButton(
                              onPressed: () {
                                obj.deletecontact(data: obj.allcontact[i]);
                              },
                              icon: Icon(Icons.delete)),
                        ],
                      ),
                      isThreeLine: true,
                      leading: Text("${i + 1}"),
                      title: Text("${obj.allcontact[i].firstName}"),
                      subtitle: Text(
                          "+91 ${obj.allcontact[i].contactNumber}\n${obj.allcontact[i].website}"),
                    ),
                  );
                }),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Text(
                      'Settings',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Text('Use iOS Style'),
                        Spacer(),
                        Switch(
                          value: Provider.of<PlatformProvider>(context,
                                  listen: true)
                              .isIOS,
                          onChanged: (value) {
                            Provider.of<PlatformProvider>(context,
                                    listen: false)
                                .changeplatform();

                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        : CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text("Home Page"),
              leading: CupertinoButton(
                child: Icon(CupertinoIcons.settings),
                onPressed: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) => CupertinoActionSheet(
                      title: Text('Settings'),
                      actions: [
                        CupertinoActionSheetAction(
                          child: Row(
                            children: [
                              Text('Use iOS Style'),
                              Spacer(),
                              CupertinoSwitch(
                                value: Provider.of<PlatformProvider>(context,
                                            listen: true)
                                        .isIOS ==
                                    true,
                                onChanged: (value) {
                                  Provider.of<PlatformProvider>(context,
                                          listen: false)
                                      .changeplatform();

                                  setState(() {});
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                          onPressed: () {},
                        ),
                      ],
                      cancelButton: CupertinoActionSheetAction(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  );
                },
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Icon(CupertinoIcons.lock),
                    onPressed: () async {
                      LocalAuthentication localAuthentication =
                          LocalAuthentication();

                      bool isBiometricAvailable =
                          await localAuthentication.canCheckBiometrics;
                      bool isDeviceSupported =
                          await localAuthentication.isDeviceSupported();

                      if (isBiometricAvailable || isDeviceSupported) {
                        bool isAuthenticated =
                            await localAuthentication.authenticate(
                                localizedReason:
                                    "Please provide your authenticity");

                        if (isAuthenticated == true) {
                          Navigator.of(context)
                              .pushNamed('hidden_contact_page');
                        } else {
                          showCupertinoDialog(
                              context: context,
                              builder: (context) => CupertinoAlertDialog(
                                    title: Text("Authentication Failed"),
                                    content: Text("Authentication is wrong"),
                                    actions: [
                                      CupertinoDialogAction(
                                        child: Text("OK"),
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                      ),
                                    ],
                                  ));
                        }
                      } else {
                        showCupertinoDialog(
                            context: context,
                            builder: (context) => CupertinoAlertDialog(
                                  title: Text("Not Supported"),
                                  content:
                                      Text("Authentication is not supported"),
                                  actions: [
                                    CupertinoDialogAction(
                                      child: Text("OK"),
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                    ),
                                  ],
                                ));
                      }
                    },
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Icon(
                      Provider.of<ThemeProvider>(context, listen: true).isdark
                          ? CupertinoIcons.moon_fill
                          : CupertinoIcons.sun_max_fill,
                      size: 24,
                    ),
                    onPressed: () {
                      Provider.of<ThemeProvider>(context, listen: false)
                          .changetheme();
                    },
                  )
                ],
              ),
            ),
            child: SafeArea(
              child: Stack(
                children: [
                  ListView.builder(
                    padding: EdgeInsets.all(12.0),
                    itemCount: obj.allcontact.length,
                    itemBuilder: (context, i) {
                      return CupertinoListTile(
                        onTap: () {
                          Navigator.pushNamed(context, 'detail_screen_page',
                              arguments: obj.allcontact[i]);
                        },
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              child: Icon(CupertinoIcons.pencil),
                              onPressed: () {
                                showCupertinoDialog(
                                  context: context,
                                  builder: (context) {
                                    return CupertinoAlertDialog(
                                      title: Text("Edit Contact"),
                                      content: Column(
                                        children: [
                                          CupertinoTextField(
                                            controller: firstNameController,
                                            placeholder: "First Name",
                                          ),
                                          SizedBox(height: 10),
                                          CupertinoTextField(
                                            controller: lastNameController,
                                            placeholder: "Last Name",
                                          ),
                                          SizedBox(height: 10),
                                          CupertinoTextField(
                                            controller: contactNumberController,
                                            placeholder: "Contact No.",
                                          ),
                                          SizedBox(height: 10),
                                          CupertinoTextField(
                                            controller: emailController,
                                            placeholder: "Email",
                                          ),
                                          SizedBox(height: 10),
                                          CupertinoTextField(
                                            controller: websiteController,
                                            placeholder: "Website",
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        CupertinoDialogAction(
                                          child: Text("Submit"),
                                          onPressed: () {
                                            Contact contact = Contact(
                                              firstName:
                                                  firstNameController.text,
                                              lastName: lastNameController.text,
                                              contactNumber:
                                                  contactNumberController.text,
                                              email: emailController.text,
                                              website: websiteController.text,
                                            );

                                            Provider.of<ContactProvider>(
                                                    context,
                                                    listen: false)
                                                .updatecontact(
                                                    data: contact, id: i);
                                            firstNameController.clear();
                                            lastNameController.clear();
                                            contactNumberController.clear();
                                            emailController.clear();
                                            websiteController.clear();

                                            Navigator.of(context).pop();
                                          },
                                        )
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              child: Icon(CupertinoIcons.delete),
                              onPressed: () {
                                obj.deletecontact(data: obj.allcontact[i]);
                              },
                            )
                          ],
                        ),
                        leading: Text("${i + 1}"),
                        title: Text("${obj.allcontact[i].firstName}"),
                        subtitle: Text(
                            "+91 ${obj.allcontact[i].contactNumber}\n${obj.allcontact[i].website}"),
                      );
                    },
                  ),
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: CupertinoButton(
                      color: CupertinoColors.systemPurple,
                      child: Icon(CupertinoIcons.add),
                      onPressed: () {
                        Navigator.pushNamed(context, 'add_contact_page');
                      },
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
