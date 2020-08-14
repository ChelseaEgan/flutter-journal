import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  static const routeName = 'welcome';

  @override
  Widget build(BuildContext context) {
    return welcomeIcon(context);
  }

  Widget welcomeIcon(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.collections_bookmark,
              size: 100,
            ),
            Text(
              'Journal',
              style: Theme.of(context).textTheme.headline1,
            )
          ],
        ),
      );
}
