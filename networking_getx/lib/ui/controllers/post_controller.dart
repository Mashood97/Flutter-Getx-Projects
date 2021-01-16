import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutternetworkservicehandler/flutternetworkservicehandler.dart';
import 'package:get/get.dart';
import 'package:networking_getx/ui/models/Post.dart';
import 'package:networking_getx/ui/screens/add_post.dart';
import 'package:networking_getx/ui/screens/post_screen.dart';
import 'package:networking_getx/utils/common_api.dart';

class PostController extends GetxController {
  var _listOfPosts = List<Post>().obs;

  List<Post> get getAllPosts => _listOfPosts.value;

  String errorMessage = 'Can\'t proceed request';
  var _isLoading = false.obs;

  get isLoading => _isLoading.value;

  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  get titleController => _titleController;

  get bodyController => _bodyController;

  var _tempList = List<Post>().obs;

  getPostsFromApi() async {
    try {
      _listOfPosts.clear();
      _tempList.clear();
      _isLoading.value = true;

      var headers = {
        'Content-type': 'application/json; charset=UTF-8',
      };
      var url = CommonApi.userUrl;
      //api calling using http network service package.
      final response = await HttpNetworkService.getRequest(
        url: url,
        headers: headers,
        networkCheckDurationInSeconds: 10,
      );
      for (var userItem in response) {
        _listOfPosts.add(
          Post(
            body: userItem['body'],
            id: userItem['id'],
            title: userItem['title'],
            userId: userItem['userId'],
          ),
        );

        print(response);
      }
      _tempList.addAll(_listOfPosts);
    } on HttpException catch (error) {
      if (error.toString().contains('Redirection error')) {
        errorMessage = 'The resource requested has been temporarily moved.';
      } else if (error.toString().contains('Bad Request Format')) {
        errorMessage = 'Your client has issued a malformed or illegal request.';
      } else if (error.toString().contains('Internal Server Error')) {
        errorMessage =
            'The server encountered an error and could not complete your request.';
      } else if (error.toString().contains('No Internet Found')) {
        errorMessage =
            'There is no or poor internet connect. Please try again later';
      }
      showSnackBar(errorMessage);
    }
    _isLoading.value = false;
  }

  postPost(Post user) async {
    try {
      _isLoading.value = true;

      var headers = {
        'Content-type': 'application/json; charset=UTF-8',
      };
      var url = CommonApi.userUrl;
      final response = await HttpNetworkService.postRequest(
        url: url,
        body: json.encode({
          'title': user.title,
          'body': user.body,
          'userId': user.userId,
        }),
        networkCheckDurationInSeconds: 20,
      );
      if (response != null) {
        print(response);
        _listOfPosts.add(
          Post(
            title: user.title,
            id: response['id'],
            userId: user.userId,
            body: user.body,
          ),
        );
        _tempList.add(
          Post(
            title: user.title,
            id: response['id'],
            userId: user.userId,
            body: user.body,
          ),
        );
        showSuccessSnackBar('Post Created Successfully');
        navigateToPostScreen();
      } else {
        showSnackBar('Can\'t add user at the moment, Try again later');
      }
    } on HttpException catch (error) {
      if (error.toString().contains('Redirection error')) {
        errorMessage = 'The resource requested has been temporarily moved.';
      } else if (error.toString().contains('Bad Request Format')) {
        errorMessage = 'Your client has issued a malformed or illegal request.';
      } else if (error.toString().contains('Internal Server Error')) {
        errorMessage =
            'The server encountered an error and could not complete your request.';
      } else if (error.toString().contains('No Internet Found')) {
        errorMessage =
            'There is no or poor internet connect. Please try again later';
      }
      showSnackBar(errorMessage);
    }
    _isLoading.value = false;
  }

  final _searchController = TextEditingController();

  get searchController => _searchController;

  filterBytitle() {
    print(_searchController.text);

    if (_searchController.text.isNotEmpty) {
      _listOfPosts.clear();
      _listOfPosts.addAll(_tempList);
      _listOfPosts = _listOfPosts
          .where((e) => e.title
              .toLowerCase()
              .contains(_searchController.text.toString().toLowerCase()))
          .toList()
          .obs;
    } else {
      _listOfPosts.clear();
      _listOfPosts.addAll(_tempList);
    }
  }

  showSnackBar(var message) {
    Get.snackbar(
      'Error',
      message,
      backgroundColor: Colors.black,
      colorText: Colors.white,
    );
  }

  showSuccessSnackBar(var message) {
    Get.snackbar(
      'Success',
      message,
      backgroundColor: Colors.black,
      colorText: Colors.white,
    );
  }

  navigateToAddPost() {
    Get.toNamed(AddPost.routeNamed);
  }

  navigateToPostScreen() {
    Get.offAllNamed(PostScreen.routeNamed);
  }

  @override
  void onInit() {
    super.onInit();
    getPostsFromApi();
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _bodyController.dispose();
    _searchController.dispose();
  }
}
