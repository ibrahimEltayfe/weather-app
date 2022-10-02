import 'package:flutter/material.dart';
import 'package:my_projects/reusable_components/scaffold_wrapper.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      child: Center(
        child: Text("no internet"),
      ),
    );
  }
}
