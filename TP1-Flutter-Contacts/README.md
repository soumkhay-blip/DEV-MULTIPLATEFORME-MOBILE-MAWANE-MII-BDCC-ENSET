# Contacts App — TP Flutter (Introduction à Flutter)

Application demandée à la slide 138 de la présentation *Introduction à Flutter* :
messagerie type WhatsApp avec backend **json-server**, authentification basique,
liste de contacts filtrable et conversation par contact.

## Fonctionnalités

- **Authentification basique** (collection `users` du json-server).
  Comptes de test : `admin` / `admin`, `soumia` / `1234`.
- **Contacts** : liste avec filtres *Tous / Étudiants / Enseignants / Développeurs*
  (filtrage côté serveur via `?type=`).
- **Messages d'un contact** :
  - liste des messages (bulles envoyées / reçues, triées par date) ;
  - **envoyer** un message (POST `sent`) ;
  - **afficher la réponse** à un message (bouton ↩ dans l'AppBar, POST `received`).

## Structure

```
lib/
├── main.dart                  # Point d'entrée + thème
├── models/
│   ├── contact.dart           # Modèle Contact (fromJson / toJson)
│   └── message.dart           # Modèle Message
├── services/
│   └── api_service.dart       # Appels HTTP vers json-server
└── screens/
    ├── login_page.dart        # Authentification
    ├── contacts_page.dart     # Liste + filtres
    └── messages_page.dart     # Conversation
db.json                        # Données du backend json-server
```

## Lancer le projet

### 1. Démarrer le backend (json-server)

Depuis le dossier du projet :

```bash
npx json-server --watch db.json --host 0.0.0.0 --port 3000
```

Ressources exposées : `/users`, `/contacts`, `/messages` sur le port 3000.

### 2. Configurer l'URL du backend

Dans `lib/services/api_service.dart`, adapter `baseUrl` selon la cible :

| Cible d'exécution            | baseUrl                          |
|------------------------------|----------------------------------|
| Émulateur Android            | `http://10.0.2.2:3000` (défaut)  |
| Chrome / Windows / Linux     | `http://localhost:3000`          |
| Téléphone physique (Wi-Fi)   | `http://IP_DU_PC:3000`           |

> `10.0.2.2` est l'alias que l'émulateur Android utilise pour joindre le
> `localhost` de la machine hôte.

### 3. Lancer l'application

```bash
flutter pub get
flutter run
```

## Notes techniques

- Code en **null-safety**, API Flutter modernes (`FilledButton`, `withValues`…),
  contrairement aux `RaisedButton` / `FlatButton` montrés dans la présentation
  (supprimés depuis Flutter 3).
- Le manifeste Android autorise le trafic HTTP en clair
  (`usesCleartextTraffic="true"`) pour pouvoir joindre json-server en local.
- Dépendances : `http` (réseau), `intl` (formatage des dates).
