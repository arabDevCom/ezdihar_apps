import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/colors/colors.dart';
import 'package:ezdihar_apps/constants/app_constant.dart';
import 'package:ezdihar_apps/models/user_model.dart';
import 'package:ezdihar_apps/screens/user/consultant_details_screen/cubit/consultant_details_cubit.dart';
import 'package:ezdihar_apps/widgets/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ConsultantDetailsPage extends StatefulWidget {
  final int consultant_id;

  ConsultantDetailsPage({Key? key, required this.consultant_id})
      : super(key: key);

  @override
  State<ConsultantDetailsPage> createState() =>
      _ConsultantDetailsPageState(consultant_id);
}

class _ConsultantDetailsPageState extends State<ConsultantDetailsPage> {
  int consultant_id;

  _ConsultantDetailsPageState(this.consultant_id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: Text(
          'consultantDetails'.tr(),
          style: const TextStyle(
              color: AppColors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.bold),
        ),
        leading: AppWidget.buildBackArrow(context: context),
      ),
      backgroundColor: AppColors.grey3,
      body: _buildBodySection(),
    );
  }

  Widget _buildBodySection() {
    ConsultantDetailsCubit cubit = BlocProvider.of<ConsultantDetailsCubit>(context);
    double width = MediaQuery.of(context).size.width;
    String lang = EasyLocalization.of(context)!.locale.languageCode;
    cubit.getData(consultant_id);

    return BlocBuilder<ConsultantDetailsCubit, ConsultantDetailsState>(
      builder: (context, state) {
        if (state is IsLoading)
        {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.colorPrimary,
            ),
          );
        } else if
        (state is OnError) {
          return Center(
            child: Text(
              'something_wrong'.tr(),
              style: TextStyle(fontSize: 15.0, color: AppColors.black),
            ),
          );
        } else {
          OnDataSuccess onSuccess = state as OnDataSuccess;
          UserModel userModel = onSuccess.model;
          return Column(
            children: [
              Expanded(
                  child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [
                  const SizedBox(
                    height: 16.0,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: userModel.user.image.isNotEmpty
                        ? CachedNetworkImage(
                            width: 144.0,
                            height: 144.0,
                            imageUrl: userModel.user.image,

                            imageBuilder: (context, imageProvider) =>
                                CircleAvatar(
                              backgroundImage: imageProvider,
                            ),
                            placeholder: (context, url) =>
                                AppWidget.circleAvatar(144.0, 144.0),
                            errorWidget: (context, url, error) =>
                                AppWidget.circleAvatar(144.0, 144.0),
                          )
                        : AppWidget.circleAvatar(144.0, 144.0),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      '${userModel.user.firstName + " " + userModel.user.lastName}',
                      style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black),
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      userModel.adviser_data != null
                          ? lang == 'ar'
                              ? userModel
                                  .adviser_data!.consultant_type.title_ar
                              : userModel
                                  .adviser_data!.consultant_type.title_en
                          : "",
                      style: const TextStyle(
                          fontSize: 12.0, color: AppColors.colorPrimary),
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: _buildRateBar(
                          rate: userModel.adviser_data != null
                              ? userModel.adviser_data!.rate.toDouble()
                              : 0)),
                  const SizedBox(
                    height: 24.0,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Transform.rotate(
                        angle: lang == 'ar' ? 3.14 : 0,
                        child: const SizedBox(
                            width: 12.0,
                            height: 25,
                            child: DecoratedBox(
                                decoration: BoxDecoration(
                                    color: AppColors.color1,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(12.0),
                                        bottomRight:
                                            Radius.circular(12.0))))),
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'bio'.tr(),
                              style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.black),
                            ),
                            const SizedBox(
                              height: 2.0,
                            ),
                            Text(
                              '${userModel.adviser_data != null ? userModel.adviser_data!.bio : ""}',
                              style: const TextStyle(
                                  fontSize: 14.0, color: AppColors.grey1),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.all(16.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                        color: AppColors.color4,
                        borderRadius: BorderRadius.circular(16.0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            _buildDetailsSection(
                                svgName: 'offers.svg',
                                title: 'consultationPrice'.tr(),
                                count:
                                    '${userModel.adviser_data != null ? userModel.adviser_data!.consultant_price : "0.0"}',
                                content: 'sar'.tr()),
                            _buildDetailsSection(
                                svgName: 'users.svg',
                                title: 'consultations'.tr(),
                                count:
                                    '${userModel.adviser_data != null ? userModel.adviser_data!.count_people : "0"}',
                                content: 'user'.tr())
                          ],
                        ),
                        const SizedBox(
                          height: 24.0,
                        ),
                        Row(
                          children: [
                            _buildDetailsSection(
                                svgName: 'job.svg',
                                title: 'yearsExperience'.tr(),
                                count:
                                    '${userModel.adviser_data != null ? userModel.adviser_data!.years_ex : "0"}',
                                content: 'years'.tr()),
                            _buildDetailsSection(
                                svgName: 'collage.svg',
                                title: 'graduationRate'.tr(),
                                count: userModel.adviser_data != null
                                    ? userModel.adviser_data!.graduation_rate
                                    : "",
                                content: '')
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              )),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, AppConstant.pageRequestConsultationRoute,arguments: cubit.userModel);
                },
                child: Container(
                  width: width,
                  height: 56.0,
                  decoration: const BoxDecoration(
                      color: AppColors.color1,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24.0),
                          topRight: Radius.circular(24.0))),
                  child: Center(
                      child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'requestConsultationNow'.tr(),
                        style: const TextStyle(
                            fontSize: 16.0, color: AppColors.white),
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      AppWidget.svg(
                          'question_mark.svg', AppColors.white, 24.0, 24.0)
                    ],
                  )),
                ),
              )
            ],
          );
        }
      },
    );
  }

  Widget _buildDetailsSection(
      {required svgName,
      required String title,
      required String count,
      required String content}) {
    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 12.0, color: AppColors.grey1),
        ),
        const SizedBox(
          height: 5.0,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppWidget.svg(svgName, AppColors.colorPrimary, 24.0, 24.0),
            const SizedBox(
              width: 8.0,
            ),
            RichText(
                text: TextSpan(
                    text: count,
                    style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black),
                    children: [
                  TextSpan(
                      text: content,
                      style: const TextStyle(
                          fontSize: 12.0, color: AppColors.black))
                ]))
          ],
        )
      ],
    ));
  }

  Widget _buildRateBar({required double rate}) {
    return RatingBar.builder(
        itemCount: 5,
        direction: Axis.horizontal,
        itemSize: 22,
        maxRating: 5,
        allowHalfRating: true,
        initialRating: rate,
        tapOnlyMode: false,
        ignoreGestures: true,
        minRating: 0,
        unratedColor: AppColors.grey1,
        itemBuilder: (context, index) {
          return const Icon(
            Icons.star_rate_rounded,
            color: AppColors.colorPrimary,
          );
        },
        onRatingUpdate: (rate) {});
  }
}
