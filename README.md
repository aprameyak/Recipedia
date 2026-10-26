# Recipedia

Recipedia is a Flutter app for sharing and browsing recipes, backed by Supabase for accounts and profiles. The repo also contains a small Next.js site in `webapp/` with the app's landing, support, and privacy pages.

Recipedia started as ChefSocial.

## Project status

This is a work in progress. Auth and profiles talk to Supabase, but recipes do not yet:

- The home feed, recipe detail, and search screens read from hardcoded mock recipes in `lib/services/recipe_service.dart`.
- The post screen (`lib/pages/post.dart`) validates the form and shows a confirmation, but does not save the recipe anywhere.
- The favorites screen (`lib/pages/favorites.dart`) is a placeholder.

## Features

- Email/password sign up, login, and password reset through Supabase Auth, with an auth gate that routes signed-in users to the home screen (`lib/auth/`)
- User profiles stored in a Supabase `profiles` table, with display name, bio, and privacy flag (`lib/services/profile_service.dart`)
- Profile photo upload from camera or gallery with cropping, stored in a Supabase `avatars` storage bucket (`lib/utils/image_picker_utils.dart`)
- Recipe feed with featured, trending, and recent sections, plus search and category filters (currently over mock data)
- Optional random food background on the home screen from the Pexels API

## Tech stack

- Mobile app: Flutter, Dart, `supabase_flutter`, `image_picker`, `image_cropper`, `flutter_dotenv`
- Backend: Supabase (Auth, Postgres, Storage)
- Web site: Next.js 15, React 19, TypeScript, Tailwind CSS 4
- Experimental: a Rust crate in `rust/` wired up with `flutter_rust_bridge`, not currently called by the app

## Getting started

### Flutter app

Prerequisites: Flutter with Dart SDK 3.8 or newer. Because `rust_builder/` is a path dependency, a Rust toolchain may also be needed to build the native library.

1. `pubspec.yaml` lists `assets/backend/credentials/.env` as an asset, and that file is gitignored, so create it before building:

   ```sh
   mkdir -p assets/backend/credentials
   touch assets/backend/credentials/.env
   ```

   The only variable the app reads from it is `PEXELS_API` (optional; without it the home screen uses a fixed fallback image).

2. Install packages and run:

   ```sh
   flutter pub get
   flutter run
   ```

The Supabase project URL and anon key are set in `lib/main.dart`. To use your own Supabase project, change them there and run `database_setup.sql` in the Supabase SQL editor. It creates the `profiles` table, row level security policies, the new-user trigger, and the `avatars` storage bucket.

### Web site

```sh
cd webapp
npm install
npm run dev
```

`npm run lint` and `npm run build` are what CI runs (`.github/workflows/ci.yml`).

### Tests

`integration_test/simple_test.dart` is left over from the `flutter_rust_bridge` template and expects a Rust greeting that the app no longer shows, so it does not pass against the current app. CI only checks the web site.

## How it works

- `lib/main.dart` loads the `.env` asset, initializes Supabase, and shows `AuthGate` (`lib/auth/gate.dart`), which listens to Supabase auth state and shows either the login page or the home page.
- After login, a bottom navigation bar (`lib/widgets/main_scaffold_with_bottom_navbar.dart`) switches between home, search, post, favorites, and profile pages in `lib/pages/`.
- `ProfileService` reads and writes the `profiles` table and the `avatars` bucket. `RecipeService` returns mock `Recipe` objects (`lib/models/recipe.dart`) and is the place to swap in a real data source.
- `webapp/` is a separate Next.js App Router site with `/`, `/support`, and `/privacy` pages. It does not talk to Supabase.

## Project structure

```
lib/                Flutter app (auth, pages, services, models, widgets, theme)
lib/src/rust/       Generated flutter_rust_bridge bindings
rust/               Experimental Rust crate (not used by the app yet)
rust_builder/       Cargokit build glue for the Rust crate
webapp/             Next.js landing, support, and privacy site
database_setup.sql  Supabase schema, policies, and storage bucket
android/ ios/ web/ macos/ linux/ windows/   Flutter platform folders
```

## Contributing

Issues and pull requests are welcome. Before opening a PR, run `flutter analyze` for app changes and `npm run lint && npm run build` in `webapp/` for site changes.

## License

MIT, see [LICENSE](LICENSE).
