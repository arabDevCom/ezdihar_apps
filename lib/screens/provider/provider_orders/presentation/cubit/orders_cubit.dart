import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../models/provider_order.dart';
import '../../../../../models/status_resspons.dart';
import '../../../../../models/user_model.dart';
import '../../../../../preferences/preferences.dart';
import '../../../../../remote/service.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersInitial()) {
    api = ServiceApi();
    onUserDataSuccess();
  }

  late ServiceApi api;
  UserModel? user;
  int page = 0;
  MainOrdersModel? mainAcceptOrders;
  MainOrdersModel? mainCompletedOrders;
  String lan = 'ar';

  getLan(context) {
    lan = EasyLocalization.of(context)!.locale.languageCode;
  }


  Future<void> getProviderAcceptOrder() async {
    emit(OrdersLoading());
    var model = await api.getProviderAcceptOrder(user!.access_token, lan);
    mainAcceptOrders = model;
    emit(OrdersLoaded(model));
  }

  Future<void> getProviderCompletedOrder() async {
    emit(OrdersLoading());
    var model = await api.getProviderCompletedOrder(user!.access_token, lan);
    mainCompletedOrders = model;
    emit(OrdersLoaded(model));
  }

  Future<void> changeProviderOrderStatus(String id,String status) async {
    emit(OrderChangeStatusLoading());
    var model = await api.changeProviderOrderStatus(user!.access_token,id,status);
    emit(OrderChangeStatusDone(model));
  }


  onUserDataSuccess() async {
    user = await Preferences.instance
        .getUserModel()
        .then((value) => user = value)
        .whenComplete(() {
      getProviderAcceptOrder().then(
          (value) => getProviderCompletedOrder(),
      );
    });
  }

  changePage(int index) {
    page = index;
    print("paaaaaaaggggggggeeee");
    print(page);
    emit(OrdersTabChanged(index));
  }
}
