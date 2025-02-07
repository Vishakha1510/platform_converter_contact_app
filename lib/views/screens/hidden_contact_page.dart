import 'package:contact_dairy_app/helpers/providers/contact_provider.dart';
import 'package:contact_dairy_app/helpers/providers/platform_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HiddenContactPage extends StatefulWidget {
  const HiddenContactPage({super.key});

  @override
  State<HiddenContactPage> createState() => _HiddenContactPageState();
}

class _HiddenContactPageState extends State<HiddenContactPage> {
  @override
  Widget build(BuildContext context) {
    ContactProvider obj = Provider.of<ContactProvider>(context);

    return (Provider.of<PlatformProvider>(context).isIOS == false)
        ? Scaffold(
            appBar: AppBar(
              title: const Text("Hidden Contacts"),
              centerTitle: false,
            ),
            body: ListView.builder(
                itemCount: obj.hiddencontacts.length,
                itemBuilder: (context, i) {
                  return Card(
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).pushNamed('detail_screen_page',
                            arguments: obj.hiddencontacts[i]);
                      },
                      isThreeLine: true,
                      leading: Text("${i + 1}"),
                      title: Text("${obj.hiddencontacts[i].firstName}"),
                      subtitle: Text(
                          "+91${obj.hiddencontacts[i].contactNumber}\n${obj.hiddencontacts[i].website}"),
                    ),
                  );
                }),
          )
        : CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: const Text("Hidden Contacts"),
            ),
            child: SafeArea(
              child: ListView.builder(
                itemCount: obj.hiddencontacts.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    child: CupertinoListTile(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          'detail_screen_page',
                          arguments: obj.hiddencontacts[i],
                        );
                      },
                      leading: Text(
                        "${i + 1}",
                        style: CupertinoTheme.of(context).textTheme.textStyle,
                      ),
                      title: Text(
                        "${obj.hiddencontacts[i].firstName}",
                        style: CupertinoTheme.of(context).textTheme.textStyle,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("+91${obj.hiddencontacts[i].contactNumber}"),
                          Text("${obj.hiddencontacts[i].website}"),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
  }
}
