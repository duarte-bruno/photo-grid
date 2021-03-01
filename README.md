# Photogrid

Photogrid é um aplicativo iOS que permite que seus usuários visualize suas fotos e tire quantas fotos desejar. Ele foi criado com o objetivo de exemplificar o uso da bibioteca [PhotoKit](https://developer.apple.com/documentation/photokit) da Apple.

## Sumário
<!--ts-->
  * [Autor](#autor)
  * [Arquitetura](#arquitetura)
  * [Como rodar o aplicativo](#como-rodar-o-aplicativo)
  * [Funcionalidades](#funcionalidades)
    * [1. Launch Screen](#1-launch-screen) 
    * [2. Home](#2-home)
    * [3. Photo detail and zoom](#3-photo-detail-and-zoom)
    * [4. Take photos](#4-take-photos)
    * [5. Delete photo](#5-delete-photo)
    * [6. Photo library permission handle](#6-photo-library-permission-handle)
 <!--te-->

## Autor

#### Bruno Duarte Pereira Santos
[LinkedIn](https://www.linkedin.com/in/brunopereiras/) - [Github](https://github.com/duarte-bruno)

I've been working on the iOS platform for 6+ years now using Swift and Objective-C, but I also have 7+ years developing web applications and APIs using Ruby on Rails, Angular, and NodeJs. I have worked on applications of every size, from startups to international brands. I also have a lot of experience working with layouts and components since I started my professional career as a designer. 

## Arquitetura

A aplicação foi desenvolvida usando a [Arquitetura MVVM](https://www.raywenderlich.com/34-design-patterns-by-tutorials-mvvm), para ter uma clara separação de responsabilidades e tornar o aplicativo mais fácil para realizar futuras manutenções.

Ao abrir o código da aplicação você encontrará a estrutra de pastas abaixo:

```
- App -> Arquivos de configuração do projeto
- Services -> Classes responsáveis bibliotecas e serviços externos
- Controllers -> Controladoras das telas da aplicação (Views do MVVM)
- ViewModels -> Classes com as regras de negócio de cada tela (View models do MVVM)
- Views -> Componentes customizados para a aplicação

(Atualmente o app não possui Models customizadas da aplicação, por isso a pasta Models do MVVM não existe nesta aplicação)
```

## Como rodar o aplicativo

1. Antes de começar você vai precisar ter instalado em sua máquina as seguintes ferramentas:
- [Git](https://github.com/git-guides/install-git)
- [Xcode](https://developer.apple.com/xcode/)

2. Após ter instalado as ferramentas clone ou baixe [este repositório](https://github.com/duarte-bruno/photo-grid) em seu computador.

3. abra o arquivo photo-grid.xcodeproj com o XCode e clique em rodar.

## Funcionalidades

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
