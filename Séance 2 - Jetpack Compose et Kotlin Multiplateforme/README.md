# Séance 2 — Jetpack Compose et Kotlin Multiplateforme — MAWANE (MII-BDCC, ENSET)

TP du module **Développement Mobile (Natif Android / Kotlin)**, Pr. **MAWANE**,
Master MII-BDCC, ENSET — Université Hassan II Casablanca.

Reprise en **Jetpack Compose** (UI déclarative) des exemples vus en cours (support
*Développement Mobile Natif - Partie 2*) :

## Contenu

| Notion | Détail |
|--------|--------|
| **Splash screen** | Écran de démarrage (délai de 3s) puis navigation automatique vers l'accueil. |
| **Click / LongClick** | Bouton géré avec `combinedClickable` (onClick + onLongClick), texte mis à jour et `Toast`. |
| **Navigation entre écrans** | Accueil → Connexion (saisie + validation) → écran de confirmation (retour), via Jetpack Navigation Compose. |
| **Internationalisation** | Ressources `values/` (EN par défaut), `values-fr/`, `values-ar/`. |

## Lancer

Ouvrir le dossier dans **Android Studio** → Sync Gradle → **Run ▶** (émulateur ou appareil),
ou compiler en ligne de commande avec `gradlew assembleDebug`.

## Dossier source local

`C:\Users\k.soumia\Desktop\App-Mobile\TP2-JetpackCompose`
