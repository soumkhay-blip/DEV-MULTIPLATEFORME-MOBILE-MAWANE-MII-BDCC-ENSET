# Développement Mobile Natif (Partie 2) — MAWANE (MII-BDCC, ENSET)

TP du module **Développement Mobile Natif Android (Kotlin)** — Partie 2, Pr. **MAWANE**,
Master MII-BDCC, ENSET — Université Hassan II Casablanca.

## Contenu

### Activité 1 — Gestion des événements (`MainActivity`)
- **Click** et **Long Click** sur un bouton (avec `Toast`).
- **OnTouch** sur une zone (DOWN / MOVE / UP).
- **TextChange** sur un champ de saisie (`TextWatcher`).
- **Navigation** vers l'Activité 2 via un `Intent`.

### Activité 2 — Météo (`WeatherActivity`)
- Saisie d'une **ville**.
- Appel de l'**API REST OpenWeather** (`/data/2.5/forecast`).
- Affichage des prévisions dans une `ListView` : **date/heure, température min/max, pression, humidité, description**.

## Structure

```
app/src/main/
├── java/com/enset/mobilenatifp2/
│   ├── MainActivity.kt        (Activité 1 : événements)
│   ├── WeatherActivity.kt     (Activité 2 : météo, appel HTTP)
│   ├── Forecast.kt            (modèle de prévision)
│   └── ForecastAdapter.kt     (adaptateur ListView)
└── res/
    ├── layout/ (activity_main, activity_weather, item_forecast)
    ├── values/ (strings, colors, themes)
    └── drawable/ (input_shape, ic_launcher)
```

## Lancer

1. **Android Studio** → *File > Open* → dossier `MobileNatifPartie2` → laisser la synchro Gradle générer le wrapper.
2. **Run ▶** sur un émulateur/appareil (permission `INTERNET` déjà déclarée).
3. Pour l'Activité 2, une **clé API OpenWeather** est configurée dans `WeatherActivity.kt`
   (`API_KEY`). Remplace-la par ta propre clé si le quota de démonstration est épuisé.

> Versions : `compileSdk 35`, `minSdk 24`, Kotlin 1.9, AGP 8.7, Java 17.

## Dossier source local

Énoncé du TP : `C:\Users\k.soumia\Desktop\App-Mobile\Dév_Mobile_Natif_Partie2.pdf`
