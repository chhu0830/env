#!/bin/sh
mkdir $1 && cd $1
mkdir src
mkdir src/assets
mkdir src/assets/images
mkdir src/assets/styles
mkdir src/js
mkdir src/js/Components
mkdir src/js/Pages
mkdir src/js/Redux
mkdir src/js/Redux/Actions
mkdir src/js/Redux/Async
mkdir src/js/Redux/Reducers
touch src/index.ejs
touch src/boot.jsx
touch src/assets/styles/main.scss
touch src/js/Pages/Index.jsx
touch src/js/RootRouter.jsx
touch postcss.config.js
touch webpack.config.js
touch webpack.production.config.js
touch .babelrc
touch .eslintrc

# init
npm init

# webpack stuffs
npm install webpack --save-dev 
npm install webpack-dev-server --save-dev
npm install webpack-hot-middleware --save-dev
npm install webpack-notifier --save-dev 
npm install html-webpack-plugin --save-dev 

# install lots of loaders
npm install url-loader file-loader sass-loader css-loader postcss-loader --save
npm install style-loader node-sass --save

# babel stuffs
npm install babel-plugin-react-transform --save-dev
npm install babel-loader babel-core --save-dev
npm install babel-preset-es2015 babel-preset-react --save-dev

# react and redux stuffs
npm install redux redux-thunk react-redux --save
npm install react-tap-event-plugin --save
npm install react react-dom --save
npm install react-transform-hmr --save-dev

# react-router v4
npm install react-router --save
npm install react-router-dom --save


# some other stuffs
npm install autoprefixer --save

url="https://raw.githubusercontent.com/chhu0830/env/master/ReactJS/"
curl $url/.babelrc > .babelrc
curl $url/postcss.config.js > postcss.config.js
curl $url/webpack.config.js > webpack.config.js
curl $url/webpack.production.config.js > webpack.production.config.js
curl $url/src/Router.jsx > src/js/Router.jsx
curl $url/src/boot.jsx > src/boot.jsx
curl $url/src/index.ejs > src/index.ejs
curl $url/src/reducer.jsx > src/js/Redux/Reducers/index.jsx
curl $url/src/Index.jsx > src/js/Pages/Index.jsx

txt='\    "build": "NODE_ENV=production webpack -p --progress --config ./webpack.production.config.js",'
sed -i "/\"scripts\": {/a $txt" ./package.json
txt='\    "dev": "NODE_ENV=development node_modules/.bin/webpack-dev-server --host 0.0.0.0",'
sed -i "/\"scripts\": {/a $txt" ./package.json
