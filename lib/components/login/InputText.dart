import 'package:flutter/material.dart';
import 'package:wallet_v2/constants/constants.dart';
class InputText extends StatelessWidget implements PreferredSizeWidget{
  final bool password;
  const InputText ({Key? key, required this.password }) : super(key: key);
  @override
  Widget build (BuildContext context){
    return  SizedBox(
      height: 30,
      child:  FractionallySizedBox(
        widthFactor: 0.75,
        child: TextField(
          obscureText: password,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colorPrimary, width: 2.0)
            ),
            enabledBorder:  OutlineInputBorder(
                borderSide: BorderSide(color: colorPrimaryDark, width: 1.0)
            ),
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();

}