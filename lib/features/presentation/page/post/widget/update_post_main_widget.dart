
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proyecto_c2/consts.dart';
import 'package:proyecto_c2/features/domain/entities/posts/post_entity.dart';
import 'package:proyecto_c2/features/domain/usecases/firebase_usecases/storage/upload_image_to_storage_usecase.dart';
import 'package:proyecto_c2/features/presentation/cubit/post/post_cubit.dart';
import 'package:proyecto_c2/features/presentation/page/profile/widgets/profile_form_widget.dart';
import 'package:proyecto_c2/profile_widget.dart';
import 'package:proyecto_c2/injection_container.dart' as di;

class UpdatePostMainWidget extends StatefulWidget {
  final PostEntity post;
  const UpdatePostMainWidget({Key? key, required this.post}) : super(key: key);

  @override
  State<UpdatePostMainWidget> createState() => _UpdatePostMainWidgetState();
}

class _UpdatePostMainWidgetState extends State<UpdatePostMainWidget> {

  TextEditingController? _descriptionController;

  @override
  void initState() {
    _descriptionController = TextEditingController(text: widget.post.description);
    super.initState();
  }

  @override
  void dispose() {
    _descriptionController!.dispose();
    super.dispose();
  }

  File? _image;
  bool? _uploading = false;
  Future selectImage() async {
    try {
      final pickedFile = await ImagePicker.platform.getImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print("No se seleccionó imagen");
        }
      });

    } catch(e) {
      toast("Ocurrió un error $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        backgroundColor: purpleColor,
        title: Text("Editar publicación"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.white, // Cambia el color según tus preferencias
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(onTap: _updatePost,child: Icon(Icons.done, color: Colors.white, size: 28,)),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 100,
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: profileWidget(imageUrl: widget.post.userProfileUrl),
                ),
              ),
              sizeVer(15),
              Text("${widget.post.username}", style: TextStyle(color: primaryColor, fontSize: 16, fontWeight: FontWeight.bold),),
              sizeVer(15),
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.43,
                    child: profileWidget(
                        imageUrl: widget.post.postImageUrl,
                        image: _image
                    ),
                  ),
                  Positioned(
                    top: 15,
                    right: 15,
                    child: GestureDetector(
                      onTap: selectImage,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: Icon(Icons.edit, color: purpleColor),
                      ),
                    ),
                  )
                ],
              ),
              sizeVer(10),
              ProfileFormWidget(
                controller: _descriptionController,
                title: "Descripción",
              ),
              sizeVer(10),
              _uploading == true?Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Actualizando...", style: TextStyle(color: Colors.white),),
                  sizeHor(10),
                  CircularProgressIndicator()
                ],
              ) : Container(width: 0, height: 0,)
            ],
          ),
        ),
      ),
    );
  }

  _updatePost() {
    setState(() {
      _uploading = true;
    });
    if (_image == null) {
      _submitUpdatePost(image: widget.post.postImageUrl!);
    } else {
      di.sl<UploadImageToStorageUseCase>().call(_image!, true, "publicaciones").then((imageUrl) {
        _submitUpdatePost(image: imageUrl);
      });
    }
  }


  _submitUpdatePost({required String image}) {
    BlocProvider.of<PostCubit>(context).updatePost(
        post: PostEntity(
            creatorUid: widget.post.creatorUid,
            postId: widget.post.postId,
            postImageUrl: image,
            description: _descriptionController!.text
        )
    ).then((value) => _clear());
  }

  _clear() {
    setState(() {
      _descriptionController!.clear();
      Navigator.pop(context);
      _uploading = false;
    });
  }

}
