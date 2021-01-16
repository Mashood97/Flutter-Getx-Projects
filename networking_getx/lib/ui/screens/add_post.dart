import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:networking_getx/ui/controllers/post_controller.dart';
import 'package:networking_getx/ui/models/Post.dart';
import 'package:networking_getx/widgets/custom_textfield.dart';
import 'package:networking_getx/widgets/loading.dart';

class AddPost extends StatelessWidget {
  static const routeNamed = '/add-post';
  final PostController _controller = Get.find();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
//        elevation: 0.0,
        bottomOpacity: 0.05,
        title: Text(
          'Add Post',
          style: Theme.of(context).textTheme.headline4.copyWith(
                fontSize: 20.0,
              ),
        ),
        actions: [
          IconButton(
            splashColor: Colors.pink,
            splashRadius: 30,
            icon: Icon(
              Icons.save,
              color: Colors.black,
              size: 40,
              semanticLabel: 'Save',
            ),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _controller.postPost(Post(
                  title: _controller.titleController.text.toString(),
                  body: _controller.bodyController.text.toString(),
                  userId: 1,
                ));
                _controller.titleController.clear();
                _controller.bodyController.clear();
              } else {
                _controller
                    .showSnackBar('Please enter all required (*) fields');
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(
          () => _controller.isLoading
              ? Loading()
              : Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextField(
                        titleLabel: 'Enter title of post *',
                        icon: Icons.post_add,
                        inputType: TextInputType.text,
                        controller: _controller.titleController,
                        inputAction: TextInputAction.done,
                        validator: (value) => value.isEmpty
                            ? 'Please enter title of the post'
                            : null,
                        maxLength: 20,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      CustomTextField(
                        titleLabel: 'Enter body of post *',
                        icon: Icons.comment,
                        controller: _controller.bodyController,
                        validator: (value) => value.isEmpty
                            ? 'Please enter body of the post'
                            : null,
                        inputType: TextInputType.text,
                        inputAction: TextInputAction.done,
                        maxLength: 50,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
