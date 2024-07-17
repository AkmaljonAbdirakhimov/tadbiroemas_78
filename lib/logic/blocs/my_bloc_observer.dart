import 'package:bloc/bloc.dart';

// BlocObserver - ko'zatuvchi -
// barcha bloc va cubitlarni holatini ko'zatadi
class MyBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);

    // print("${bloc.runtimeType}, o'zgardi $change");
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    // TODO: implement onError
    super.onError(bloc, error, stackTrace);

    print("${bloc.runtimeType}, xatolik $error $stackTrace");
  }
}
