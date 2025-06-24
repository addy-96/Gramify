import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:gramify/core/common/shared_attri/constrants.dart';
import 'package:gramify/core/common/shared_fun/calculate_upload_time.dart';
import 'package:gramify/core/common/shared_fun/csnack.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';
import 'package:gramify/features/home/domain/models/comment_model.dart';
import 'package:gramify/features/home/presentation/bloc/post_bloc/post_bloc.dart';
import 'package:gramify/features/home/presentation/bloc/post_bloc/post_event.dart';
import 'package:gramify/features/home/presentation/bloc/post_bloc/post_state.dart';
import 'package:ionicons/ionicons.dart';

Future openCommentModalSheet(BuildContext context, {required String postId}) {
  return showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.grey.shade900,
    context: context,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: CommentSection(postID: postId),
      );
    },
  );
}

class CommentSection extends StatefulWidget {
  const CommentSection({super.key, required, required this.postID});
  final String postID;

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  final List<CommentModel> commentLIst = [];

  @override
  void initState() {
    super.initState(); // looadcomments
    context.read<PostBloc>().add(CommentsRequeested(postId: widget.postID));
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.9,
      maxChildSize: 0.95,
      minChildSize: 0.3,
      builder: (context, scrollController) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: BlocConsumer<PostBloc, PostState>(
            listener: (context, state) {
              if (state is PostErrorState) {
                csnack(context, state.errorMessage);
              }
            },
            builder: (context, state) {
              if (state is LoadingCommentsState) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is CommentsFetchedState) {
                if (state.commentList.isEmpty) {
                  return Column(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'No comments!',
                              style: txtStyle(subTitle22, Colors.white),
                            ),
                            Text(
                              'Be the first to comment.',
                              style: txtStyle(bodyText16, Colors.grey.shade700),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      CommentsInputbox(postid: widget.postID),
                    ],
                  );
                }
                if (state.commentList.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 0,
                      vertical: 8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                        Container(
                          width: 50,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.white60,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const Gap(10),
                        Container(
                          height: MediaQuery.of(context).size.height / 16,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1,
                                color: Colors.white10,
                              ),
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              'Comments',
                              style: txtStyle(
                                subTitle18,
                                Colors.white70,
                              ).copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),

                        Expanded(
                          child: ListView.builder(
                            itemCount: state.commentList.length,
                            itemBuilder: (context, index) {
                              return CommentsTile(
                                commentModel: state.commentList[index],
                              );
                            },
                          ),
                        ),
                        CommentsInputbox(postid: widget.postID),
                      ],
                    ),
                  );
                }
              }
              return const Center(child: Text('no-state'));
            },
          ),
        );
      },
    );
  }
}

class CommentsInputbox extends StatefulWidget {
  const CommentsInputbox({super.key, required this.postid});
  final String postid;

  @override
  State<CommentsInputbox> createState() => _CommentsInputboxState();
}

class _CommentsInputboxState extends State<CommentsInputbox> {
  final TextEditingController commentController = TextEditingController();
  double contHeight = 50;
  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        height: contHeight,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 1, color: Colors.grey.shade800),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
          child: TextField(
            maxLines: 20,
            controller: commentController,
            onChanged: (value) {
              setState(() {
                if (contHeight < 80) {
                  contHeight += commentController.text.length * 0.1;
                }
              });
            },
            decoration: InputDecoration(
              hintText: 'Write your Comment here ',
              hintStyle: txtStyle(bodyText14, Colors.grey.shade700),
              border: InputBorder.none,
              suffixIcon:
                  commentController.text.trim().isEmpty
                      ? null
                      : IconButton(
                        onPressed: () {
                          context.read<PostBloc>().add(
                            AddCommentsRequested(
                              postId: widget.postid,
                              comment: commentController.text.trim(),
                            ),
                          );
                          commentController.clear();
                        },
                        icon: const Icon(Ionicons.send_outline),
                        padding: const EdgeInsets.only(top: 10),
                      ),
            ),
          ),
        ),
      ),
    );
  }
}

class CommentsTile extends StatelessWidget {
  const CommentsTile({super.key, required this.commentModel});
  final CommentModel commentModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
      child: SizedBox(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                height: MediaQuery.of(context).size.width * 0.07,
                width: MediaQuery.of(context).size.width * 0.07,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(width: 1, color: Colors.white),
                ),
                child:
                    commentModel.commentProfileImageUrl == null
                        ? const Icon(Ionicons.person_outline, size: 12)
                        : Image.network(commentModel.commentProfileImageUrl!),
              ),
            ),
            const Gap(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        commentModel.commenterUsername,
                        overflow: TextOverflow.visible,
                        maxLines: 100,
                        softWrap: true,
                        textAlign: TextAlign.start,
                        style: txtStyle(small12, Colors.white),
                      ),
                      const Gap(5),
                      Text(
                        claulateCommentTime(commentModel.commentTime),
                        style: txtStyle(
                          small12,
                          Colors.grey.shade600,
                        ).copyWith(fontWeight: FontWeight.normal),
                      ), // to print actual time
                    ],
                  ),
                  Text(
                    commentModel.comment,
                    overflow: TextOverflow.visible,
                    maxLines: 100,
                    softWrap: true,
                    textAlign: TextAlign.start,
                    style: txtStyle(bodyText16, Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
