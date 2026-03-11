import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final String currentRoute;

  const AppDrawer({super.key, required this.currentRoute});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E1E1E) : theme.primaryColor,
            ),
            child: const Center(
              child: Text(
                'Opciones',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(
                  context,
                  title: 'Monitoreos',
                  icon: Icons.track_changes,
                  route: '/monitoreos',
                ),
                _buildDrawerItem(
                  context,
                  title: 'Registrar Monitoreo',
                  icon: Icons.add_circle_outline,
                  route: '/registrar_monitoreo',
                ),
                _buildDrawerItem(
                  context,
                  title: 'Gráficos',
                  icon: Icons.show_chart,
                  route: '/graficos',
                ),
                _buildDrawerItem(
                  context,
                  title: 'Enviar datos a Servidor',
                  icon: Icons.cloud_upload,
                  route: '/enviar_datos',
                ),
                _buildDrawerItem(
                  context,
                  title: 'ConectorWeb',
                  icon: Icons.cloud_download,
                  route: '/conector_web',
                ),
                _buildDrawerItem(
                  context,
                  title: 'Historial',
                  icon: Icons.folder,
                  route: '/historial',
                ),
                _buildDrawerItem(
                  context,
                  title: 'Info',
                  icon: Icons.info_outline,
                  route: '/info',
                ),
                _buildDrawerItem(
                  context,
                  title: 'Usuarios',
                  icon: Icons.person_outline,
                  route: '/usuarios',
                ),
                _buildDrawerItem(
                  context,
                  title: 'Estaciones',
                  icon: Icons.location_on,
                  route: '/estaciones',
                ),
                _buildDrawerItem(
                  context,
                  title: 'Campañas',
                  icon: Icons.layers,
                  route: '/campanas',
                ),
                const Divider(),
                _buildDrawerItem(
                  context,
                  title: 'Settings',
                  icon: Icons.settings,
                  route: '/settings',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required String title,
    required IconData icon,
    required String route,
  }) {
    final isActive = currentRoute == route;
    final theme = Theme.of(context);

    return ListTile(
      leading: Icon(
        icon,
        color: isActive ? theme.colorScheme.primary : theme.colorScheme.onSurface.withOpacity(0.7),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isActive ? theme.colorScheme.primary : theme.colorScheme.onSurface,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isActive,
      selectedTileColor: theme.colorScheme.primary.withOpacity(0.1),
      onTap: () {
        if (!isActive) {
          Navigator.pushReplacementNamed(context, route);
        } else {
          Navigator.pop(context);
        }
      },
    );
  }
}
