import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manage_me/core/constants/colors.dart';

import 'package:manage_me/data/model/user_model.dart';
import 'package:manage_me/logic/todo/todo_bloc.dart';
import 'package:manage_me/logic/todo/todo_event.dart';
import 'package:manage_me/logic/todo/todo_state.dart';
import 'package:manage_me/logic/post/post_bloc.dart';
import 'package:manage_me/logic/post/post_event.dart' as post_event;
import 'package:manage_me/logic/post/post_state.dart' as post_state;
import 'package:manage_me/presentation/screens/post/add_post_screen.dart';
import 'package:manage_me/presentation/widgets/loading_indicator.dart';
import 'package:manage_me/presentation/widgets/post_card%20_local.dart';
import 'package:manage_me/presentation/widgets/post_card.dart';
import 'package:manage_me/presentation/widgets/todo_tile.dart';

class UserDetailScreen extends StatefulWidget {
  final UserModel user;

  const UserDetailScreen({super.key, required this.user});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final postBloc = context.read<PostBloc>();
      final todoBloc = context.read<TodoBloc>();

      postBloc.add(post_event.ClearPosts());
      todoBloc.add(LoadTodos(userId: widget.user.id));
      postBloc.add(post_event.LoadLocalPosts(userId: widget.user.id));
      postBloc.add(post_event.LoadApiPosts(userId: widget.user.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    // Detect current brightness (light/dark mode)
    final brightness = Theme.of(context).brightness;
    final isDarkMode = brightness == Brightness.dark;

    // Define colors dynamically based on theme
    final backgroundColor = isDarkMode ? AppColors.backgroundDark : AppColors.background;
    final cardColor = isDarkMode ? AppColors.cardBackgroundDark : AppColors.cardBackground;
    final textPrimary = isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final textSecondary = isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondary;
    final appBarBackground = isDarkMode ? Colors.black : Colors.white;
    final appBarForeground = isDarkMode ? Colors.white : AppColors.textPrimary;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('User Details'),
        backgroundColor: appBarBackground,
        foregroundColor: appBarForeground,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Info Card
            Card(
              color: cardColor,
              elevation: 1,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: (widget.user.image?.isNotEmpty ?? false)
                          ? NetworkImage(widget.user.image!)
                          : const AssetImage('assets/default_avatar.png') as ImageProvider,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '${widget.user.firstName} ${widget.user.lastName}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    infoRow(Icons.email, widget.user.email, textSecondary, textPrimary),
                    infoRow(Icons.phone, widget.user.phone, textSecondary, textPrimary),
                    infoRow(Icons.person, 'Gender: ${widget.user.gender}, Age: ${widget.user.age}', textSecondary, textPrimary),
                    infoRow(Icons.cake, 'Birthday: ${widget.user.birthDate}', textSecondary, textPrimary),
                    infoRow(
                      Icons.location_on,
                      'Address: postalcode: ${widget.user.address.postalCode}, city: ${widget.user.address.city}, state: ${widget.user.address.state}',
                      textSecondary,
                      textPrimary,
                    ),
                    infoRow(Icons.business, '${widget.user.company.name}, ${widget.user.company.title}', textSecondary, textPrimary),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            const Text("Todos", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            BlocBuilder<TodoBloc, TodoState>(
              builder: (context, state) {
                if (state is TodoLoading) {
                  return const LoadingIndicator();
                } else if (state is TodoLoaded) {
                  if (state.todos.isEmpty) {
                    return Text("No todos found.", style: TextStyle(color: textPrimary));
                  }
                  return Card(
                    color: cardColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: state.todos.map((todo) => TodoTile(todo: todo)).toList(),
                      ),
                    ),
                  );
                } else if (state is TodoError) {
                  return Text("Error loading todos: ${state.message}", style: TextStyle(color: textPrimary));
                }
                return Text("No todos available.", style: TextStyle(color: textPrimary));
              },
            ),

            const SizedBox(height: 24),

            const Text("Posts", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            BlocBuilder<PostBloc, post_state.PostState>(
              builder: (context, state) {
                Widget localPostsSection = const SizedBox.shrink();
                Widget apiPostsSection = const SizedBox.shrink();

                if (state is post_state.PostInitial) {
                  return const LoadingIndicator();
                }

                if (state is post_state.PostError) {
                  return Text("Error loading posts: ${state.message}", style: TextStyle(color: textPrimary));
                }

                if (state is post_state.PostLoaded) {
                  if (state.isApiLoading) {
                    apiPostsSection = const LoadingIndicator();
                  } else if (state.apiPosts.isEmpty) {
                    apiPostsSection = Text("No API posts found.", style: TextStyle(color: textPrimary));
                  } else {
                    apiPostsSection = Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: state.apiPosts.map((post) => PostCard(post: post)).toList(),
                    );
                  }

                  if (state.isLocalLoading) {
                    localPostsSection = const LoadingIndicator();
                  } else if (state.localPosts.isEmpty) {
                    localPostsSection = Text("No local posts found.", style: TextStyle(color: textPrimary));
                  } else {
                    localPostsSection = Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: state.localPosts.map((post) => PostCard1(post: post)).toList(),
                    );
                  }
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("API Posts", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textPrimary)),
                    const SizedBox(height: 8),
                    apiPostsSection,
                    const SizedBox(height: 16),
                    Text("Local Posts", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textPrimary)),
                    const SizedBox(height: 8),
                    localPostsSection,
                  ],
                );
              },
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: 160,
        height: 50,
        child: ElevatedButton.icon(
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AddPostScreen(userId: widget.user.id),
              ),
            );
            if (result == true) {
              context.read<PostBloc>().add(post_event.LoadLocalPosts(userId: widget.user.id));
              context.read<PostBloc>().add(post_event.LoadApiPosts(userId: widget.user.id));
            }
          },
          icon: const Icon(Icons.add),
          label: const Text("Add POST"),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            elevation: 6,
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget infoRow(IconData icon, String text, Color iconColor, Color textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 18, color: iconColor),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 14, color: textColor),
            ),
          ),
        ],
      ),
    );
  }
}
