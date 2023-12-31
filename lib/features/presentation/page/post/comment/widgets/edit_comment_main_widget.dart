import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_c2/consts.dart';
import 'package:proyecto_c2/features/domain/entities/comment/comment_entity.dart';
import 'package:proyecto_c2/features/presentation/cubit/comment/comment_cubit.dart';
import 'package:proyecto_c2/features/presentation/page/profile/widgets/profile_form_widget.dart';
import 'package:proyecto_c2/features/presentation/widgets/button_container_widget.dart';

class EditCommentMainWidget extends StatefulWidget {
  final CommentEntity comment;
  const EditCommentMainWidget({Key? key, required this.comment})
      : super(key: key);

  @override
  State<EditCommentMainWidget> createState() => _EditCommentMainWidgetState();
}

class _EditCommentMainWidgetState extends State<EditCommentMainWidget> {
  TextEditingController? _descriptionController;

  bool _isCommentUpdating = false;

  @override
  void initState() {
    _descriptionController =
        TextEditingController(text: widget.comment.description);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        backgroundColor: purpleColor,
        title: Text("Editar comentario"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.white, // Cambia el color según tus preferencias
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Column(
          children: [
            ProfileFormWidget(
              title: "Comentario:",
              controller: _descriptionController,
            ),
            sizeVer(10),
            ButtonContainerWidget(
              color: purpleColor,
              text: "Guardar cambios",
              onTapListener: () {
                _editComment();
              },
            ),
            sizeVer(10),
            _isCommentUpdating == true
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Actualizando...",
                        style: TextStyle(color: Colors.white),
                      ),
                      sizeHor(10),
                      CircularProgressIndicator(),
                    ],
                  )
                : Container(
                    width: 0,
                    height: 0,
                  )
          ],
        ),
      ),
    );
  }

  _editComment() {
    setState(() {
      _isCommentUpdating = true;
    });
    BlocProvider.of<CommentCubit>(context)
        .updateComment(
            comment: CommentEntity(
                postId: widget.comment.postId,
                commentId: widget.comment.commentId,
                description: _descriptionController!.text))
        .then((value) {
      setState(() {
        _isCommentUpdating = false;
        _descriptionController!.clear();
      });
      Navigator.pop(context);
    });
  }
}
