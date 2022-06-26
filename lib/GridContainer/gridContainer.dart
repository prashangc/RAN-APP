import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';

class GridFileContainer extends StatefulWidget {
  final List<PlatformFile> files;
  final ValueChanged<PlatformFile> onOpenedFile;

  const GridFileContainer({
    Key? key,
    required this.files,
    required this.onOpenedFile,
  }) : super(key: key);

  @override
  State<GridFileContainer> createState() => _GridFileContainerState();
}

class _GridFileContainerState extends State<GridFileContainer> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 8, mainAxisSpacing: 8, crossAxisCount: 2),
        itemCount: widget.files.length,
        itemBuilder: (context, index) {
          final file = widget.files[index];
          return buildFile(file);
        });
  }
}

Widget buildFile(PlatformFile file) {
  final kb = file.size / 1024;
  final mb = kb / 1024;
  final fileSize = mb >= 1 ? mb.toStringAsFixed(2) : kb.toStringAsFixed(2);
  final extension = file.extension ?? 'none';
  // final color = getColor(extension);
  const color = Colors.red;

  return GestureDetector(
    onTap: () => OpenFile.open(file.path!),
    child: Container(
      padding: const EdgeInsets.all(8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '.$extension',
              style: const TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          file.name,
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          fileSize,
          style: const TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ]),
    ),
  );
}
