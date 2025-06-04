import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manage_me/core/constants/colors.dart';
import 'package:manage_me/data/model/post_model.dart';
import 'package:manage_me/logic/post/post_bloc.dart';
import 'package:manage_me/logic/post/post_event.dart';

class AddPostScreen extends StatefulWidget {
  // User ID to associate the post with the correct user
  final int userId;

  const AddPostScreen({super.key, required this.userId});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  // Key to identify the form and validate input fields
  final _formKey = GlobalKey<FormState>();

  // Controllers to manage text input for title and body of the post
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  // Method to handle the form submission
  void _submitPost() {
    // Validate the form fields
    if (_formKey.currentState!.validate()) {
      // Create a new PostModel object with current input values
      final newPost = PostModel(
        id: DateTime.now().millisecondsSinceEpoch, // Unique ID based on timestamp
        userId: widget.userId,                      // Assign the post to the user
        title: _titleController.text.trim(),       // Trimmed post title
        body: _bodyController.text.trim(),         // Trimmed post content
      );

      // Dispatch event to add the new post locally in the PostBloc
      context.read<PostBloc>().add(AddLocalPost(post: newPost));

      // Show a confirmation message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Post added successfully!')),
      );

      // Navigate back to previous screen with success flag
      Navigator.pop(context, true);
    }
  }

  @override
  void dispose() {
    // Dispose controllers to free up resources and avoid memory leaks
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add New Post")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey, // Attach the form key for validation
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Post Title Input Section
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.border),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Icon and Label for the title field
                    Row(
                      children: const [
                        Icon(Icons.title, color: AppColors.primary),
                        SizedBox(width: 8),
                        Text(
                          "Post Title",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Text input for the post title with validation
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        hintText: "Craft a compelling title for your content",
                        border: InputBorder.none,
                        isDense: true,
                      ),
                      validator: (value) =>
                          (value == null || value.isEmpty) ? "Title is required" : null,
                    ),
                  ],
                ),
              ),

              // Post Content Input Section
              Container(
                margin: const EdgeInsets.only(bottom: 32),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.border),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Icon and Label for the content field
                    Row(
                      children: const [
                        Icon(Icons.article_outlined, color: AppColors.primary),
                        SizedBox(width: 8),
                        Text(
                          "Post Content",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Text input for the post content with multiline support and validation
                    TextFormField(
                      controller: _bodyController,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        hintText: "Share your detailed thoughts, stories, or insights here...",
                        border: InputBorder.none,
                        isDense: true,
                      ),
                      validator: (value) =>
                          (value == null || value.isEmpty) ? "Content is required" : null,
                    ),
                  ],
                ),
              ),

              // Submit Button to add the post
              ElevatedButton(
                onPressed: _submitPost, // Call submit handler when pressed
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.buttonText,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("Submit Post", style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
