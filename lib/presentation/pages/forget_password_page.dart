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

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});
  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  String userType = 'user_mgt_login';
  bool isStaff = false;
  final FocusNode _emailFocusNode = FocusNode();
  EndPointEntityData? endpoint;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    endpoint = context.read<EndpointBloc>().state.endPointEntity?.data;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          // appBar: buildAppBar(
          //   title: "Forget Password",
          // ),
          body: BlocBuilder<SignInBloc, SignInState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/5.jpg',
                      ),
                      fit: BoxFit.fitHeight,
                      // opacity: .2,
                      alignment: Alignment.bottomLeft,
                      colorFilter: ColorFilter.linearToSrgbGamma(),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.85),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        /* buildThirdPartyLogin(context),
                              Center(
                                child: reuseableText("Or login with your email account"),
                              ), */
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          endpoint?.client?.name ?? "Forget Password",
                          textAlign: TextAlign.center,
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
                                .logo!),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Recover Password",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        reuseableText(
                          "Please provide your email to recover your password",
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Form(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // reuseableText('Email'),
                              CheckboxListTile(
                                contentPadding: const EdgeInsets.all(0),
                                title: Text(
                                  "I'm a health provider",
                                  style: TextStyle(
                                    color: AppColors2.color1,
                                  ),
                                ),
                                value: state.isStaff,
                                onChanged: (value) {
                                  context
                                      .read<SignInBloc>()
                                      .add(IsStaffEvent(isStaff: value!));
                                },
                              ),
                              buildTextField(
                                focusNode: _emailFocusNode,
                                type: 'text',
                                hintText: 'Enter your email address',
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Theme.of(context).primaryColor,
                                ),
                                onChange: (value) {
                                  context.read<SignInBloc>().add(
                                        EmailEvent(email: value),
                                      );
                                },
                                onSubmitted: (value) {
                                  final signInController =
                                      SignInController(context);
                                  signInController.handleForgetPassword();
                                },
                              ),
                              loginAndRegisterButton(
                                  text: "Reset Password",
                                  type: 'login',
                                  onTap: () {
                                    final signInController =
                                        SignInController(context);
                                    signInController.handleForgetPassword();
                                  }),
                            ],
                          ),
                        ),
                        // const Spacer(),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          bottomSheet: Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(60)),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(33, 158, 158, 158),
                  offset: Offset(1, -1),
                  blurRadius: 1,
                  spreadRadius: 2,
                )
              ],
            ),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Already have an account? ",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoute.signIn,
                      (predicate) => false,
                    ),
                    child: Text(
                      "SIGN IN",
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
        ),
      ),
    );
  }
}
