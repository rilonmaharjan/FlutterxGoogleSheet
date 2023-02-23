
import 'package:flutter/material.dart';
import 'package:sheet/view/arrival_view.dart';
import 'package:sheet/view/dep_view.dart';

class BottomNav extends StatefulWidget {
  final int index;
  final String?  arvUrl, depUrl;
  final String? editArvUrl, depEditUrl;
  const BottomNav({Key? key, required this.index,  this.arvUrl, this.depUrl, this.editArvUrl, this.depEditUrl}) : super(key: key);


  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int selectedIndex = 0;
  List <Widget> ?pages;

  @override
  void initState() {
    pages = [
      ArrivalView(url: widget.arvUrl, editUrl: widget.editArvUrl ?? "",),
      DepartureView(url: widget.depUrl, editUrl: widget.depEditUrl ?? ""),
    ];
    handleTap(widget.index);
    super.initState();
  }

  handleTap(index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages![selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: handleTap,
        currentIndex: selectedIndex,
        elevation: 25,
        unselectedItemColor: const Color(0xffC6C5CD),
        selectedItemColor: const Color(0xff6B59F4),
        selectedFontSize: 13,
        iconSize: 30,
        unselectedFontSize: 11,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top:10.0, bottom: 2),
              child: Icon(Icons.flight_land_rounded,),
            ),
            label: "Arrival",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top:10.0, bottom: 2),
              child: Icon(Icons.flight_takeoff_rounded),
            ),
            label: "Departure",
          ),
        ],
      ),
    );
  }
}