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

# Structure of Firebase database

The database is structured into two main collections: "categories" and "recipes":

1. Categories Collection

- name (String): Name of the category.

Example:
```
{
  "name": "Asian"
}
```

2. Recipes Collection

- name (String): Name of the recipe.
- categoryId (String): Reference to the ID of the category this recipe belongs to.
- ingredients (array of Strings): List of ingredients required for the recipe.
- steps (Array of Strings): List of steps to prepare the recipe.
- userId (String): ID of the user who created the recipe.
- favorites: subcollection, contains data about users who favorited the recipe.

Example:

```
{
  "name": "Pad Thai",
  "categoryId": "bteVDf5favqD1hjWUfK1",
  "ingredients": [
    "200g rice noodles",
    "150g shrimp or chicken"
  ],
  "steps": [
    "Soak the rice noodles in warm water for 30 minutes, then drain.",
    "Heat vegetable oil in a wok or large frying pan over medium heat."
  ],
  "userId": "c9lztwtijdQZagUiRmsQf55BS32"
}
```

3. Favorites subcollection
- The document ID is unique for each user marking the recipe as a favorite. It often represents the user's unique ID (userId).

- isFavorite (Boolean): Indicates whether the recipe is marked as a favorite by the specific user.

Example:

```
{
  "isFavorite": true
}
```