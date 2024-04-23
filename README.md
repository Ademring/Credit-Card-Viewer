---

# Credit Card Viewer

Credit Card Viewer is a SwiftUI app that allows users to view a list of credit cards fetched from an API. Users can sort the cards by type, bookmark their favorite cards, and view details of each card.

## Features

- Fetch credit card data from an external API.
- Display fetched credit cards in a list.
- Sort credit cards by type or default order.
- Bookmark favorite credit cards.
- View details of each credit card.
- Throttle network requests to prevent excessive API calls.

## Screenshots

![image](https://github.com/Ademring/Credit-Card-Viewer/assets/167857995/387c0e3a-72cd-4a87-850f-65cf88e6e4f8)
![image](https://github.com/Ademring/Credit-Card-Viewer/assets/167857995/b1a54ca0-9e26-4045-8578-392f3b48d749)


## Installation

To run the app locally, follow these steps:

1. Clone the repository:

   ```
   git clone https://github.com/Ademring/Credit-Card-Viewer.git
   ```

2. Open the project in Xcode(recommend Version 15.3 (15E204a) or above).

3. Build and run the app on a simulator or device.

## Usage

- Launch the app to view the list of credit cards.
- Tap on a card to view its details.
- Use the sorting control to sort cards by type or default order.
- Tap the bookmark button on a card to bookmark it.
- Navigate to the "Saved Cards" tab to view bookmarked cards.
- The app automatically requests the next page of credit card data when the last card is displayed, ensuring a seamless browsing experience.

## Dependencies

No 3rd party libraries are required

## Credits

The credit card data is fetched from the [Random Data API: Cards](https://random-data-api.com/api/v2/credit_cards?size=100).

## License

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details.

---
