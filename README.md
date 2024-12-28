# Device-Agnostic Design Course Project II - c333df9a-e432-4e8d-9ac2-b1b7ff0baf4d

# Recipe application

An application that uses Flutter to build a recipe app with Firebase back-end. Main features of the application are:
- Viewing individual recipes
- Listing recipe categories
- Listing recipes in a given category
- Searching recipes by name. 
- For authenticated users, the application in addition allows creating and editing recipes, marking recipes as favorite, and listing favorite recipes.

## Challenges and learning moments

During the project development, there are challenges and learning moments as below:
</br> <h3> Challenges: </h3>
- Implement the Favorite shema in database
- Managing the state of the application, especially when implementing the favorite feature, how to both change data in Firebase and update the UI simutaneously
- Improving the UI looking is quite challenging to me, when there is no predefined design and template, so I have to think of it by myself.

<h3> Learning moments: </h3>

- Implementing features like retrieving, updating, and deleting data from Firebase back end.
- Working on this project also enhanced my understanding of Flutter's state management, especially with Riverpod package
- Improving my skills in application responsiveness, especially handle multiple screen sizes.

## List of dependencies

- cupertino_icons: ^1.0.6
- go_router: ^14.6.2
- http: ^1.2.1
- shared_preferences: ^2.2.2
- mockito: ^5.4.4
- build_runner: ^2.4.9
- firebase_core: ^3.8.1
- cloud_firestore: ^5.5.1
- hooks_riverpod: ^2.6.1
- flutter_hooks: ^0.20.5
- firebase_auth: ^5.3.4