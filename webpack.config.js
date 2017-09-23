const path = require('path');
const webpack = require('webpack');
const ExtractTextPlugin = require('extract-text-webpack-plugin');
const autoprefixer = require('autoprefixer');
const cssnano = require('cssnano');

const root = __dirname + '/src/main/webapp/common', jsRoot  = root + '/js', cssRoot = root + '/css';

module.exports = {
  entry: {
    polyfills:[`${jsRoot}/polyfills`],
    style: [
      `${cssRoot}/normalize.css`,
      `${cssRoot}/awesome/font-awesome.scss`,
      __dirname + '/src/main/webapp/calendar/css/fullcalendar.css',
      `${cssRoot}/bootstrap/bootstrap.scss`,
      `${cssRoot}/common.scss`
    ]
  },
  output: {
    path: root + '/dist',
    "filename": "[name].bundle.js",
    "chunkFilename": "[id].chunk.js"
  },
  devServer: {
    contentBase: './',
    compress: true,
    port: 9000,
    hot: true
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        loader: 'babel-loader',
        exclude: /node_modules/,
        query: {
          cacheDirectory: true,
          presets: [['env', {targets:{ie:10}}], 'react'],
          plugins: [["transform-runtime", { "regenerator": true }]]
        }
      },
      {
        "test": /\.(jpg|png|gif|otf|ttf|woff|woff2|cur|ani|eot|svg)$/,
        "loader": "url-loader?limit=10000"
      },
      {
        "include": [
          path.join(cssRoot)
        ],
        test: /\.css$/,
        use: ExtractTextPlugin.extract({
          "use": [
            { loader: 'css-loader', options: { importLoaders: 1 , sourceMap: false} },
            { loader: "postcss-loader", options:{plugins: [autoprefixer, cssnano]}}
          ],
          "fallback": "style-loader",
          "publicPath": ""
        })
      },
      {
          "include": [
              path.join(__dirname + '/src/main/webapp/calendar/css/')
          ],
          test: /\.css$/,
          use: ExtractTextPlugin.extract({
              "use": [
                  { loader: 'css-loader', options: { importLoaders: 1 , sourceMap: false} },
                  { loader: "postcss-loader", options:{plugins: [autoprefixer, cssnano]}}
              ],
              "fallback": "style-loader",
              "publicPath": ""
          })
      },
      {
        "include": [
          path.join(cssRoot)
        ],
        test: /\.scss$/,
        use: ExtractTextPlugin.extract({
          "use": [
            { loader: 'css-loader', options: { importLoaders: 1 , sourceMap: false, url: false} },
            { loader: "postcss-loader", options:{plugins: [autoprefixer, cssnano]}},
            "sass-loader"
          ],
          "fallback": "style-loader",
          "publicPath": ""
        })
      },
      {
        "include": [
          path.join(jsRoot + "/component")
        ],
        test: /\.scss$/,
        "use": [
          'style-loader',
          { loader: 'css-loader', options: { importLoaders: 1 , sourceMap: false} },
          { loader: "postcss-loader", options:{plugins: [autoprefixer, cssnano]}},
          "sass-loader"
        ]
      }
    ]
  },
  resolve: {
    extensions: [".js"]
  },
  plugins:[
    new webpack.optimize.CommonsChunkPlugin({
      name: 'vendor',
      minChunks: 2
    }),// 공통으로 쓰이는 의존 모듈들을 별개의 js파일로 분리해서 번들링 함
    new ExtractTextPlugin({
      "filename": "[name].bundle.css",
      "disable": false
    }),
    new webpack.ProvidePlugin({
      fetch: 'imports-loader?this=>global!exports-loader?global.fetch!whatwg-fetch',
      _: 'imports-loader?this=>global!exports-loader?global._!lodash'
    })
  ]
};
