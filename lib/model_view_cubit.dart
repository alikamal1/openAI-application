import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_openai/repository.dart';

part 'model_view_state.dart';

class ModelViewCubit extends Cubit<ModelViewState> {
  ModelViewCubit() : super(ModelViewInitial());
  static ModelViewCubit get(context) => BlocProvider.of(context);

  var data;
  Future aiData(message)async {
    print(message.toString());
    emit(AiDataLoadingState());
    return await const RemoteRepository().postHttp(message.toString()).then((value) {
      print(value.data);
      data = value.data[0].toString() ;
      emit(AiDataSuccessState());
    }).catchError((error) {
      print(error);

    });

  }
}
