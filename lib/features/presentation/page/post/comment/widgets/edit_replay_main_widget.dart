
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_c2/consts.dart';
import 'package:proyecto_c2/features/domain/entities/replay/replay_entity.dart';
import 'package:proyecto_c2/features/presentation/cubit/replay/replay_cubit.dart';
import 'package:proyecto_c2/features/presentation/page/profile/widgets/profile_form_widget.dart';
import 'package:proyecto_c2/features/presentation/widgets/button_container_widget.dart';

class EditReplayMainWidget extends StatefulWidget {
  final ReplayEntity replay;
  const EditReplayMainWidget({Key? key, required this.replay}) : super(key: key);

  @override
  State<EditReplayMainWidget> createState() => _EditReplayMainWidgetState();
}

class _EditReplayMainWidgetState extends State<EditReplayMainWidget> {

  TextEditingController? _descriptionController;

  bool _isReplayUpdating = false;

  @override
  void initState() {
    _descriptionController = TextEditingController(text: widget.replay.description);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        backgroundColor: purpleColor,
        title: Text("Editar respuesta"),
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
              title: "comentario:",
              controller: _descriptionController,
            ),
            sizeVer(10),
            ButtonContainerWidget(
              color: purpleColor,
              text: "Guardar cambios",
              onTapListener: () {
                _editReplay();
              },
            ),
            sizeVer(10),
            _isReplayUpdating == true?Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Actualizando...", style: TextStyle(color: Colors.white),),
                sizeHor(10),
                CircularProgressIndicator(),
              ],
            ) : Container(width: 0, height: 0,)
          ],
        ),
      ),
    );
  }

  _editReplay() {
    setState(() {
      _isReplayUpdating = true;
    });
    BlocProvider.of<ReplayCubit>(context).updateReplay(replay: ReplayEntity(
        postId: widget.replay.postId,
        commentId: widget.replay.commentId,
        replayId: widget.replay.replayId,
        description: _descriptionController!.text
    )).then((value) {
      setState(() {
        _isReplayUpdating = false;
        _descriptionController!.clear();
      });
      Navigator.pop(context);
    });
  }
}
