
# GitEmoji

## Arquitetura: VIPER

## Design Pattern: 

- Mapper: Conversão das entidades
- Adapter: Está fazendo a comunicação com a API do GitHub

## Arquitetura básica da comunicação dos Interactors do projeto:

<img width="952" alt="Screenshot 2022-12-05 at 11 45 54" src="https://user-images.githubusercontent.com/17457196/205893902-bbb1ca30-b8a3-4e64-93c9-319a4d0ed703.png">

## Casos de Uso:

- Criação de 2 casos de uso que são reutilizados no projeto:

  - Avatar:
    - Caso de uso responsável em salvar, ler e remover do disco as informações de um avatar e fazer requisição para receber a informação de um avatar.
    
  - Emoji:
    - Caso de uso responsável em fazer requisição para receber a lista de emojis, ler e salvar em disco os emojis e sortear um emoji.

## Testes Unitários 

  - Realização de Testes Unitários com 100% de cobertura nas classes: 
    - AvatarInteractor:
    
<img width="1003" alt="Screenshot 2022-12-05 at 23 08 05" src="https://user-images.githubusercontent.com/17457196/205894051-2b4c4d22-9261-4a49-a41e-6b086807e785.png">

    - EmojiInteractor:
    
<img width="1002" alt="Screenshot 2022-12-05 at 23 44 21" src="https://user-images.githubusercontent.com/17457196/205894088-7a58b3cb-31d1-4f0e-a1fe-09efac822e03.png">

    
