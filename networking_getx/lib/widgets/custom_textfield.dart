import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final titleLabel;
  final maxLength;
  final icon;
  final controller;
  final inputType;
  final Function fieldSubmit;
  final focusnode;
  final validator;
  final inputAction;
  var readOnly;
  final maxLines;
  final obsecureText;
  final String initValues;
  final Function onSaved;
  final style;
  final Function onChanged;

  CustomTextField(
      {this.onSaved,
      this.initValues,
      this.onChanged,
      this.style,
      @required this.titleLabel,
      this.maxLength,
      @required this.icon,
      this.validator,
      this.readOnly = false,
      this.controller,
      @required this.inputAction,
      this.focusnode,
      this.maxLines,
      this.obsecureText = false,
      this.fieldSubmit,
      @required this.inputType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        initialValue: initValues,
        maxLength: maxLength,
        controller: controller,
        onSaved: onSaved,
        keyboardType: inputType,
        validator: validator,
        style: style,
        obscureText: obsecureText,
        textInputAction: inputAction,
        readOnly: readOnly,
        onFieldSubmitted: fieldSubmit,
        maxLines: maxLines,
        onChanged: onChanged,
        focusNode: focusnode,
        decoration: InputDecoration(
          labelText: titleLabel,
          prefixIcon: Icon(
            icon,
            color: Theme.of(context).accentColor,
          ),
          labelStyle: Theme.of(context).textTheme.headline4.copyWith(
              fontSize: 14, fontWeight: FontWeight.w100, color: Colors.grey),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
          )),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
          )),
          contentPadding: EdgeInsets.only(left: 40, right: 40),
        ),
      ),
    );
  }
}
