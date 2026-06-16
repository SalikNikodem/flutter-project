# Anime & Manga Tracker

A mobile application built with Flutter that allows users to browse, search, and track information about anime and manga. The project utilizes the open Jikan API (a REST API linked to MyAnimeList).

## Features

*   **Two main screens:** A home screen featuring a list of the most popular titles and a detailed screen for a selected anime/manga.
*   **REST API Integration:** Fetching trending lists and detailed information (statistics, ratings, descriptions) using the Jikan API.
*   **Offline Mode:** Integration with a local database to enable browsing previously fetched data without an internet connection.
*   **State Management:** Handling data loading states (loading spinners/skeletons) and clear error communication for the user (e.g., no network connection).

## Project Structure

* `models/anime.dart`**: Defines the `Anime` data model.
* `services/anime_api_service.dart`: Manages HTTP requests to the Jikan REST API, fetching both the top trending anime list and specific search queries.
* `services/anime_local_database.dart`: Handles local persistence using the Hive database to allow offline data access and manage the user's favorite titles.
* `services/anime_sync_service.dart`: Coordinates data synchronization by preloading cached local data or fetching fresh updates from the API when needed.
* `screens/home_screen.dart`: The main dashboard showcasing a list of top anime with full pull-to-refresh capabilities, error feedback, and loading states.
* `screens/detail_screen.dart`: Displays extensive information.
* `main.dart`: The application entry point responsible for initializing local databases.