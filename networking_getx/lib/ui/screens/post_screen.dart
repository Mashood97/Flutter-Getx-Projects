import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:networking_getx/ui/controllers/post_controller.dart';
import 'package:networking_getx/widgets/animated_searchbar.dart';
import 'package:networking_getx/widgets/loading.dart';

class PostScreen extends StatelessWidget {
  static const routeNamed = '/postscreen';
  final PostController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
//        elevation: 0.0,
        bottomOpacity: 0.05,
        title: Text(
          'Networking with GetX',
          style: Theme.of(context).textTheme.headline4.copyWith(
                fontSize: 20.0,
              ),
        ),
        leading: Icon(
          Icons.sort,
          color: Colors.black,
          size: 40,
        ),
        actions: [
          IconButton(
            splashColor: Colors.pink,
            splashRadius: 30,
            icon: Icon(
              Icons.add,
              color: Colors.black,
              size: 40,
            ),
            onPressed: () {
              _controller.navigateToAddPost();
            },
          )
        ],
      ),
      body: SafeArea(
        child: Obx(
          () => _controller.isLoading
              ? Loading()
              : RefreshIndicator(
                  color: Theme.of(context).primaryColor,
                  displacement: 100,
                  onRefresh: () => _controller.getPostsFromApi(),
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemCount: _controller.getAllPosts.length,
                    separatorBuilder: (_, __) => Divider(),
                    itemBuilder: (ctx, index) => ListTile(
                      title: Text(
                        _controller.getAllPosts[index].title,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      subtitle: Text(
                        _controller.getAllPosts[index].body,
                        style: Theme.of(context).textTheme.headline6,
                        maxLines: 2,
                      ),
                      leading: CircleAvatar(
                        radius: 30,
                        child: Text(
                          _controller.getAllPosts[index].id.toString(),
                          style: Theme.of(context).textTheme.headline6.copyWith(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                        ),
                      ),
                    ),
                  ),
                ),
        ),
      ),
      floatingActionButton: AnimatedSearchBar(),
    );
  }
}
