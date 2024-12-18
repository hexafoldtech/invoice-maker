# Invoice Maker

Invoice Maker simplifies the process of sending invoices and receiving payments.
It helps you track outstanding payments and maintain a professional image with your clients.
Give it a try and see how much easier your financial management can be!

## Tools & Versions
- **Flutter**: 3.19.3
- **Dart**: 3.3.1

## Directory Structure

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
- **UI Designs**: [Insert design links or references here]
- **Version Control**: [Invoice Maker GitHub Repository](https://github.com/hexafoldtech/invoice-maker)
- **Task Board**: [Insert task board link or tool name here]
- **App Deployment**: [Insert deployment details here]

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/hexafoldtech/invoice-maker.git```
2. Install the required dependencies:
   ```bash
   flutter pub get```
3. Run the application
    ```bash
   flutter run```
