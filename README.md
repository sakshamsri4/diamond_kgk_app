# diamond_kgk_app

A new Flutter project for managing diamond data with a focus on state management and persistent storage.

## Project Structure

- **lib/main.dart**: The entry point of the application.
- **lib/bloc/**: Contains the BLoC (Business Logic Component) files for managing state.
  - **cart/**: Manages the state of the shopping cart.
  - **filter/**: Manages the state of the diamond filter.
  - **theme/**: Manages the application's theme state.
- **lib/data/**: Contains data models and datasets.
  - **models/**: Defines the data models used in the application.
  - **kgk_dataset.csv**: A CSV file containing diamond data.
- **lib/presentation/**: Contains UI components.
  - **screens/**: Defines the different screens of the application.
  - **widgets/**: Contains reusable UI components.
- **lib/services/**: Provides services for data storage and retrieval.
- **lib/core/**: Contains core utilities and theme definitions.

## State Management Logic

The application uses the BLoC pattern for state management, which separates business logic from UI components. Each feature has its own BLoC to handle events and update the state accordingly. The main BLoCs are:

- **CartBloc**: Handles adding, removing, and clearing items in the shopping cart.
- **FilterBloc**: Manages the filtering of diamond data based on user input.
- **ThemeBloc**: Toggles between light and dark themes.

## Persistent Storage Usage

The application uses Hive for local data storage, providing a lightweight and fast database solution. Hive is used to store:

- **Cart Data**: The items added to the shopping cart are stored in a Hive box for persistence across sessions.
- **Theme Preferences**: The user's theme preference (light or dark) is stored to maintain consistency across app launches.

## Splash Screen

The application includes a splash screen that provides an initial loading experience while the app is being set up. This screen is displayed briefly before navigating to the onboarding or main screen, depending on whether the user has completed the onboarding process.

## Screenshots

Here are some screenshots of the application:

![Onboarding Screen](assets/screenshots/onboarding.png)
![Filter Screen](assets/screenshots/filter.png)
![Cart Screen](assets/screenshots/cart.png)
![Main Screen](assets/screenshots/Simulator%20Screenshot%20-%20iPhone%2015%20Pro%20Max%20-%202025-03-21%20at%2010.05.40.png)
![Settings Screen](assets/screenshots/Simulator%20Screenshot%20-%20iPhone%2015%20Pro%20Max%20-%202025-03-21%20at%2010.05.43.png)
![Profile Screen](assets/screenshots/Simulator%20Screenshot%20-%20iPhone%2015%20Pro%20Max%20-%202025-03-21%20at%2010.05.46.png)
![Search Screen](assets/screenshots/Simulator%20Screenshot%20-%20iPhone%2015%20Pro%20Max%20-%202025-03-21%20at%2010.05.52.png)
![Details Screen](assets/screenshots/Simulator%20Screenshot%20-%20iPhone%2015%20Pro%20Max%20-%202025-03-21%20at%2010.05.57.png)
![Checkout Screen](assets/screenshots/Simulator%20Screenshot%20-%20iPhone%2015%20Pro%20Max%20-%202025-03-21%20at%2010.06.04.png)
![Confirmation Screen](assets/screenshots/Simulator%20Screenshot%20-%20iPhone%2015%20Pro%20Max%20-%202025-03-21%20at%2010.06.12.png)
![Summary Screen](assets/screenshots/Simulator%20Screenshot%20-%20iPhone%2015%20Pro%20Max%20-%202025-03-21%20at%2010.06.16.png)
![Final Screen](assets/screenshots/Simulator%20Screenshot%20-%20iPhone%2015%20Pro%20Max%20-%202025-03-21%20at%2010.06.19.png)

For more information on Flutter development, view the [online documentation](https://docs.flutter.dev/), which offers tutorials, samples, guidance on mobile development, and a full API reference.
