# Photogrid

Photogrid is an iOS application that allows its users to view their photos and take as many photos as they want. It was created to exemplify the use of Apple's [PhotoKit](https://developer.apple.com/documentation/photokit) library.

## Summary
<!--ts-->
  * [Author](#author)
  * [Architecture](#architecture)
  * [How to run the application](#how-to-run-the-application)
  * [Features](#features)
    * [1. Launch Screen](#1-launch-screen) 
    * [2. Home](#2-home)
    * [3. Photo detail and zoom](#3-photo-detail-and-zoom)
    * [4. Take photos](#4-take-photos)
    * [5. Delete photo](#5-delete-photo)
    * [6. Photo library permission handle](#6-photo-library-permission-handle)
 <!--te-->

## Author

#### Bruno Duarte Pereira Santos

I've been working on the iOS platform for 6+ years now using Swift and Objective-C, but I also have 7+ years developing web applications and APIs using Ruby on Rails, Angular, and NodeJs. I have worked on applications of every size, from startups to international brands. I also have a lot of experience working with layouts and components since I started my professional career as a designer.

Find more about me on my social pages below.
[LinkedIn](https://www.linkedin.com/in/brunopereiras/) - [Github](https://github.com/duarte-bruno)

## Architecture

The application was developed using [MVVM Architecture](https://www.raywenderlich.com/34-design-patterns-by-tutorials-mvvm), to have a clear separation of responsibilities and make the application easier to carry out future maintenance.

Opening the application code you will find the folder structure below:

```
- App -> Project configuration files
- Services -> Classes responsible for libraries and external services
- Controllers -> Application screen controllers (MVVM Views)
- ViewModels -> Classes with the business rules of each screen (View models from MVVM)
- Views -> Custom components for the application

(Currently, the app does not have custom application models, so the MVVM Models folder does not exist in this application.)
```

## How to run the application

1. Before you begin you will need to have the following tools installed on your machine:
- [Git](https://github.com/git-guides/install-git)
- [Xcode](https://developer.apple.com/xcode/)

2. After installing the clone tools or download [this repository](https://github.com/duarte-bruno/photo-grid) on your computer.

3. Open the photo-grid.xcodeproj file with XCode and click run.

## Features

### 1. Launch Screen

![](https://github.com/duarte-bruno/photo-grid/blob/master/Prints/launch-screen.PNG)

### 2. Home

![](https://github.com/duarte-bruno/photo-grid/blob/master/Prints/home-bottom.PNG)
![](https://github.com/duarte-bruno/photo-grid/blob/master/Prints/home-top.PNG)

### 3. Photo detail and zoom

![](https://github.com/duarte-bruno/photo-grid/blob/master/Prints/photo-detail.PNG)
![](https://github.com/duarte-bruno/photo-grid/blob/master/Prints/photo-detail-zoom.PNG)

### 4. Take photos

![](https://github.com/duarte-bruno/photo-grid/blob/master/Prints/camera.PNG)
![](https://github.com/duarte-bruno/photo-grid/blob/master/Prints/home-after-camera.PNG)

### 5. Delete photo

![](https://github.com/duarte-bruno/photo-grid/blob/master/Prints/delete-alert.PNG)

### 6. Photo library permission handle

![](https://github.com/duarte-bruno/photo-grid/blob/master/Prints/limited-access.PNG)
![](https://github.com/duarte-bruno/photo-grid/blob/master/Prints/no-photos.jpg)
![](https://github.com/duarte-bruno/photo-grid/blob/master/Prints/home-request-access.PNG)
