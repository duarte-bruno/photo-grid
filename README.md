# Photogrid

Photogrid é um aplicativo iOS que permite que seus usuários visualize suas fotos e tire quantas fotos desejar. Ele foi criado com o objetivo de exemplificar o uso da bibioteca [PhotoKit](https://developer.apple.com/documentation/photokit) da Apple.

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

Apenas clone ou baixe o repositório em seu computador, abra o arquivo photo-grid.xcodeproj com o XCode e rode o projeto.

## Funcionalidades
