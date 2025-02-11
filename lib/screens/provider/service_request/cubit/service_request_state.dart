part of 'service_request_cubit.dart';

@immutable
abstract class ServiceRequestState {}

class ServiceRequestInitial extends ServiceRequestState {}
class UserBirthDateSelected extends ServiceRequestState {
  String date;

  UserBirthDateSelected(this.date);
}

class UserDataValidation extends ServiceRequestState {
  bool valid;

  UserDataValidation(this.valid);
}
class OnOrderSuccess extends ServiceRequestState {
  StatusResponse model;
  OnOrderSuccess(this.model);
}

class OnError extends ServiceRequestState {
  String error;
  OnError(this.error);
}
