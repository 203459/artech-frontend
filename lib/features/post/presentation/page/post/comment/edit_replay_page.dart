import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_c2/features/post/domain/entities/comment/comment_entity.dart';
import 'package:proyecto_c2/features/post/domain/entities/replay/replay_entity.dart';
import 'package:proyecto_c2/features/post/presentation/cubit/replay/replay_cubit.dart';
import 'package:proyecto_c2/features/post/presentation/page/post/comment/widgets/edit_replay_main_widget.dart';
import 'package:proyecto_c2/injection_container.dart' as di;

class EditReplayPage extends StatelessWidget {
  final ReplayEntity replay;

  const EditReplayPage({Key? key, required this.replay}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReplayCubit>(
      create: (context) => di.sl<ReplayCubit>(),
      child: EditReplayMainWidget(replay: replay),
    );
  }
}
