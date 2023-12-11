import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proyecto_c2/consts.dart';
import 'package:proyecto_c2/features/domain/entities/user/user_entity.dart';
import 'package:proyecto_c2/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:proyecto_c2/features/presentation/cubit/credentail/credential_cubit.dart';
import 'package:proyecto_c2/features/presentation/page/main_screen/main_screen.dart';
import 'package:proyecto_c2/features/presentation/widgets/button_container_widget.dart';
import 'package:proyecto_c2/features/presentation/widgets/form_container_widget.dart';
import 'package:proyecto_c2/profile_widget.dart';
import 'package:proyecto_c2/injection_container.dart' as di;
class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _bioController = TextEditingController();

  bool _isSigningUp = false;
  bool _isUploading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  File? _image;

  Future selectImage() async {
    try {
      final pickedFile = await ImagePicker.platform.getImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print("no image has been selected");
        }
      });

    } catch(e) {
      toast("some error occured $e");
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backGroundColor,
        body: BlocConsumer<CredentialCubit, CredentialState>(
          listener: (context, credentialState) {
            if (credentialState is CredentialSuccess) {
              BlocProvider.of<AuthCubit>(context).loggedIn();
            }
            if (credentialState is CredentialFailure) {
              toast("Invalid Email and Password");
            }
          },
          builder: (context, credentialState) {
            if (credentialState is CredentialSuccess) {
              return BlocBuilder<AuthCubit, AuthState>(
                builder: (context, authState) {
                  if (authState is Authenticated) {
                    return MainScreen(uid: authState.uid);
                  } else {
                    return _bodyWidget();
                  }
                },
              );
            }
            return _bodyWidget();
          },
        )
    );
  }

  
  _bodyWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Container(),
            flex: 2,
          ),
          Center(child: SvgPicture.asset("assets/ARTTECH.svg", color: primaryColor,)),
          sizeVer(15),
          Center(
            child: Stack(
              children: [
                Container(
                  width: 60,
                  height: 60,

                  child: ClipRRect(borderRadius: BorderRadius.circular(30),child: profileWidget(image: _image))
                ),
                Positioned(
                  right: -10,
                  bottom: -15,
                  child: IconButton(
                    onPressed: selectImage,
                    icon: Icon(Icons.add_a_photo, color: blueColor,),
                  ),
                ),
              ],

            ),
          ),
          sizeVer(30),
          FormContainerWidget(
            controller: _usernameController,
            hintText: "Username",
          ),
          sizeVer(15),
          FormContainerWidget(
            controller: _emailController,
            hintText: "Email",
          ),
          sizeVer(15),
          FormContainerWidget(
            controller: _passwordController,
            hintText: "Password",
            isPasswordField: true,
          ),
          sizeVer(15),

          FormContainerWidget(
            controller: _bioController,
            hintText: "Bio",
          ),
          sizeVer(15),
          ButtonContainerWidget(
            color: blueColor,
            text: "Sign Up",
            onTapListener: () {
              _signUpUser();
            },
          ),
          sizeVer(10),
          _isSigningUp == true || _isUploading == true ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Please wait", style: TextStyle(color: primaryColor, fontSize: 16, fontWeight: FontWeight.w400),),
              sizeHor(10),
              CircularProgressIndicator()
            ],
          ) : Container(width: 0, height: 0,),
          Flexible(
            child: Container(),
            flex: 2,
          ),
          Divider(
            color: secondaryColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Already have an account? ", style: TextStyle(color: primaryColor),),
              InkWell(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(context, PageConst.signInPage, (route) => false);

                  // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SignInPage()), (route) => false);
                },
                child: Text(
                  "Sign In.",
                  style: TextStyle(fontWeight: FontWeight.bold, color: primaryColor),
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }

 /*Widget _bodyWidget() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 22, vertical: 35),
        child: Column(
          children: <Widget>[
            SizedBox(
              width: 292,
              height: 60,
            ),
            Container(
              child: Text(
                'Registro',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFAA5EB7),
                  fontSize: 36,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              thickness: 2,
              endIndent: 15,
              indent: 15,
            ),
            SizedBox(
              height: 30,
            ),
            /*GestureDetector(
              onTap: () async {
                getImage();
              },
              child: Column(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(214, 241, 246, 1),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        child: profileWidget(image: _image)),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Agregar una foto de perfil',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: darkPrimaryColor),
                  ),
                ],
              ),
            ),*/
            TextFieldContainer(
              controller: _usernameController,
              keyboardType: TextInputType.text,
              hintText: 'Nombre de usuario',
              prefixIcon: Icons.person,
            ),
            SizedBox(
              height: 30,
            ),
            TextFieldContainer(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              hintText: 'Correo electrónico',
              prefixIcon: Icons.mail,
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 44,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: color747480.withOpacity(.2),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: TextField(
                obscureText: _isShowPassword,
                controller: _passwordController,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    hintText: 'Contraseña',
                    border: InputBorder.none,
                    suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isShowPassword =
                                _isShowPassword == false ? true : false;
                          });
                        },
                        child: Icon(_isShowPassword == false
                            ? Icons.remove_red_eye
                            : Icons.panorama_fish_eye))),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 44,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: color747480.withOpacity(.2),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: TextField(
                obscureText: _isShowPassword,
                controller: _passwordAgainController,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock,
                    ),
                    hintText: 'Contraseña (Repetir)',
                    hintStyle: TextStyle(color: Colors.black.withOpacity(0.3)),
                    border: InputBorder.none,
                    suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isShowPassword =
                                _isShowPassword == false ? true : false;
                          });
                        },
                        child: Icon(_isShowPassword == false
                            ? Icons.remove_red_eye
                            : Icons.panorama_fish_eye))),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            /* GestureDetector(
              onTap: _modalBottomSheetDate,
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                    color: color747480.withOpacity(.2),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: AbsorbPointer(
                  child: TextField(
                    controller: _dobController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.date_range),
                      hintText: 'Fecha de nacimiento',
                      suffixIcon: Icon(Icons.keyboard_arrow_down_sharp),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ), 
            SizedBox(
              height: 10,
            ),*/
            
            /* GestureDetector(
              onTap: _genderModalBottomSheetMenu,
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                    color: color747480.withOpacity(.2),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: AbsorbPointer(
                  child: TextField(
                    controller: _genderController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.people_alt),
                      hintText: 'Género',
                      suffixIcon: Icon(Icons.keyboard_arrow_down_sharp),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ), */
            SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                _submitSignUp();
              },
              child: Container(
                  width: 250,
                  height: 50,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 250,
                          height: 50,
                          decoration: ShapeDecoration(
                            color: Color(0xFFAA5EB7),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 58.96,
                        top: 13,
                        child: SizedBox(
                          width: 139.17,
                          height: 25,
                          child: Text(
                            'Registrarme',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '¿Ya tienes cuenta? ',
                    style: TextStyle(color: Color(0xFF6F6F6F), fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, PageConst.loginPage, (route) => false);
                    },
                    child: Text(
                      'Inicia sesión',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFAA5EB7)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 150,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Al hacer click en "registrarme", aceptas ',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF6F6F6F)),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'los ',
                    style: TextStyle(
                        color: Color(0xFF6F6F6F),
                        fontSize: 12,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    'términos y condiciones ',
                    style: TextStyle(
                        color: Color.fromARGB(255, 18, 148, 218),
                        fontSize: 12,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    'de uso.',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF6F6F6F)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }*/


  Future<void> _signUpUser() async {
    setState(() {
      _isSigningUp = true;
    });
    BlocProvider.of<CredentialCubit>(context).signUpUser(
        user: UserEntity(
          email: _emailController.text,
          password: _passwordController.text,
          bio: _bioController.text,
          username: _usernameController.text,
          totalPosts: 0,
          totalFollowing: 0,
          followers: [],
          totalFollowers: 0,
          website: "",
          following: [],
          name: "",
          imageFile: _image
        )
    ).then((value) => _clear());
  }

  _clear() {
    setState(() {
      _usernameController.clear();
      _bioController.clear();
      _emailController.clear();
      _passwordController.clear();
      _isSigningUp = false;
    });
  }

  /*_submitSignUp() {
    if (_emailController.text.isEmpty) {
      toast('Ingresa un correo electronico');
      return;
    }
    if (_passwordController.text.isEmpty) {
      toast('Ingresa una contraseña');
      return;
    }

    if (_passwordAgainController.text.isEmpty) {
      toast('Repite la contraseña');
      return;
    }

    if (_passwordController.text == _passwordAgainController.text) {
    } else {
      toast("Ambas contraseñas deben ser iguales");
      return;
    }

    BlocProvider.of<CredentialCubit>(context).signUpSubmit(
      user: UserEntity(
        id: -1,
        email: _emailController.text,
        //profileUrl: _profileUrl!,
        password: _passwordController.text,
        isOnline: false,
        status: "Hola! Estoy usando esta aplicación :)",
      ),
    );
  }*/
}
