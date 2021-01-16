import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:networking_getx/ui/controllers/post_controller.dart';

class AnimatedSearchBar extends StatefulWidget {

  @override
  _AnimatedSearchBarState createState() => _AnimatedSearchBarState();
}

class _AnimatedSearchBarState extends State<AnimatedSearchBar> {
  bool _folded = true;
  final PostController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      width: _folded ? mediaQuery.width * 0.155 : mediaQuery.width * 0.75,
      height: mediaQuery.width * 0.14,
      curve: Curves.linearToEaseOut,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: Colors.white,
        boxShadow: kElevationToShadow[6],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 16.0),
              child: !_folded
                  ? TextField(
                      controller: _controller.searchController,
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        hintStyle: Theme.of(context).textTheme.headline6,
                        border: InputBorder.none,
                      ),
                      onChanged: (val) => _controller.filterBytitle(),
                    )
                  : null,
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 400),
            child: Material(
//              type: MaterialType.transparency,
              shape: StadiumBorder(),
              child: InkWell(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(_folded ? 32 : 0),
                  topRight: Radius.circular(32),
                  bottomLeft: Radius.circular(_folded ? 32 : 0),
                  bottomRight: Radius.circular(32),
                ),
                onTap: () {
                  setState(() {
                    _folded = !_folded;

                  });
                  if(_folded){
                    _controller.searchController.clear();
                    _controller.filterBytitle();
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(
                    _folded ? Icons.search : Icons.close,
                    size: 30,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
