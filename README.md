# Photogrid

Photogrid é um aplicativo iOS que permite que seus usuários visualize suas fotos e tire quantas fotos desejar. Ele foi criado com o objetivo de exemplificar o uso da bibioteca [PhotoKit](https://developer.apple.com/documentation/photokit) da Apple.

## Sumário


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


