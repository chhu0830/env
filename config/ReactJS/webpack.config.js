var Path = require('path');
var webpack = require('webpack');
// desktop notification when webpack done building
var WebpackNotifierPlugin = require('webpack-notifier');
// actually i don't know why ... 
var HtmlWebpackPlugin = require('html-webpack-plugin');

module.exports = {
    entry: [  
        './src/boot.jsx' // single entry
    ],
    output: {
        path: Path.join(__dirname, 'build'),
        filename: 'bundle.js',
        publicPath: '/'
    },
    module: { // scss, image, jsx ... lots of loaders 
        loaders: [
            {
                test: /\.(jsx|js)$/,
                exclude: /node_modules/,
                loaders: ['babel-loader'],
                include: Path.join(__dirname, 'src/')
            },
            {
                test: /\.css$/, loader: 'style-loader!css-loader'
            },
            {
                test: /\.scss$/, loader: 'style-loader!css-loader!sass-loader!postcss-loader'
            },
            {
                test: /\.json$/, loader: 'json-loader'
            },
            {
                test: /\.(ttf|eot|png|gif|jpg|woff|woff2|svg)(\?v=[0-9]\.[0-9]\.[0-9])?$/,
                loader: 'url-loader?limit=8192'
            },
            {
                test: /\.(html|png)$/,
                loader: 'file-loader?name=[path][name].[ext]&context=./src'
            }
        ]
    },
    resolve: { // resolve both .js and .jsx files
        extensions: ['.js', '.jsx']
    },
    devServer: { 
        inline: true,
        hot: true, // enable hot module replacement
        historyApiFallback: true // when 404, fallback request to index
    },
    plugins: [
        new webpack.DefinePlugin({
          'process.env.NODE_ENV': '"development"'
        }),
        new webpack.NoEmitOnErrorsPlugin(),
        new webpack.HotModuleReplacementPlugin(),
        new WebpackNotifierPlugin(),
        new HtmlWebpackPlugin({
          template: 'src/index.ejs',
          inject: 'body'
        })
    ],
  };
