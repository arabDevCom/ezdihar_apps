import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../../../../constants/app_constant.dart';
import '../../../../../../../models/provider_order.dart';
import '../../../../../../../widgets/app_widgets.dart';



class ItemsOrders {
  Widget _buildAvatar({required double width, required double height}) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(width),
        child: Image.asset(
          "${AppConstant.localImagePath}avatar.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget buildListItem({required BuildContext context,
    required ProviderOrder model,
    required int index}) {
    String lang = EasyLocalization
        .of(context)!
        .locale
        .languageCode;
    return Card(
      color: AppColors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
      elevation: 1.0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              leading: model.user.user.image.isNotEmpty ? CachedNetworkImage(
                imageUrl: model.user.user.image,
                placeholder: (context, url) =>
                    _buildAvatar(width: 48.0, height: 48.0),
                errorWidget: (context, url, error) =>
                    _buildAvatar(width: 48.0, height: 48.0),
                width: 48,
                height: 48,
                imageBuilder: (context, imageProvider) {
                  return CircleAvatar(
                    backgroundImage: imageProvider, radius: 48.0,);
                },
              ) : _buildAvatar(width: 48.0, height: 48.0),
              title: Text(
                '${model.user.user.firstName + " " + model.user.user.lastName}',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                    color: AppColors.black),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: _buildRateBar(rate: .5),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'details'.tr(),
                    style: const TextStyle(
                        fontSize: 14.0, color: AppColors.color1),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Transform.rotate(
                      angle: lang == 'ar' ? 3.14 : 0,
                      child: AppWidget.svg(
                          'arrow.svg', AppColors.color1, 24.0, 24.0))
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'servicePrice'.tr(),
                          style: const TextStyle(
                              fontSize: 12.0, color: AppColors.grey6),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AppWidget.svg(
                                'offers.svg', AppColors.colorPrimary, 24.0,
                                24.0),
                            const SizedBox(width: 8,),
                            RichText(
                              text: TextSpan(
                                  text: '${model.price}',
                                  style: const TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.black),
                                  children: [
                                    TextSpan(
                                        text: 'sar'.tr(),
                                        style: const TextStyle(
                                            fontSize: 12.0,
                                            color: AppColors.black))
                                  ]
                              ),
                            )
                          ],
                        )
                      ],
                    )),
                Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'delivery_date'.tr(),
                          style: const TextStyle(
                              fontSize: 12.0, color: AppColors.grey6),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AppWidget.svg(
                                'calender.svg', AppColors.colorPrimary, 24.0,
                                24.0),
                            const SizedBox(width: 8,),
                            RichText(
                              text: TextSpan(
                                  text: model.delivery_date,
                                  style: const TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.black),
                                  children: [

                                  ]
                              ),
                            )
                          ],
                        )
                      ],
                    )),

              ],
            ),
            const SizedBox(height: 8.0,)
          ],
        ),
      ),
    );
  }

  Widget _buildRateBar({required double rate}) {
    return RatingBar.builder(
        itemCount: 5,
        direction: Axis.horizontal,
        itemSize: 20,
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