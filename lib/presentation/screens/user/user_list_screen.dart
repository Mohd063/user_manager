import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manage_me/logic/user/user_bloc.dart';
import 'package:manage_me/logic/user/user_event.dart';
import 'package:manage_me/logic/user/user_state.dart';
import 'package:manage_me/presentation/screens/user/user_detail_screen.dart';
import 'package:manage_me/themes/tcubit.dart';

/// Screen that displays a list of users with search, pagination, and theme toggle functionality.
class UserListScreen extends StatefulWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  late final ScrollController _scrollController;
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _allUsers = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();

    context.read<UserBloc>().add(FetchUsers(isInitialFetch: true));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        context.read<UserBloc>().add(FetchUsers());
      }
    });

    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<dynamic> _filterUsers(List<dynamic> users) {
    return users
        .where((user) => user.firstName.toLowerCase().contains(_searchQuery))
        .toList();
  }

  Future<void> _onRefresh() async {
    context.read<UserBloc>().add(FetchUsers(isInitialFetch: true));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: colorScheme.background,

      appBar: AppBar(
        backgroundColor: colorScheme.background,
        elevation: 0,
        title: Text(
          'Users',
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onBackground,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              theme.brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
              color: colorScheme.onBackground,
            ),
            onPressed: () {
              final isDark = theme.brightness == Brightness.light;
              context.read<ThemeCubit>().toggleTheme(isDark);
            },
          ),
        ],
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _searchController,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onBackground,
              ),
              decoration: InputDecoration(
                hintText: 'Search users by name or email...',
                hintStyle: TextStyle(color: colorScheme.onBackground.withOpacity(0.5)),
                prefixIcon: Icon(Icons.search, color: colorScheme.onBackground.withOpacity(0.7)),
                fillColor: colorScheme.surfaceVariant.withOpacity(0.1),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          Expanded(
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserLoading && state is! UserLoaded) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is UserLoaded) {
                  _allUsers = state.users;
                  final filteredUsers = _filterUsers(_allUsers);

                  if (filteredUsers.isEmpty) {
                    return Center(
                      child: Text(
                        'No users found.',
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onBackground,
                        ),
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: filteredUsers.length + (state.hasReachedMax ? 0 : 1),
                      itemBuilder: (context, index) {
                        if (index < filteredUsers.length) {
                          final user = filteredUsers[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => UserDetailScreen(user: user),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: colorScheme.surface,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: colorScheme.shadow.withOpacity(0.1),
                                      blurRadius: 6,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(user.image),
                                        radius: 30,
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 12),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${user.firstName} ${user.lastName}',
                                              style: textTheme.titleMedium?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: colorScheme.onSurface,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              user.email,
                                              style: textTheme.bodySmall?.copyWith(
                                                color: colorScheme.onSurfaceVariant,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 12),
                                      child: Icon(
                                        Icons.chevron_right,
                                        color: colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else {
                          return const Padding(
                            padding: EdgeInsets.all(16),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                      },
                    ),
                  );
                } else if (state is UserError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('⚠️ ${state.message}',
                            style: textTheme.bodyMedium?.copyWith(
                              color: colorScheme.error,
                            )),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () {
                            context.read<UserBloc>().add(FetchUsers(isInitialFetch: true));
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
