import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_c2/features/post/presentation/cubit/post/post_cubit.dart';
import 'package:proyecto_c2/features/presentation/cubit/user/user_cubit.dart';
import 'package:proyecto_c2/features/post/presentation/page/search/widget/search_main_widget.dart';
import 'package:proyecto_c2/injection_container.dart' as di;

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PostCubit>(
          create: (context) => di.sl<PostCubit>(),
        ),
      ],
      child: SearchMainWidget(),
    );
  }
}
