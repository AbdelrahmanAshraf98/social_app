import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast({@required String msg, @required Color color}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0);
}

Widget defaultTextButton({
  @required String text,
  @required Function fn,
}) {
  return TextButton(onPressed: fn, child: Text(text.toUpperCase(),style: TextStyle(
    color: Colors.deepPurple,
    fontWeight: FontWeight.w600,
  ),));
}

Widget defaultTextFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  @required Function onValidation,
  @required String label,
  @required IconData prefix,
  IconData suffix,
  bool isPassword = false,
  Function suffixFn,
}) =>
    TextFormField(
      obscureText: isPassword,
      controller: controller,
      keyboardType: type,
      validator: onValidation,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(suffix),
                onPressed: suffixFn,
              )
            : null,
      ),
    );

Widget defaultMaterialButton({
  @required String text,
  @required Function fn,
  context,
}) =>
    Container(
        width: double.infinity,
        height: 50.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Theme.of(context).primaryColor,
        ),
        child: MaterialButton(
          onPressed: fn,
          child: Text(
            text.toUpperCase(),
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ));

navigateTo(Widget route, context) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => route,
    ));

navigateAndFinish(Widget route, context) => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => route,
        ), (route) {
      return false;
    });
