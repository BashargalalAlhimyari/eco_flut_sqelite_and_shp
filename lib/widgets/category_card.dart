// import 'package:flutter/material.dart';
// import '../models/category.dart';

// class CategoryCard extends StatelessWidget {
//   final Category category;
//   final VoidCallback onTap;

//   const CategoryCard({
//     Key? key,
//     required this.category,
//     required this.onTap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Card(
//       // الألوان والزوايا تأتي تلقائياً من ثيم تيليجرام
//       clipBehavior: Clip.antiAlias,
//       child: InkWell(
//         onTap: onTap,
//         splashColor: theme.primaryColor.withOpacity(0.2), // تأثير لمس بلون التطبيق
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // الأيقونة (أو الإيموجي كما في بياناتنا الوهمية)
//             Text(
//               category.imageUrl,
//               style: const TextStyle(fontSize: 48),
//             ),
//             const SizedBox(height: 12),
//             // اسم القسم
//             Text(
//               category.name,
//               style: theme.textTheme.titleMedium?.copyWith(
//                 fontWeight: FontWeight.bold,
//                 color: theme.colorScheme.onSurface,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
