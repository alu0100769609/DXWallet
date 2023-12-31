import 'package:flutter/material.dart';

/************** Este archivo contiene las siguientes constantes: **************/

/// Colors: Para controlar los colores personalizados
/// Routes: Para conexiones internas y externas
/// RegExp: Para expresiones regulares
/// Text Size: Para controlar los tamaños de los textos
/// Empty boxes: Para separar elementos

/**************** ************** ************** ************** ****************/
/// DEBUG MODE
const bool DEBUGMODE = false;


/// Colors: Para controlar los colores personalizados
const Color CUSTOM_LIGHT_GREY = Color.fromRGBO(216, 224, 231, 1);
const Color CUSTOM_BLACK = Colors.black;

// COLORES DEL LOGO

// Morado Fondo: #341134
const Color CUSTOM_PRIMARY_DARK = Color.fromRGBO(52, 17, 52, 1);
// Azul Claro: #AADCDC
const Color CUSTOM_SECONDARY = Color.fromRGBO(170, 220, 220, 1);
// Azul Oscuro: #198BBD
const Color CUSTOM_SECONDARY_DARK = Color.fromRGBO(25, 139, 189, 1);
// Rosa Claro: #FF66C4
const Color CUSTOM_LIGHT_PINK = Color.fromRGBO(255, 102, 196, 1);
// Rosa Oscuro: #C700FF
const Color CUSTOM_PRIMARY = Color.fromRGBO(199, 0, 255, 1);
// Gris CLARO: #A6A5A5FF
const Color DISABLED_COLOR = Color.fromRGBO(166, 165, 165, 1);
// Verde Válido: #1ABD1AFF
const Color VALID_GREEN = Color.fromRGBO(26, 189, 26, 1.0);
// Azul Enlaces: #198BBD
const Color LINK_BLUE = Color.fromRGBO(25, 139, 189, 1);


/// Routes: Para conexiones internas y externas
const String TERMS_URL = 'http://adexe.sebt.es/page/terms.php';
const String LOGIN_URL = 'https://sebt.es/adexe/dxwallet/app/login.php';
const String REGISTER_URL = 'https://sebt.es/adexe/dxwallet/app/register.php';
const String GET_VISAS_URL = 'https://sebt.es/adexe/dxwallet/app/getListOfVisas.php';
const String GET_CURRENCIES_URL = 'https://sebt.es/adexe/dxwallet/app/getCurrencies.php';
//const String GET_VISA_NUMBER_URL = 'https://sebt.es/adexe/dxwallet/app/getVisaNumber.php';
const String ADD_NEW_VISA_URL = 'https://sebt.es/adexe/dxwallet/app/addNewVisa.php';
const String GET_VISA_DATA_URL = 'https://sebt.es/adexe/dxwallet/app/getVisa.php';
const String GET_MOVEMENTS_URL = 'https://sebt.es/adexe/dxwallet/app/getListOfMovements.php';
const String INCREASE_AMOUNT_URL = 'https://sebt.es/adexe/dxwallet/app/increaseAmount.php';
const String PAY_URL = 'https://sebt.es/adexe/dxwallet/app/pay.php';
const String CREATE_BILL_AND_MOVEMENT_URL = 'https://sebt.es/adexe/dxwallet/app/createBillAndMovement.php';
const String GET_USER_DATA_URL = 'https://sebt.es/adexe/dxwallet/app/getUserData.php';
const String MODIFY_USER_DATA_URL = 'https://sebt.es/adexe/dxwallet/app/modifyUserData.php';
const String CHANGE_PASSWORD_URL = 'https://sebt.es/adexe/dxwallet/app/changePassword.php';

const String LARGE_LOGO_ROUTE = "assets/images/LogoAlargado.jpg";
const String SMALL_LOGO_ROUTE = "assets/images/LogoCuadrado.png";
const String BLUE_CREDIT_CARD = "assets/images/TarjetaAzul.png";
const String RED_CREDIT_CARD = "assets/images/TarjetaRoja.png";
const String PROFILE_PHOTO = "assets/images/Person.png";

/// RegExp: Para expresiones regulares
const String REGEXP_VALIDATE_EMAIL = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

/// Text Size: Para controlar los tamaños de los textos
const double TITLE_SIZE = 30;
const double SUBTITLE_SIZE = 20;
const double NORMAL_SIZE = 15;
const double SMALL_SIZE = 10;

/// Empty boxes: Para separar elementos
// Caja vacía para "simular vacío"
const SizedBox EMPTY_BOX = SizedBox();

// Cajas vacías para la separación en filas
const SizedBox gapH5 = SizedBox(height: 5);
const SizedBox gapH10 = SizedBox(height: 10);
const SizedBox gapH20 = SizedBox(height: 20);
const SizedBox gapH30 = SizedBox(height: 30);
const SizedBox gapH40 = SizedBox(height: 40);
const SizedBox gapH50 = SizedBox(height: 50);

// Cajas vacías para la separación en columnas
const SizedBox gapW5 = SizedBox(width: 5);
const SizedBox gapW10 = SizedBox(width: 10);
const SizedBox gapW20 = SizedBox(width: 20);
const SizedBox gapW30 = SizedBox(width: 30);
const SizedBox gapW40 = SizedBox(width: 40);
const SizedBox gapW50 = SizedBox(width: 50);
