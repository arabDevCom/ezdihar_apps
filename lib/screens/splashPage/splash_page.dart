import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/constants/app_constant.dart';
import 'package:ezdihar_apps/models/user_model.dart';
import 'package:ezdihar_apps/routes/app_routes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../colors/colors.dart';
import '../../models/chat_model.dart';
import 'cubit/splash_cubit.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is OnUserModelGet) {
          print("state.userModel.user.userType");
          print(state.userModel.user.userType);
          Future.delayed(const Duration(seconds: 2)).then(
            (value) => {
              if (AppRoutes.chatmodel != null)
                {
                  Navigator.of(context)
                      .pushNamed(AppConstant.pageChatRoute,
                          arguments: AppRoutes.chatmodel)
                      .then((value) => {
                            if (state.userModel.user.userType == 'freelancer')
                              {
                                Navigator.of(context).pushReplacementNamed(
                                    AppConstant.providerNavigationBottomRoute)
                              }
                            else
                              {
                                Navigator.of(context).pushReplacementNamed(
                                  AppConstant.pageHomeRoute,
                                  arguments: state.userModel,
                                )
                              }
                          })
                }
              else
                {
                  if (state.userModel.user.userType == 'freelancer')
                    {
                      Navigator.of(context).pushReplacementNamed(
                        AppConstant.providerNavigationBottomRoute,
                      )
                    }
                  else
                    {
                      Navigator.of(context).pushReplacementNamed(
                        AppConstant.pageHomeRoute,
                        arguments: state.userModel,
                      )
                    }
                }
            },
          );
        } else if (state is NoUserFound) {
          Future.delayed(const Duration(seconds: 2)).then(
            (value) => {
              Navigator.of(context).pushReplacementNamed(
                AppConstant.pageHomeRoute,
                arguments: UserModel(),
              )
            },
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Container(
            color: AppColors.grey2,
            child: Center(
                child: Container(
              width: 225.0,
              height: 80.0,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image:
                          AssetImage('${AppConstant.localImagePath}logo.png'),
                      fit: BoxFit.cover)),
            )),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    // Future.delayed(const Duration(seconds: 3)).then(
    //       (value) =>
    //   {
    //     Navigator.of(context).pushReplacementNamed(AppConstant.pageHomeRoute)
    //   },
    // );
  }
}
