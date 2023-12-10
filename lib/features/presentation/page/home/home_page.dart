import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proyecto_c2/consts.dart';
import 'package:proyecto_c2/features/domain/entities/posts/post_entity.dart';
import 'package:proyecto_c2/features/presentation/cubit/post/post_cubit.dart';
import 'package:proyecto_c2/features/presentation/cubit/user/get_single_user/get_single_user_cubit.dart';
import 'package:proyecto_c2/features/presentation/page/home/widgets/single_post_card_widget.dart';
import 'package:proyecto_c2/features/presentation/page/post/upload_post_page.dart';
import 'package:proyecto_c2/injection_container.dart' as di;

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        backgroundColor: backGroundColor,
        title: Text(
          'ARTTECH',
          style: TextStyle(color: Color(0xFFAA5EB7)),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Icon(
              FeatherIcons.messageSquare,
              color: primaryColor,
            ),
          )
        ],
      ),
      body: BlocProvider<PostCubit>(
        create: (context) => di.sl<PostCubit>()..getPosts(post: PostEntity()),
        child: BlocBuilder<PostCubit, PostState>(
          builder: (context, postState) {
            if (postState is PostLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (postState is PostFailure) {
              toast("Sucedió algún error mientras se creaba la publicación");
            }
            if (postState is PostLoaded) {
              return postState.posts.isEmpty
                  ? _noPostsYetWidget()
                  : ListView.builder(
                      itemCount: postState.posts.length,
                      itemBuilder: (context, index) {
                        final post = postState.posts[index];
                        return BlocProvider(
                          create: (context) => di.sl<PostCubit>(),
                          child: SinglePostCardWidget(post: post),
                        );
                      },
                    );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final currentUser = context.read<GetSingleUserCubit>().state.user;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UploadPostPage(currentUser: currentUser),
            ),
          );
        },
        child: SvgPicture.asset(
          'assets/createpost_icon.svg',  // Ruta de tu icono SVG
          color: Colors.white,   // Color del icono
          width: 24.0,           // Ancho del icono
          height: 24.0,          // Altura del icono
        ),
        backgroundColor: Color(0xFFA042B7),
      ),
    );
  }

  _noPostsYetWidget() {
    return Center(
      child: Text(
        "Sin publicaciones",
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }
}

