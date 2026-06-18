# Anime & Manga Tracker

Aplikacja mobilna stworzona w Flutterze, która pozwala przeglądać i śledzić informacje o anime. Projekt korzysta z darmowego Jikan API (powiązanego z serwisem MyAnimeList).

## Główne funkcje

* **Dwa ekrany:** Ekran główny z listą popularnych tytułów oraz ekran ze szczegółowymi informacjami o wybranej serii.
* **Pobieranie danych (API):** Dynamiczne pobieranie trendów, ocen i opisów prosto z internetu.
* **Tryb offline:** Zapisywanie danych w lokalnej bazie, co pozwala na przeglądanie aplikacji bez dostępu do sieci.
* **Płynne działanie:** Obsługa stanów ładowania (animacje/szkielety) oraz jasne komunikaty o błędach (np. brak połączenia).

## Struktura projektu

* `models/` – modele danych (struktura obiektów anime).
* `services/`
  * `anime_api_service.dart` – obsługa zapytań do API.
  * `anime_local_database.dart` – zapisywanie ulubionych i danych offline (baza Hive).
  * `anime_sync_service.dart` – synchronizacja danych między siecią a pamięcią telefonu.
* `screens/` – widoki aplikacji (ekran główny z odświeżaniem oraz ekran szczegółów).
* `main.dart` – punkt startowy aplikacji i konfiguracja bazy danych.
