import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // 1. DEFINIÇÃO DA PALETA DE CORES
  // Cores principais para um aplicativo de finanças
  static const Color primaryColor = Color(0xFF00B0FF); // Azul Claro Vívido
  static const Color secondaryColor = Color(
    0xFF00C853,
  ); // Verde para Receita/Sucesso
  static const Color errorColor = Color(
    0xFFD50000,
  ); // Vermelho para Despesa/Erro
  static const Color backgroundColor = Color(0xFFF5F5F5); // Fundo Cinza Claro

  static final ColorScheme _lightColorScheme = ColorScheme.light(
    primary: primaryColor,
    secondary: secondaryColor,
    error: errorColor,
    background: backgroundColor,
    onBackground: Colors.black87,
    surface: Colors.white,
    onSurface: Colors.black87,
  );

  // 2. DEFINIÇÃO DO TEMA
  static ThemeData get lightTheme {
    return ThemeData(
      // 2.1. Color Scheme
      colorScheme: _lightColorScheme,
      useMaterial3: true,

      // 2.2. Tipografia (Google Fonts)
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme),

      // 2.3. Configuração do AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: _lightColorScheme.surface, // AppBar Branca
        foregroundColor: _lightColorScheme.onSurface, // Ícones e texto Pretos
        elevation: 1, // Leve sombra
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: _lightColorScheme.onSurface,
        ),
      ),

      // 2.4. Configuração do Botão Principal (ElevatedButton)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor, // Fundo Azul
          foregroundColor: Colors.white, // Texto Branco
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
      ),

      // 2.5. Configuração da Barra de Navegação Inferior
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: _lightColorScheme.surface,
        selectedItemColor: primaryColor, // Item ativo em Azul
        unselectedItemColor: Colors.grey.shade600,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
