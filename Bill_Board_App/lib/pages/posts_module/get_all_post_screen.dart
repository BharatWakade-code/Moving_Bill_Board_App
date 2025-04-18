import 'package:betasys_task/common/common_color.dart';
import 'package:betasys_task/common/common_loader.dart';
import 'package:betasys_task/common/common_snackbar.dart';
import 'package:betasys_task/pages/posts_module/get_all_post_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetAllPostScreen extends StatefulWidget {
  const GetAllPostScreen({super.key});

  @override
  State<GetAllPostScreen> createState() => _GetAllPostScreenState();
}

class _GetAllPostScreenState extends State<GetAllPostScreen> {
  @override
  void initState() {
    final cubit = context.read<GetAllPostCubit>();
    cubit.getAllPost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GetAllPostCubit>();
    return Scaffold(
      backgroundColor: CommonColours.scaffoldColour,
      appBar: AppBar(
        title: Text('All Post'),
        actions: [
          TextButton(
            onPressed: () => cubit.getAllPost(),
            child: Text('clear'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: BlocConsumer<GetAllPostCubit, GetAllPostState>(
        listener: (context, state) {
          if (state is GetAllPostSuccess) {
            CommonSnackBar.show(context, 'Get all post fetch succesfully');
          } else if (state is GetDeleteSuccess) {
            CommonSnackBar.show(context, state.msg);
          } else if (state is GetDeleteError) {
            CommonSnackBar.show(context, state.msg);
          }
        },
        builder: (context, state) {
          if (state is GetAllPostLoading) {
            return const CommonLoader();
          }
          return state is! GetDeleteSuccess
              ? ListView.builder(
                  itemCount: cubit.getAllPosts.length,
                  itemBuilder: (context, index) {
                    final postWiseIndex = cubit.getAllPosts[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                postWiseIndex.title ?? '',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                postWiseIndex.body ?? '',
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.black87),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.thumb_up,
                                            color: Colors.green),
                                        onPressed: () {},
                                      ),
                                      Text(
                                        postWiseIndex.reactions?.likes
                                                .toString() ??
                                            '',
                                      ),
                                      const SizedBox(width: 10),
                                      IconButton(
                                        icon: const Icon(Icons.thumb_down,
                                            color: Colors.red),
                                        onPressed: () {},
                                      ),
                                      Text(
                                        postWiseIndex.reactions?.dislikes
                                                .toString() ??
                                            '',
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.remove_red_eye,
                                          color: Colors.grey),
                                      const SizedBox(width: 5),
                                      Text(
                                        postWiseIndex.views.toString(),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () {},
                                    child: Text('Edit'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        cubit.deletePost(postWiseIndex.id ?? 0),
                                    child: Text('Delete'),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Container(
                    constraints: BoxConstraints.tight(Size.fromHeight(250)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cubit.deletedPost.title ?? '',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            cubit.deletedPost.body ?? '',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black87),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.thumb_up,
                                        color: Colors.green),
                                    onPressed: () {},
                                  ),
                                  Text(
                                    cubit.deletedPost.reactions?.likes
                                            .toString() ??
                                        '',
                                  ),
                                  const SizedBox(width: 10),
                                  IconButton(
                                    icon: const Icon(Icons.thumb_down,
                                        color: Colors.red),
                                    onPressed: () {},
                                  ),
                                  Text(
                                    cubit.deletedPost.reactions?.dislikes
                                            .toString() ??
                                        '',
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.remove_red_eye,
                                      color: Colors.grey),
                                  const SizedBox(width: 5),
                                  Text(
                                    cubit.deletedPost.views.toString(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
