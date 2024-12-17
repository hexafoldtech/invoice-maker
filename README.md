# invoice_maker
Invoice Maker allows you to simplify the process of sending invoices and receiving payments.
It can also help you keep track of any outstanding payments and look professional in the eyes of your clients.
Give it a try and see how much easier your financial management can be!

## Tools & Versions
- Flutter 3.19.3
- Dart 3.3.1

## Directory Structure
lib/
├── core/                      # Core utility classes and shared code
│   ├── constants/             # Constants, enums, and configurations
│   ├── exceptions/            # Custom error classes or exception handling
│   ├── utils/                 # Utility functions and classes
│   └── widgets/               # Reusable UI components (e.g., custom buttons, dialogs)
├── models/                    # Data models and classes (representing the data)
│   ├── invoice.dart           # Example model representing an invoice
│   └── user.dart              # Example model representing a user
├── services/                  # Services that interact with external systems (e.g., API)
│   ├── api_service.dart       # API interaction logic (e.g., HTTP requests)
│   └── auth_service.dart      # Authentication and related logic
├── repositories/              # Logic for fetching data and managing state
│   ├── invoice_repository.dart # Handling operations related to invoices
│   └── user_repository.dart    # Handling operations related to users
├── view_models/               # ViewModels, providing business logic for the UI
│   ├── invoice_view_model.dart # ViewModel for managing invoice data and logic
│   └── user_view_model.dart    # ViewModel for managing user-related logic
├── views/                     # UI components (screens and pages)
│   ├── invoice_screen.dart    # Screen for listing and managing invoices
│   └── user_screen.dart       # Screen for user-related actions (e.g., login)
├── main.dart                  # Entry point of the application
└── routes.dart                # Define app routes and navigation

## Project Management Tools
- UI Designs:
- Version Control: https://github.com/hexafoldtech/invoice-maker
- Task Board:
- App Deployment:
