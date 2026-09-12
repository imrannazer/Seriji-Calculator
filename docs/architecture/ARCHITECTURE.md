# Siraji — System Architecture

## Overview
Siraji is a multi-platform Islamic inheritance (Faraid) calculation, property distribution, and estate management system built with Flutter and Dart for Android, iOS, and Web.

## Core Architectural Layers
1. **Presentation / UI**: Flutter Material 3 widgets with custom Siraji design tokens (Emerald Green, Gold, Cream).
2. **Navigation**: `go_router` centralized named routing.
3. **Domain Layer**: Pure Dart business logic and models. Zero Flutter UI dependencies.
4. **Calculation Engine**: Modular Faraid calculation pipeline (Validation -> Eligibility -> Exclusion -> Shares).
5. **Data & Persistence**: Drift cross-platform SQLite database (Native for mobile, WASM for Web) accessed via repository pattern.
