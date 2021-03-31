# Cantina

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
Cantina is a personal cookbook for cocktails. You are able to browse through cocktails and mixed drinks to find the ones that you might enjoy, save your favorites and come back to them later, and learn how to make the drink that you've been dreaming of.

### App Evaluation
- **Category:** Food and Drink
- **Mobile:** A mobile application is necessary for this idea because it is inconvenient to have to visit a website and log in to view drink recipes and favorites
- **Story:** Concept is not complicated and brings value to people
- **Market:** Anyone that is interested in making drinks
- **Habit:** User opens the app whenever making a drink, strongly correlated to drinking habits
- **Scope:** App is easy to implement, API exists

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User is greeted to an app with a great design
* User can browse a list of cocktails
* User can favorite cocktails
* User can view favorited cocktails
* User can switch between views via a tab bar
* User can view details (ingredients, image, etc.) for a cocktail

**Optional Nice-to-have Stories**

* User can share a cocktail recipe through the OS share sheet
* User can search for a cocktail
* User can filter cocktails by ingredient
* User can browse favorite cocktails offline
* User can add notes to a cocktail

### 2. Screen Archetypes

* Cocktails Screen
   * User can browse a list of cocktails
   * User can favorite cocktails
* Favorites Screen
   * User can view favorited cocktails
* Cocktail Detail Screen
    * User can view details (ingredients, image, etc.) for a cocktail
    * User can favorite cocktails

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Cocktails Screen
* Favorites Screen

**Flow Navigation** (Screen to Screen)

* Cocktails Screen
=> Cocktail Detail Screen
* Favorites Screen
=> Cocktail Detail Screen

## Wireframes
<img src="https://i.imgur.com/jsyIYLE.png" width=600>

## Schema

### Models
We are not using a database through a service like Parse; instead we are storing all the data we need on the user's device.

#### Persistent Data on Device (UserDefaults)
Property | Type | Description 
---------|------|------------
`favorites` | `[String: Cocktail]` | a mapping of favorited cocktail ID's to their data (the data will only be present if offline storage is implemented; otherwise, it is just an array of IDs)
  
#### Cocktail Model
This is the model that will be used to parse information from the API. This model will also be used to store favorited cocktails if we implement the nice-to-have stories.

Property | Type | Description
---------|------|------------
`id` | `String` | id of the cocktail
`name` | `String` | name of the cocktail
`ingredients` | `[String: String]` | a mapping of cocktail ingredients to their measurements
`instructions` | `String` | a list of steps to make the cocktail
`glass` | `String` | the type of glass for serving the cocktail
`imageUrl` | `String` | a url for the image of the cocktail
`notes` | `String` | user created notes about the cocktail (nice-to-have)

### Networking
Because we are not using a database, we do not create any API calls to Parse or a server we made ourselves. Instead, we are receiving all data from an already-existing API, TheCocktailDB.

#### TheCocktailDB
Base URL: [https://www.thecocktaildb.com/api/json/v1/1/](https://www.thecocktaildb.com/api/json/v1/1/)

  HTTP Verb | Endpoint | Description
  ----------|----------|------------
  `GET`     | /search.php | searches for a cocktail by name
  `GET`     | /filter.php | searches for a cocktail by ingredient
  `GET`     | /lookup.php | gets the details of a cocktail by id
  `GET`     | /images/media/drink/<id>.jpg | gets the image for a cocktail

