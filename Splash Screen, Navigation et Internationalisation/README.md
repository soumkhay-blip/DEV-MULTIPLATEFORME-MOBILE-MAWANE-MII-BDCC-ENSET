# Séance 2 — Splash Screen, Navigation & Internationalisation — MAWANE (MII-BDCC, ENSET)

TP du module **Développement Mobile (Natif Android / Kotlin)**, Pr. **MAWANE**,
Master MII-BDCC, ENSET — Université Hassan II Casablanca.

Application Android (Kotlin) démontrant trois notions :

## Contenu

| Notion | Détail |
|--------|--------|
| **Splash Screen** | `SplashActivity` : écran de démarrage animé (fondu du logo), puis passage automatique à l'écran principal. |
| **Navigation entre écrans** | `MainActivity` → `SecondActivity` via `Intent` avec **passage de données** (le nom saisi), et retour avec `finish()`. |
| **Internationalisation** | Ressources `values/`, `values-fr/`, `values-ar/`. Bouton pour basculer **Français / العربية** (avec support RTL). Le choix est persisté (`SharedPreferences`) et appliqué via `attachBaseContext`. |

## Lancer

Ouvrir le dossier dans **Android Studio** → Sync Gradle → **Run ▶** (émulateur ou appareil).

## Dossier source local

Ce projet a été créé sur mesure ; il est situé dans :
`C:\Users\k.soumia\Desktop\App-Mobile\Seance2_Splash_Nav_i18n`
