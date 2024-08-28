# AdvaTaskUI

## Overview
AdvaTaskUI is a photo gallery application that displays images in a list format, allowing users to zoom in on photos by double-tapping. The project follows the VIPER architecture pattern.

## Prerequisites
- iOS 16.0 
- Swift 5.0 

## Features
- Display a list of photos with titles.
- Zoom and pan on photos using multi-touch gestures.
- Fetch photos from the JSONPlaceholder API.

## VIPER Architecture
The application is structured using the VIPER architecture, with the following components:

- **View**: `PhotoListView`, `PhotoDetailView`
- **Interactor**: Not implemented in this simple example since there is no complex data logic.
- **Presenter**: Logic related to the presentation is handled within the `PhotoListViewModel`.
- **Entity**: `Photo`
- **Router**: Navigation is managed through `NavigationLink` for transitioning between views.

## How to Run
1. Open the project in Xcode.
2. Run the project on a simulator or a real device.
3. Navigate to the `Photo Gallery` to view the photo list.
4. Tap on any photo to open the detail view and use gestures to zoom in or out.

## Unit Tests
Unit tests have been implemented using `XCTest` to cover the following components:
- `PhotoListViewModel`: Tests the photo loading functionality.
- `ImageLoader`: Tests the image loading from a URL.

### To Run Unit Tests:
1. Open the project in Xcode.
2. Press `Cmd + U` to run the tests.

## References
- [JSONPlaceholder](https://jsonplaceholder.typicode.com/): API used for testing data.



   

