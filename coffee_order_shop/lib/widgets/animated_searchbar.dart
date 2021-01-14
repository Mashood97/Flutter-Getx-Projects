import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedSearchBar extends StatefulWidget {
  @override
  _AnimatedSearchBarState createState() => _AnimatedSearchBarState();
}

class _AnimatedSearchBarState extends State<AnimatedSearchBar> {
  bool _folded = true;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      width: _folded ? mediaQuery.width * 0.5 : mediaQuery.width * 0.75,
      height: mediaQuery.width * 0.02,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 16.0),
              child: !_folded
                  ? TextField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        hintStyle: Theme.of(context).textTheme.headline6,
                        border: InputBorder.none,
                      ),
                    )
                  : null,
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 400),
            child: Material(
              type: MaterialType.transparency,
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
