import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class ConectorWebScreen extends StatelessWidget {
  const ConectorWebScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    // Colores específicos para la barra superior según el tema
    final appBarColor = isDarkMode ? null : const Color(0xFF3B82F6); // Azul brillante en modo claro
    final tabLabelColor = isDarkMode ? Colors.blueAccent : Colors.white;
    final tabUnselectedColor = isDarkMode ? Colors.grey : Colors.white60;
    final iconTextColor = isDarkMode ? Colors.white : Colors.white;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        // Fondo ligeramente grisáceo en modo claro para que resalte el formulario
        backgroundColor: isDarkMode ? Theme.of(context).scaffoldBackgroundColor : const Color(0xFFF8F9FA),
        appBar: AppBar(
          backgroundColor: appBarColor,
          iconTheme: IconThemeData(color: iconTextColor), // Color del menú hamburguesa
          title: Text(
            'Sincronizar',
            style: TextStyle(color: iconTextColor, fontWeight: FontWeight.w600),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.more_vert, color: iconTextColor),
              onPressed: () {},
            ),
          ],
          bottom: TabBar(
            indicatorColor: tabLabelColor,
            labelColor: tabLabelColor,
            unselectedLabelColor: tabUnselectedColor,
            labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
            tabs: const [
              Tab(text: 'PROGRAMAS'),
              Tab(text: 'MUESTRAS'),
            ],
          ),
        ),
        drawer: const AppDrawer(currentRoute: '/conector_web'),
        body: TabBarView(
          children: [
            // --- PESTAÑA 1: PROGRAMAS ---
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.map_outlined, size: 80, color: Colors.greenAccent.shade400),
                  const SizedBox(height: 24),
                  const Text('Actualizar Programas', style: TextStyle(color: Colors.blueAccent, fontSize: 16, fontWeight: FontWeight.w400)),
                  const SizedBox(height: 32),
                  OutlinedButton(
                    onPressed: () => debugPrint('Botón ACTUALIZAR presionado en Programas'),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.blueAccent, width: 1.5),
                      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 16.0),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                    ),
                    child: const Text('ACTUALIZAR', style: TextStyle(color: Colors.blueAccent, fontSize: 14, letterSpacing: 1.2, fontWeight: FontWeight.w500)),
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ),

            // --- PESTAÑA 2: MUESTRAS ---
            const _MuestrasTab(),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// WIDGET CON ESTADO PARA LA PESTAÑA "MUESTRAS"
// ============================================================================
class _MuestrasTab extends StatefulWidget {
  const _MuestrasTab();

  @override
  State<_MuestrasTab> createState() => _MuestrasTabState();
}

class _MuestrasTabState extends State<_MuestrasTab> {
  // Variables de Programa
  String? _selectedPrograma;
  bool _expandPrograma = false;
  final TextEditingController _searchProgramaController = TextEditingController();
  final List<String> _opcionesPrograma = ['Mauro 2025', 'La Brea - Diciembre 20...'];
  List<String> _programasFiltrados = [];

  // Variables de Estaciones
  List<String> _selectedEstaciones = [];
  bool _expandEstaciones = false;
  bool _todasLasEstaciones = false;
  final TextEditingController _searchEstacionesController = TextEditingController();
  final List<String> _opcionesEstaciones = ['BRW-01', 'BRW-02', 'Descarga Sur', 'GPLB-5', 'LM-10'];
  List<String> _estacionesFiltradas = [];

  @override
  void initState() {
    super.initState();
    _programasFiltrados = _opcionesPrograma;
    _searchProgramaController.addListener(() {
      setState(() {
        _programasFiltrados = _opcionesPrograma
            .where((p) => p.toLowerCase().contains(_searchProgramaController.text.toLowerCase()))
            .toList();
      });
    });

    _estacionesFiltradas = _opcionesEstaciones;
    _searchEstacionesController.addListener(() {
      setState(() {
        _estacionesFiltradas = _opcionesEstaciones
            .where((e) => e.toLowerCase().contains(_searchEstacionesController.text.toLowerCase()))
            .toList();
      });
    });
  }

  @override
  void dispose() {
    _searchProgramaController.dispose();
    _searchEstacionesController.dispose();
    super.dispose();
  }

  void _toggleTodasLasEstaciones(bool? value) {
    setState(() {
      _todasLasEstaciones = value ?? false;
      if (_todasLasEstaciones) {
        _selectedEstaciones = List.from(_opcionesEstaciones);
      } else {
        _selectedEstaciones.clear();
      }
    });
  }

  void _toggleEstacion(String estacion) {
    setState(() {
      if (_selectedEstaciones.contains(estacion)) {
        _selectedEstaciones.remove(estacion);
        _todasLasEstaciones = false; 
      } else {
        _selectedEstaciones.add(estacion);
        if (_selectedEstaciones.length == _opcionesEstaciones.length) {
          _todasLasEstaciones = true;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    // Colores adaptables para el formulario
    final Color bgColor = isDarkMode ? const Color(0xFF1E1E1E) : const Color(0xFFF3F4F6); // Gris muy clarito en modo claro
    final Color borderColor = isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300;
    final Color textColor = Theme.of(context).colorScheme.onSurface;
    final Color hintColor = Colors.grey.shade500;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
      child: Column(
        children: [
          // ÍCONO Y TÍTULO
          Icon(Icons.cloud_download_outlined, size: 64, color: Colors.greenAccent.shade400),
          const SizedBox(height: 16),
          const Text(
            'Actualizar muestras',
            style: TextStyle(color: Colors.blueAccent, fontSize: 16, fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 32),

          // CONTENEDOR DEL FORMULARIO
          Container(
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Column(
              children: [
                // --- 1. SELECCIÓN DE PROGRAMA ---
                ListTile(
                  title: Text('Programa', style: TextStyle(color: textColor, fontSize: 14)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _selectedPrograma ?? 'Seleccione',
                        style: TextStyle(color: hintColor, fontSize: 14),
                      ),
                      const SizedBox(width: 8),
                      Icon(_expandPrograma ? Icons.arrow_drop_up : Icons.arrow_drop_down, color: hintColor),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      _expandPrograma = !_expandPrograma;
                      if (_expandPrograma) _expandEstaciones = false; 
                    });
                  },
                ),
                
                // Desplegable de Programa
                if (_expandPrograma) ...[
                  Divider(height: 1, color: borderColor),
                  _buildBuscador(_searchProgramaController, 'Buscar programa...', isDarkMode),
                  SizedBox(
                    height: _programasFiltrados.length > 3 ? 150 : _programasFiltrados.length * 50.0,
                    child: ListView.builder(
                      itemCount: _programasFiltrados.length,
                      itemBuilder: (context, index) {
                        final prog = _programasFiltrados[index];
                        final isSelected = _selectedPrograma == prog;
                        return InkWell(
                          onTap: () {
                            setState(() {
                              _selectedPrograma = prog;
                              _expandPrograma = false;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                            child: Row(
                              children: [
                                Icon(
                                  isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                                  color: isSelected ? Colors.blueAccent : Colors.grey.shade600,
                                  size: 20,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    prog,
                                    style: TextStyle(color: textColor, fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],

                Divider(height: 1, color: borderColor),

                // --- 2. SELECCIÓN DE ESTACIONES ---
                ListTile(
                  title: Text('Estaciones', style: TextStyle(color: textColor, fontSize: 14)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '(${_selectedEstaciones.length})',
                        style: TextStyle(color: hintColor, fontSize: 14),
                      ),
                      const SizedBox(width: 8),
                      Icon(_expandEstaciones ? Icons.arrow_drop_up : Icons.arrow_drop_down, color: hintColor),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      _expandEstaciones = !_expandEstaciones;
                      if (_expandEstaciones) _expandPrograma = false; 
                    });
                  },
                ),

                // Desplegable de Estaciones
                if (_expandEstaciones) ...[
                  Divider(height: 1, color: borderColor),
                  _buildBuscador(_searchEstacionesController, 'Buscar estación...', isDarkMode),
                  SizedBox(
                    height: _estacionesFiltradas.length > 4 ? 200 : _estacionesFiltradas.length * 50.0,
                    child: ListView.builder(
                      itemCount: _estacionesFiltradas.length,
                      itemBuilder: (context, index) {
                        final est = _estacionesFiltradas[index];
                        final isSelected = _selectedEstaciones.contains(est);
                        return InkWell(
                          onTap: () => _toggleEstacion(est),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                            child: Row(
                              children: [
                                Icon(
                                  isSelected ? Icons.check_box : Icons.check_box_outline_blank,
                                  color: isSelected ? Colors.blueAccent : Colors.grey.shade600,
                                  size: 20,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    est,
                                    style: TextStyle(color: textColor, fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],

                Divider(height: 1, color: borderColor),

                // --- 3. CHECKBOX "TODAS LAS ESTACIONES" ---
                InkWell(
                  onTap: () => _toggleTodasLasEstaciones(!_todasLasEstaciones),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                    child: Row(
                      children: [
                        Icon(
                          _todasLasEstaciones ? Icons.check_box : Icons.check_box_outline_blank,
                          color: _todasLasEstaciones ? Colors.blueAccent : Colors.grey.shade600,
                          size: 20,
                        ),
                        const SizedBox(width: 16),
                        Text(
                          'Todas las estaciones',
                          style: TextStyle(color: textColor, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // --- BOTÓN OBTENER DATOS ---
          OutlinedButton(
            onPressed: () {
              debugPrint('Programa: $_selectedPrograma');
              debugPrint('Estaciones: $_selectedEstaciones');
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.blueAccent, width: 1.5),
              padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
            ),
            child: const Text(
              'OBTENER DATOS',
              style: TextStyle(color: Colors.blueAccent, fontSize: 12, letterSpacing: 1.2, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  // Helper interno para crear la barrita de búsqueda dentro del contenedor
  Widget _buildBuscador(TextEditingController controller, String hint, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: isDarkMode ? Colors.grey.shade500 : Colors.grey.shade500, fontSize: 14),
          prefixIcon: Icon(Icons.search, size: 20, color: isDarkMode ? Colors.grey.shade500 : Colors.grey.shade500),
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
          filled: true,
          fillColor: isDarkMode ? Colors.black26 : Colors.white, // Blanco puro en modo claro para que resalte sobre el gris del contenedor
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: BorderSide.none,
          ),
        ),
        style: TextStyle(fontSize: 14, color: isDarkMode ? Colors.white : Colors.black87),
      ),
    );
  }
}
