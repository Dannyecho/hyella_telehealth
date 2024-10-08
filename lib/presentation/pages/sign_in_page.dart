import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hyella_telehealth/core/constants/app_colors2.dart';
import 'package:hyella_telehealth/data/repository/entities/endpoint_entity.dart';
import 'package:hyella_telehealth/logic/bloc/endpoint_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/sign_in_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/sign_in_event.dart';

import 'package:hyella_telehealth/logic/bloc/sign_in_state.dart';
import 'package:hyella_telehealth/logic/controllers/sign_in_controller.dart';
import 'package:hyella_telehealth/presentation/pages/widgets/sign_in_widgets.dart';
import 'package:hyella_telehealth/presentation/route/app_route.dart';
import 'package:hyella_telehealth/presentation/widgets/reuseable.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String userType = 'user_mgt_login';
  bool isStaff = false;
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passWordFocusNode = FocusNode();
  EndPointEntityData? endpoint;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    endpoint = context.read<EndpointBloc>().state.endPointEntity?.data;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      /* appBar: buildAppBar(
        title: "Sign In",
      ), */
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 60,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/med.png',
              ),
              fit: BoxFit.fitWidth,
              // opacity: .2,
              alignment: Alignment.bottomLeft,
              // colorFilter: ColorFilter.linearToSrgbGamma(),
            ),
          ),
          child: BlocBuilder<SignInBloc, SignInState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * .1,
                    ),
                    alignment: Alignment.center,
                    decoration:
                        BoxDecoration(color: Colors.white.withOpacity(.15)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /* buildThirdPartyLogin(context),
                        Center(
                          child: reuseableText("Or login with your email account"),
                        ), */
                        Center(
                          child: Column(
                            children: [
                              Text(
                                endpoint?.client?.name ?? "Sign In",
                                // textAlign: TextAlign.center,
                                style: GoogleFonts.satisfy(
                                  color: AppColors2.color1,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CachedNetworkImage(
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                imageUrl: context
                                    .read<EndpointBloc>()
                                    .state
                                    .endPointEntity!
                                    .data!
                                    .client!
                                    .logo!,
                              ),
                              const Text(
                                "Welcome",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              reuseableText(
                                "Please provide your login details",
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Form(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // reuseableText('Email'),
                              buildTextField(
                                focusNode: _emailFocusNode,
                                type: 'text',
                                hintText: 'Email Address',
                                icon: Icon(
                                  Icons.email_outlined,
                                  color: AppColors2.color1,
                                ),
                                onChange: (value) {
                                  context.read<SignInBloc>().add(
                                        EmailEvent(email: value),
                                      );
                                },
                                onSubmitted: (value) {
                                  if (value.isNotEmpty) {
                                    _passWordFocusNode.requestFocus();
                                  } else {
                                    _emailFocusNode.requestFocus();
                                  }
                                },
                              ),
                              // reuseableText('Password'),
                              buildTextField(
                                focusNode: _passWordFocusNode,
                                type: 'password',
                                hintText: 'Password',
                                icon: Icon(
                                  Icons.lock_outline,
                                  color: Theme.of(context).primaryColor,
                                ),
                                onChange: (value) {
                                  context.read<SignInBloc>().add(
                                        PasswordEvent(password: value),
                                      );
                                },
                                onSubmitted: (p0) {
                                  final signInController =
                                      SignInController(context);
                                  signInController.handleSignIn();
                                },
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                    value: state.isStaff,
                                    checkColor: Theme.of(context).primaryColor,
                                    activeColor: Colors.white,
                                    onChanged: (value) {
                                      context
                                          .read<SignInBloc>()
                                          .add(IsStaffEvent(isStaff: value!));
                                    },
                                  ),
                                  const Text(
                                    "I am a health service provider",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),

                              forgotPassword(context),
                              loginAndRegisterButton(
                                  text: "Login",
                                  type: 'login',
                                  onTap: () {
                                    final signInController =
                                        SignInController(context);
                                    signInController.handleSignIn();
                                  }),

                              /* loginAndRegisterButton(
                                  text: "Register",
                                  type: 'register',
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed(AppRoute.register);
                                  }), */
                            ],
                          ),
                        ),
                        // const Spacer(),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      bottomSheet: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topRight: Radius.circular(60))),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Don't have an account yet? ",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(
                  context,
                  AppRoute.register,
                ),
                child: Text(
                  "REGISTER",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ],
          ),
        ]),
      ),
    ));
  }
}
