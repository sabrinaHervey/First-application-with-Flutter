# Quiz Culture Générale

Une application mobile de quiz développée avec Flutter pour apprendre le développement mobile.

## Fonctionnalités

- 10 questions de culture générale
- Feedback visuel immédiat (vert = bonne réponse, rouge = mauvaise réponse)
- Barre de progression
- Score final avec message personnalisé
- Bouton "Rejouer" pour recommencer

## Architecture

```
lib/
├── main.dart               # Point d'entrée de l'application
├── models/
│   └── question.dart       # Modèle de données Question
├── data/
│   └── questions.dart      # Liste des 10 questions
└── screens/
    ├── home_screen.dart    # Écran d'accueil
    ├── quiz_screen.dart    # Écran de quiz (questions + réponses)
    └── result_screen.dart  # Écran de résultats
```

## Technologies

- [Flutter](https://flutter.dev/) — framework UI multiplateforme
- [Dart](https://dart.dev/) — langage de programmation

## Lancer le projet

```bash
flutter pub get
flutter run
```
