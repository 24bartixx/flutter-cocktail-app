# 🍸 Cocktail App 🍸
## Table of contents
* Features
* Technologies
* Screenshots
* Reflections

### Features
The app consists of 3 pages
* Main page with 'See cocktails button'
* Cocktails page with ListView presenting cocktails with search functionality
* Details page presenting specific of the chosen drink
  
#### Navigation
    Main Page -> Cocktails Page -> Details Page

### Technologies
* Flutter: Cross-platform framework for building the UI
* Dart: Programming language for writing Flutter applications
* HTTP Package: For making network requests and fetching cocktail data from the API

### Screenshots

<b>Main Page</b> - buttom 'See cocktails' to navigate to the cocktails page

<img width="220" alt="Main Page" src="https://github.com/user-attachments/assets/80f07443-b541-494d-8f64-e0f7fa7fe265">

 ---
<b>Cocktails Page</b>  - connect to API and show cocktails on the screen in a ListView, search functionality

<img width="220" alt="Cocktails Page 1" src="https://github.com/user-attachments/assets/f3e58a61-0ae6-4402-adb0-3791bc92ecae">
<img width="220" alt="Cocktails Page 2" src="https://github.com/user-attachments/assets/af58de08-5fd5-45c1-a641-34e3bde9d2a8">
<img width="220" alt="Cocktails Page 3" src="https://github.com/user-attachments/assets/fa775b00-52a3-47cd-a185-ac5461ffac88">

---
<b>Details Page</b> - details about chosen cocktail (high resolution image, category, glass, alcoholic, instructions and ingredients)

<img width="220" alt="Details Page 1" src="https://github.com/user-attachments/assets/3d693da5-ac32-43b7-9964-fca2d9e3351e">
<img width="220" alt="Details Page 2" src="https://github.com/user-attachments/assets/ff98bd29-31c0-488f-88e4-94135e520e9a">

---
<b>Ingredient description popup</b>

<img width="220" alt="Vodka description" src="https://github.com/user-attachments/assets/33272e7c-44d7-4da8-9afe-2d70c48b9525">
<img width="220" alt="Vodka description bottom" src="https://github.com/user-attachments/assets/2aaabc4f-9cbf-4372-9462-94d7faef5f7e">
<img width="220" alt="No description" src="https://github.com/user-attachments/assets/bfd774d3-d569-4170-9e0f-9e1021c98353">

### Reflection (Polish)

Aplikację zrobiłem w 4 dni, z czego jestem bardzo zadowolony, że udało się wszystko zaplanować i przenieść na kod w tak krótkim czasie. 

#### WAŻNE
Jednak aplikacja posiada jedną ogromną <b>wadę</b>, której jestem świadomy... Mianowicie na stronie wyświetlającej koktajle nie zastosowałem paginacji... Dowiedziałem się, że koktajle są przekazywane stronami podczas rozmowy z kolegą z kierunku 5 dni przed terminem oddania. Niestety w tym ostatnim tygodniu nie mam aż tyle czasu, aby to zmienić.

Jak to zmienić? Dopisać funkcję w API do pobierania koktajli z danej strony oraz ustawić listenera dojścia do końca ListView, w której uzupełnimy prezentowaną listę o kolejne dane. Byłbym to w stanie zrobić, lecz niestety nie mam aż tyle czasu w tym tygodniu jak wspomniałem, a bardzo zależy mi na SolVro....

Jeszcze nie zdążyłem dodać tłumaczań na inne języki, zaimplementować cache danych z API ani mechanizmu ulubionych... No lipa.. Przepraszam że taką słabą apkę przesyłam.
