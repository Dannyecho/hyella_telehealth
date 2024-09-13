import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyella_telehealth/core/constants/app_colors2.dart';
import 'package:hyella_telehealth/core/constants/app_constants.dart';
import 'package:hyella_telehealth/core/global.dart';
import 'package:hyella_telehealth/logic/bloc/welcome_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/welcome_event.dart';
import 'package:hyella_telehealth/logic/bloc/welcome_state.dart';
import 'package:hyella_telehealth/presentation/route/app_route.dart';

part 'widgets/welcome_slide_item.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: BlocBuilder<WelcomeBloc, WelcomeState>(
            builder: (context, state) {
              return Stack(
                alignment: Alignment.topCenter,
                children: [
                  PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      state.slideIndex = index;
                      BlocProvider.of<WelcomeBloc>(context).add(WelcomeEvent());
                    },
                    children: [
                      WelcomeSlideItem(
                          title: "HYELLA TeleHealth",
                          subTitle:
                              "Discover a new level of health care with HYELLA TelehHealth. Connect with trusted Doctors and enjoy.",
                          imgPath: 'assets/images/1.jpg',
                          onPressed: () {
                            state.slideIndex = 1;

                            _pageController.animateToPage(
                              state.slideIndex,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.decelerate,
                            );

                            BlocProvider.of<WelcomeBloc>(context)
                                .add(WelcomeEvent());
                          }),
                      WelcomeSlideItem(
                          title: "Take Control",
                          subTitle:
                              "Empowering you take control. HYELLA TeleHealth offers expert medical advice and support right at your fingertip",
                          imgPath: "assets/images/2.jpg",
                          onPressed: () {
                            state.slideIndex = 2;

                            _pageController.animateToPage(
                              state.slideIndex,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.decelerate,
                            );

                            BlocProvider.of<WelcomeBloc>(context)
                                .add(WelcomeEvent());
                          }),
                      WelcomeSlideItem(
                        title: "You Deserve the Best",
                        subTitle:
                            "Experience convienient. Connect with doctors, manage appointments, and monitor your health effortlessly.",
                        imgPath: 'assets/images/3.jpg',
                        buttonTitle: "Get Started",
                        onPressed: () {
                          Global.storageService.setBool(
                            AppConstants.STORAGE_DEVICE_FOR_THE_FIRST_TIME,
                            true,
                          );
                          Navigator.pushNamedAndRemoveUntil(
                              context, AppRoute.signIn, (route) => false);
                        },
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 30,
                    child: DotsIndicator(
                      dotsCount: 3,
                      position: state.slideIndex,
                      decorator: DotsDecorator(
                          color: Colors.grey,
                          size: const Size.square(8),
                          activeColor: AppColors2.color1,
                          activeSize: const Size(18, 8),
                          activeShape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          )),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
