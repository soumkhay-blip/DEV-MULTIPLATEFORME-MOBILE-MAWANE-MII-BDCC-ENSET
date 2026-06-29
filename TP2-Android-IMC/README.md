# IMC App — TP Android natif (Java)

Application Android (Application 3 du support de cours *Développement Mobile - Natif Android*)
qui permet de :

- Saisir le **poids** (kg) et la **taille** (m) d'une personne ;
- Calculer et afficher l'**Indice de Masse Corporelle** : `IMC = poids / taille²` ;
- Afficher la **catégorie** de masse corporelle et une **image** color-codée correspondante ;
- Conserver un **historique** des calculs dans une `ListView`.

## Catégories d'IMC (OMS)

| IMC | Catégorie | Couleur |
|---|---|---|
| < 18,5 | Insuffisance pondérale (maigreur) | Bleu |
| 18,5 – 24,9 | Corpulence normale | Vert |
| 25 – 29,9 | Surpoids | Orange |
| 30 – 34,9 | Obésité modérée (Classe I) | Orange foncé |
| 35 – 39,9 | Obésité sévère (Classe II) | Rouge |
| ≥ 40 | Obésité morbide (Classe III) | Rouge foncé |

## Structure

```
IMC_App/
├── settings.gradle, build.gradle, gradle.properties
└── app/
    ├── build.gradle
    └── src/main/
        ├── AndroidManifest.xml
        ├── java/com/example/imc_app/MainActivity.java
        └── res/
            ├── layout/activity_main.xml
            ├── values/   (colors, strings, themes)
            └── drawable/ (edit_text_style, text_view_style, ic_person, ic_launcher)
```

## Ouvrir et lancer

1. **Android Studio** → *File > Open* → sélectionner le dossier `IMC_App`.
2. Au premier ouverture, Android Studio synchronise Gradle et génère automatiquement
   le *Gradle Wrapper* (version définie dans `gradle/wrapper/gradle-wrapper.properties`).
3. Lancer sur un émulateur (AVD) ou un appareil physique avec le bouton **Run ▶**.

> Versions ciblées : `compileSdk 35`, `minSdk 24`, AGP 8.7, Java 17 — compatibles avec
> les SDK installés sur la machine (platforms 35/36, build-tools 36/37).

## Code de référence

Le pattern (EditText → Button « Compute » → TextView résultat → ListView historique)
est repris de la première application du cours (le convertisseur Euro → DH), adapté
ici au calcul de l'IMC avec deux entrées (poids et taille) et l'affichage d'une image
selon la catégorie.
