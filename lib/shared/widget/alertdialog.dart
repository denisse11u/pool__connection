import 'package:flutter/material.dart';

Future<bool> showConfirmDialog(
  BuildContext context, {
  String title = "Confirmar",
  String message = "¿Estás seguro?",
  Function()? onPressed,
}) async {
  return (await showDialog<bool>(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: onPressed ?? () => Navigator.pop(context, true),
              child: const Text("Confirmar"),
            ),
          ],
        ),
      )) ??
      false;
}

class DismissibleCard extends StatelessWidget {
  final Widget child;
  final String itemKey;
  final VoidCallback onDelete;

  const DismissibleCard({
    super.key,
    required this.child,
    required this.itemKey,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(itemKey),
      direction: DismissDirection.endToStart,
      background: _deleteBackground(),
      confirmDismiss: (_) => showConfirmDialog(
        context,
        title: 'Eliminar',
        message: '¿Estás seguro de eliminar este elemento?',
      ),
      onDismissed: (_) => onDelete(),
      child: child,
    );
  }

  Widget _deleteBackground() {
    return Container(
      color: Colors.red,
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20),
      child: const Icon(Icons.delete, color: Colors.white),
    );
  }
}
