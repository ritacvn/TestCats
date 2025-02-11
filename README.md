# 🐱 CatsTest

![Swift](https://img.shields.io/badge/Swift-5.0-orange)
![SwiftUI](https://img.shields.io/badge/SwiftUI-%23F05138.svg?style=flat&logo=swift&logoColor=white)
![XCTest](https://img.shields.io/badge/XCTest-Testing-blue)

## 📌 About the project
CatsTest it's an app that shows off a feed of cats images and details using the **The Cat API**.  
This project was developed using **SwiftUI**, following best practices for architecture and testability.

---

## 🚀 Features
- 📸 Displays cat images.
- 🏷️ Detailed information about each cat, including origin, weight, and temperament.
- 🔄 Infinite scrolling with pagination.
- ❌ Displays error messages when API requests fail.
- ✅ Unit and UI tests with **XCTest**.

---

## 📂 Project Architecture
This project follows the **MVVM architecture**, with well-structured components:


---

## 🛠 Requirements
- **macOS** 15.0 or later
- **Xcode** 16.1+
- **The Cat API Key** (Optional)

---

## 📥 Installation
Clone the repository and open the project in Xcode:

```bash
git clone https://github.com/your-username/CatsTest.git
cd CatsTest
open CatsTest.xcodeproj
````
---

## 🔑 API Key Configuration
If you want to use your own API Key, edit SecretsManager.swift:

```bash
class SecretsManager {
    static func getAPIKey() -> String? {
        return "YOUR_API_KEY_HERE"
    }
}

````

---
## 🚀 Running the Project
- Open the project in Xcode.
- Select a Simulator (e.g., iPhone 16).
- Click Run ▶️ or press Cmd + R.

---
## 👤 Author
Rita Vasconcelos.

[LinkedIn](https://www.linkedin.com/in/rita-vasconcelos-419a43165/)


