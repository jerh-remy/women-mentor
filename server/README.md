INSTRUCTIONS

> prerequisite - Install the firebase cli globally/within the project and then login with firebase

```sh
cd functions

npm install -g firebase-tools

firebase login

npm install

npm run serve
```

Functions will be available at http://localhost:5001/un-sdg-gender-equality/europe-west2/{endpoint}

To deploy  
```sh
cd functions  
npm run deploy
```
