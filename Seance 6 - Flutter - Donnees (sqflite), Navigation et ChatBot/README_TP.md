# Flutter P3 — Gestion des données & UI — MAWANE (MII-BDCC, ENSET)

TP du module **Développement Mobile (Flutter)** — Partie 3, Pr. **MAWANE**,
Master MII-BDCC, ENSET — Université Hassan II Casablanca.

Un écran d'accueil donne accès aux trois travaux du PDF.

## Contenu

| Partie | Fichiers | Description |
|--------|----------|-------------|
| **Activité 1 — CRUD sqflite** | `lib/models/user.dart`, `lib/db/database_helper.dart`, `lib/screens/users_screen.dart` | Base SQLite (`sqflite`) : ajouter, lister, modifier, supprimer des utilisateurs (avec dialogue de confirmation avant suppression). |
| **Activité 2 — Navigation** | `lib/screens/navigation_demo.dart` | Deux écrans `FirstRoute` / `SecondRoute` avec `Navigator.push()` et `Navigator.pop()`. |
| **Projet — ChatBot ChatGPT** | `lib/services/chat_service.dart`, `lib/screens/chat_screen.dart` | Conversation avec l'API OpenAI (ChatGPT). |

## Configuration du ChatBot

Le ChatBot nécessite une **clé API OpenAI**. Ouvrir `lib/services/chat_service.dart`
et remplacer la constante `_apiKey` (`VOTRE_CLE_API_OPENAI`) par ta clé
(obtenable sur https://platform.openai.com). Sans clé, l'app affiche un message
d'invitation à la configurer (elle ne plante pas).

## Lancer

```bash
flutter pub get
flutter run
```

> `sqflite` fonctionne sur émulateur/appareil (Android/iOS), pas sur le web.
> Permission `INTERNET` déjà déclarée pour le ChatBot.

## Dossier source local

Énoncés du TP :
- `C:\Users\k.soumia\Desktop\App-Mobile\Flutter_P3.pdf`
- `C:\Users\k.soumia\Desktop\App-Mobile\presentation_flutter.pdf` (cours théorique gestion d'état)
