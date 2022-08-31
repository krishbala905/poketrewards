import 'package:flutter/material.dart';
import 'package:poketrewards/generated/l10n.dart';
import 'package:poketrewards/res/Colors.dart';
class InboxFragment extends StatefulWidget {
  const InboxFragment({Key? key}) : super(key: key);

  @override
  State<InboxFragment> createState() => _InboxFragmentState();
}

class _InboxFragmentState extends State<InboxFragment> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:Scaffold(
        backgroundColor:  Colors.white,
      ),

    );
  }
}
