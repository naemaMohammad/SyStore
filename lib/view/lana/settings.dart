import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0, // نلغي الظل الافتراضي
        title: Text(
          "Settings",
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyMedium?.color,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.arrow_forward_ios, color: Colors.black, size: 18),
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                color:
                    Theme.of(
                      context,
                    ).textTheme.bodySmall?.color?.withOpacity(0.1) ??
                    Colors.black12,
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          _sectionTitle("Personal"),
          _tile("Profile"),

          _divider(),

          _sectionTitle("Shop"),
          _tile("Currency", trailing: "SYP"),

          _divider(),

          _sectionTitle("Account"),
          _tile("Language", trailing: "English"),
          _tile("Light mood"),
          _tile("About US"),

          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Log out",
              style: TextStyle(
                color: Colors.red[400],
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
      ),
    );
  }

  Widget _tile(String title, {String? trailing}) {
    return ListTile(
      title: Text(title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailing != null)
            Text(trailing, style: const TextStyle(color: Colors.black54)),
          const SizedBox(width: 6),
          const Icon(Icons.arrow_forward_ios, size: 16),
        ],
      ),
      onTap: () {},
    );
  }

  Widget _divider() {
    return Divider(
      thickness: 1,
      color: Colors.grey[300],
      indent: 16,
      endIndent: 16,
    );
  }
}
