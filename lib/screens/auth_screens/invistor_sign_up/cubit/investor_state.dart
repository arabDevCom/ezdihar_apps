part of 'investor_cubit.dart';

@immutable
abstract class InvestorState {}
class OnCitySelected extends InvestorState {
  CityModel cityModel;

  OnCitySelected(this.cityModel);
}
class OnCategorySelected extends InvestorState {
  CategoryModel categoryModel;

  OnCategorySelected(this.categoryModel);
}
class OnUserDataGet extends InvestorState {

}
class InvestorInitial extends InvestorState {}
class InvestorPhotoPicked extends InvestorState {
  String  file;
  InvestorPhotoPicked(this.file);
}
class InvestorBirthDateSelected extends InvestorState {
  String date;
  InvestorBirthDateSelected(this.date);
}
class InvestorFilePicked extends InvestorState {
  String fileName;
  InvestorFilePicked(this.fileName);
}
class InvestorDataValidation extends InvestorState {
  bool valid;
  InvestorDataValidation(this.valid);

}
class OnSignUpSuccess extends InvestorState {

}
class OnError extends InvestorState {
  String error;
  OnError(this.error);
}
