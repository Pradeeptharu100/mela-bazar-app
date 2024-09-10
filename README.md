# Flutter Product Detail Project

This Flutter project is designed to showcase a product detail page using a clean code architecture with state management handled by Provider. The project also integrates local storage with Hive, notifications via `flutter_local_notifications`, and other essential features like carousel sliders, API calls, dark mode, and more.

## Features

- **Clean Code Architecture**: The project follows a clean code architecture, separating business logic, UI components, and data handling for better maintainability and scalability.
- **State Management**: State management is handled using the Provider package, making it easy to manage and update the state across the application.
- **Local Storage**: Hive is used for local storage, providing a lightweight and fast key-value store for persisting data locally.
- **Notifications**: Push notifications are implemented using `flutter_local_notifications` to alert users about important events, such as product updates or download progress.
- **Dark Mode**: The project includes a dark mode feature, allowing users to switch between light and dark themes.
- **Responsive UI**: The UI is designed to be responsive, working seamlessly across different screen sizes using `flutter_screenutil`.
- **Image Caching**: Images are cached using `cached_network_image`, which improves performance by reducing unnecessary network requests.
- **HTML Rendering**: The `flutter_widget_from_html` package is used to render HTML content within the app.
- **API Integration**: The Dio package is used for making HTTP requests to fetch data from APIs.

## Packages Used

Here is a list of the primary packages used in this project:

- **[flutter_local_notifications: ^17.2.2](https://pub.dev/packages/flutter_local_notifications)**: For handling local notifications.
- **[provider: ^6.1.2](https://pub.dev/packages/provider)**: For state management.
- **[carousel_slider: ^5.0.0](https://pub.dev/packages/carousel_slider)**: For creating image carousels.
- **[dio: ^5.7.0](https://pub.dev/packages/dio)**: For making HTTP requests.
- **[hive_flutter: ^1.1.0](https://pub.dev/packages/hive_flutter)**: For local storage.
- **[permission_handler: ^11.3.1](https://pub.dev/packages/permission_handler)**: For handling permissions.
- **[cached_network_image: ^3.4.1](https://pub.dev/packages/cached_network_image)**: For caching network images.
- **[flutter_widget_from_html: ^0.15.2](https://pub.dev/packages/flutter_widget_from_html)**: For rendering HTML content.
- **[logger: ^2.4.0](https://pub.dev/packages/logger)**: For logging.
- **[flutter_screenutil: ^5.9.3](https://pub.dev/packages/flutter_screenutil)**: For responsive UI design.

## Project Structure

The project is organized into the following main directories:

- **lib**
  - **models**: Contains the data models.
  - **providers**: Contains the state management logic using Provider.
  - **services**: Contains the service classes for API calls and local storage.
  - **Screens**: Contains the UI components and screens.
  - **Components**: Contains reusable UI components.

## Getting Started

To get started with this project, follow these steps:

1. **Clone the repository**:
   ```bash
   git clone https://github.com/Pradeeptharu100/mela-bazar-app.git
   cd mela-bazar-app
   ```
