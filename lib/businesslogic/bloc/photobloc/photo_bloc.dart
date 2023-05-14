import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stdappbloc/businesslogic/bloc/photobloc/photo_event.dart';
import 'package:stdappbloc/businesslogic/bloc/photobloc/photo_state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  PhotoBloc() : super(PhotoIntial()) {
    on<PhotoSelectedEvent>((event, emit) async {
      final photo = await getPhoto();
      emit(PhotoLoaded(photo: photo));
    });

    on<PhotoResetEvent>((event, emit) {
      emit(PhotoIntial());
    });
  }

  Future<File?> getPhoto() async {
    final photo = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (photo == null) {
      return null;
    } else {
      final photoTemp = File(photo.path);
      return photoTemp;
    }
  }
}
