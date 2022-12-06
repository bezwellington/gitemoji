
# GitEmoji

## Architecture: VIPER

## Design Pattern: 

- Mapper: Conversion of entities
- Adapter: It's communicating with the GitHub API

## Basic communication architecture of the Interactors of the project:

<img width="952" alt="Screenshot 2022-12-05 at 11 45 54" src="https://user-images.githubusercontent.com/17457196/205893902-bbb1ca30-b8a3-4e64-93c9-319a4d0ed703.png">

## Use cases:

- Creation of 2 use cases that are reused in the project:

   - Avatar:
     - Responsible use case to save, read and remove an avatar's information from disk and make a request to receive an avatar's information.
    
   - Emoji:
     - Use case responsible for making a request to receive the list of emojis, read and save the emojis to disk and draw an emoji.
     
## Unit Tests 

- AvatarInteractor:
    
<img width="1003" alt="Screenshot 2022-12-05 at 23 08 05" src="https://user-images.githubusercontent.com/17457196/205894051-2b4c4d22-9261-4a49-a41e-6b086807e785.png">

- EmojiInteractor:
    
<img width="1002" alt="Screenshot 2022-12-05 at 23 44 21" src="https://user-images.githubusercontent.com/17457196/205894088-7a58b3cb-31d1-4f0e-a1fe-09efac822e03.png">

## FETCH EMOJI BUTTON

- The first time this button is pressed, we make a request and the emojis are stored in the UserDefault by the EmojiStorage class and an alert is displayed: “Emojis stored successfully!"

- Second or more times the button is pressed, we do not make a request because we get the emojis from the cache and present an alert to the user: "The Emojis are already stored!"

## RANDOM EMOJI BUTTON

- First time this button is pressed, I display an alert warning that the user needs to press the “FETCH EMOJI” button first

- Second or more times the button is pressed, 1 item is randomly drawn from the dictionary stored in the cache and the image is loaded in the imageView using the SDWebImage dependency asynchronously.

## APPLE REPOS BUTTON

- Use of the URLSession itself to make the requests

- Storage: Class responsible for storing items in the cache in Dictionary format the complexity of the search to be in an order of O(1) - I used UserDefaults as a native UIKit tool for storage in order to avoid the use of dependency with external libraries .

- Each pagination performed, we check the existence of the item in the cache and if it does not exist yet, it will be stored.

- We present all data from the cache to the user in case of failure with the request.

- We use loading to improve the user experience and show him that the screen is in a loading state.

## BUTTON EMOJI LIST

- Implementation of a collection view to load data from the class that stores emojis called EmojiStorage

- Customization of a cell for collection view with an ImageView where we use the SDWebImage dependency to asynchronously load the emoji image.

- We create an intermediate array of emojis called filteredEmojiList for removing an emoji in memory. This structure was necessary because from a swipedown action, we should present all the initial emojis again.

- We created an alert that shows the emoji image before removing it. If the user presses the removal confirmation button, the emoji will then be removed from the list.

- Use of the native component UIRefreshControl to identify a swipedown action and update the array of emojis with the same initial emojis keeping the same order.

## SEARCH AVATAR

- Use of a Storage class to save the avatar on disk if it doesn't exist.

- Use of the UIAlertController native component to handle the case that the user has not typed any text or the lack of an avatar with the searched word

## AVATAR LIST

- Display all locally stored avatars

- Reusing the screen called “GenericListViewController” to display the avatar list

- Avatar removal using the UIAlertController component

## Use of PRIVATE in outlets and functions and FINAL in classes to improve project compilation time.
    
