import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_c2/features/domain/entities/user/user_entity.dart';
import 'package:proyecto_c2/features/presentation/cubit/post/post_cubit.dart';
import 'package:proyecto_c2/features/presentation/page/profile/widgets/profile_main_widget.dart';
import 'package:proyecto_c2/injection_container.dart' as di;
class ProfilePage extends StatelessWidget {
  final UserEntity currentUser;

  const ProfilePage({Key? key, required this.currentUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<PostCubit>(),
      child: ProfileMainWidget(currentUser: currentUser,),
    );
  }
}
