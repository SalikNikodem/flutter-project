# Anime & Manga Tracker

A mobile application built with Flutter that allows users to browse, search, and track information about anime and manga. The project utilizes the open Jikan API (a REST API linked to MyAnimeList).

## Features

*   **Two main screens:** A home screen featuring a list of the most popular titles and a detailed screen for a selected anime/manga.
*   **REST API Integration:** Fetching trending lists and detailed information (statistics, ratings, descriptions) using the Jikan API.
*   **Offline Mode:** Integration with a local database to enable browsing previously fetched data without an internet connection.
*   **State Management:** Handling data loading states (loading spinners/skeletons) and clear error communication for the user (e.g., no network connection).