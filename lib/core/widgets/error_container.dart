import 'package:flutter/material.dart';

class ErrorContainer extends StatelessWidget {
  const ErrorContainer({super.key, required this.errorMessage});
  
  final String errorMessage;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.red.shade100,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        errorMessage,
        style: const TextStyle(color: Colors.red),
      ),
    );
  }
}