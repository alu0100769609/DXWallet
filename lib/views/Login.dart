import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wallet_v2/components/appbar/LogoAppBar.dart';
import 'package:wallet_v2/components/login/InputText.dart';

import 'package:wallet_v2/constants/constants.dart';
import 'package:wallet_v2/constants/strings.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LogoAppBar(),
      body:  Column(
        children: [
          gapH30,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(login_str,
                  style:TextStyle(
                    fontSize: titleSize,
                    fontWeight: FontWeight.w500,
                  )
              )
            ],
          ),
          gapH50,
          const Text(userName_str),
          gapH10,
          const InputText(password: false),
          gapH20,
          const Text(password_str),
          gapH10,
          const InputText(password: true),
          gapH30,
          ElevatedButton(
              onPressed: ()=>{
                Fluttertoast.showToast(msg: enter_str)
              },
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all<Color>(colorLightGrey),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              child: const Text(enter_str,
              style: TextStyle(color: colorBlack),)
          ),

          Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
              child:SizedBox(
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(askNoAccount_str),
                      Padding(padding: const EdgeInsets.fromLTRB(10,0, 0, 0),
                        child:GestureDetector(
                          onTap: ()=>{
                            Fluttertoast.showToast(msg: goRegister_str)
                          },
                          child: const Text(goRegister_str,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: normalSize
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
              )
          ),
        ],
      ),

    );
  }
}
