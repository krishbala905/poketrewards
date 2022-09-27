import 'package:flutter/material.dart';
import 'package:poketrewards/res/Colors.dart';
import '../../res/Strings.dart';
import 'EVoucher/EVoucherFragment.dart';
import 'Ecards/ECardFragment.dart';
import 'Others/OthersFragment.dart';
class WalletFragment extends StatefulWidget {
  const WalletFragment({Key? key}) : super(key: key);

  @override
  State<WalletFragment> createState() => _WalletFragmentState();
}

class _WalletFragmentState extends State<WalletFragment> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 3,
      child:  Scaffold(
        appBar:  PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            decoration: BoxDecoration(color: lightGrey2),
            height: 40.0,
            child:   const TabBar(
              indicatorColor: corporateColor,
              unselectedLabelColor: Colors.black,

              tabs: [
                Tab(child: Text(ecards,style: TextStyle(color: Colors.black),),),
                Tab(child: Text(evoucher,style: TextStyle(color: Colors.black),),),
                Tab(child: Text(others,style: TextStyle(color: Colors.black),),),
              ],
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            ECardFragment(),
            EVoucherFragment(),
            OthersFragment()

          ],
        ),
      ),
    );
  }

}