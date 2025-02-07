import 'package:contact_dairy_app/helpers/providers/contact_provider.dart';
import 'package:contact_dairy_app/helpers/providers/platform_provider.dart';
import 'package:contact_dairy_app/models/contact_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../helpers/providers/theme_provider.dart';

class Detailcontactpage extends StatefulWidget {
  const Detailcontactpage({super.key});

  @override
  State<Detailcontactpage> createState() => _DetailcontactpageState();
}

class _DetailcontactpageState extends State<Detailcontactpage> {
  @override
  Widget build(BuildContext context) {
    Provider.of<ContactProvider>(context);

    Contact contact = ModalRoute.of(context)!.settings.arguments as Contact;

    return (Provider.of<PlatformProvider>(context).isIOS == false)
        ? Scaffold(
            appBar: AppBar(
              title: Text("Detail Contact"),
              centerTitle: false,
              actions: [
                IconButton(
                    onPressed: () {
                      Provider.of<ContactProvider>(context, listen: false)
                          .hidecontact(data: contact);

                      Provider.of<ContactProvider>(context, listen: false)
                          .deletecontact(data: contact);

                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.lock)),
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
            body: Column(
              children: [
                Text("${contact.firstName}${contact.lastName}"),
                Text("${contact.contactNumber}"),
                Text("${contact.email}"),
                Text("${contact.website}"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: () async {
                          try {
                            await launchUrl(
                                Uri.parse("tel:+91${contact.contactNumber}"));
                          } catch (e) {
                            print(e);
                          }
                        },
                        icon: Icon(Icons.call)),
                    IconButton(
                        onPressed: () async {
                          try {
                            await launchUrl(
                                Uri.parse("sms:+91${contact.contactNumber}"));
                          } catch (e) {
                            print(e);
                          }
                        },
                        icon: Icon(Icons.sms)),
                    IconButton(
                        onPressed: () async {
                          try {
                            await launchUrl(
                                Uri.parse("mailto:${contact.email}"));
                          } catch (e) {
                            print(e);
                          }
                        },
                        icon: Icon(Icons.email)),
                    IconButton(
                        onPressed: () async {
                          try {
                            await launchUrl(
                                Uri.parse("https:${contact.website}"));
                          } catch (e) {
                            print(e);
                          }
                        },
                        icon: Icon(Icons.web_asset)),
                  ],
                )
              ],
            ),
          )
        : CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text("Detail Contact"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Provider.of<ContactProvider>(context, listen: false)
                          .hidecontact(data: contact);
                      Provider.of<ContactProvider>(context, listen: false)
                          .deletecontact(data: contact);
                      Navigator.of(context).pop();
                    },
                    child: Icon(CupertinoIcons.lock, size: 24),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Provider.of<ThemeProvider>(context, listen: false)
                          .changetheme();
                    },
                    child: Icon(
                      Provider.of<ThemeProvider>(context).isdark
                          ? CupertinoIcons.moon_fill
                          : CupertinoIcons.sun_max_fill,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    "${contact.firstName} ${contact.lastName}",
                    style:
                        CupertinoTheme.of(context).textTheme.navTitleTextStyle,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "${contact.contactNumber}",
                    style: CupertinoTheme.of(context).textTheme.textStyle,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "${contact.email}",
                    style: CupertinoTheme.of(context).textTheme.textStyle,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "${contact.website}",
                    style: CupertinoTheme.of(context).textTheme.textStyle,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () async {
                          try {
                            await launchUrl(
                                Uri.parse("tel:+91${contact.contactNumber}"));
                          } catch (e) {
                            print(e);
                          }
                        },
                        child: Icon(CupertinoIcons.phone_fill, size: 28),
                      ),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () async {
                          try {
                            await launchUrl(
                                Uri.parse("sms:+91${contact.contactNumber}"));
                          } catch (e) {
                            print(e);
                          }
                        },
                        child: Icon(CupertinoIcons.chat_bubble_fill, size: 28),
                      ),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () async {
                          try {
                            await launchUrl(
                                Uri.parse("mailto:${contact.email}"));
                          } catch (e) {
                            print(e);
                          }
                        },
                        child: Icon(CupertinoIcons.mail_solid, size: 28),
                      ),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () async {
                          try {
                            await launchUrl(
                                Uri.parse("https:${contact.website}"));
                          } catch (e) {
                            print(e);
                          }
                        },
                        child: Icon(CupertinoIcons.globe, size: 28),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}
