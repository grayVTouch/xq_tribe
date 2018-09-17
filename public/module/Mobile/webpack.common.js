const path = require('path');
// 使用了 clean-webpack-plugin & html-webpack-plugin 插件后
// 结合 webpack-dev-server 进行开发时，编译后文件会常驻内存
// 且 ./dist 目录会被删除！！
// 也就是说会发生 dist 目录消失的现象。
const CleanWebpackPlugin = require('clean-webpack-plugin');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const VueLoaderPlugin = require('vue-loader/lib/plugin');
const MiniCssExtractPlugin = require("mini-css-extract-plugin");

module.exports = {
    entry: {
        app: ['babel-polyfill' , './source/app.js']
    },
    plugins: [
        new CleanWebpackPlugin(['compiled']),
        new HtmlWebpackPlugin({
            title: 'bcy' ,
            filename: 'app.html' ,
            template: 'template.html'
        }) ,
        new VueLoaderPlugin() ,
        new MiniCssExtractPlugin({
            filename: "[name].css",
            // chunkFilename: "[id].css"
        })
    ],
    output: {
        filename: '[name].js',
        path: path.resolve(__dirname, 'compiled') ,
        publicPath: '' ,
    } ,
    module: {
        rules: [
            {
                test: /\.js$/,
                exclude: /(node_modules|bower_components)/,
                use: {
                    loader: 'babel-loader',
                    options: {
                        presets: ['babel-preset-env']
                    }
                }
            } ,
            {
                // test: /\.s?[ac]ss$/,
                test: /\.css$/ ,
                use: [
                    MiniCssExtractPlugin.loader ,
                    // 'vue-style-loader' ,
                    // 'style-loader' ,
                    {
                        loader: 'css-loader' ,
                        options: {
                            sourceMap: true
                        }
                    }
                ],
            } ,
            {
                test: /\.(png|svg|jpg|gif)$/,
                use: [
                    {
                        loader: 'file-loader' ,
                        options: {
                            name: 'image/[name].[ext]'
                        }
                    }
                ]
            } ,
            {
                test: /\.(woff|woff2|eot|ttf|otf)$/,
                use: [
                    {
                        loader: 'file-loader' ,
                        options: {
                            name: '[name].[ext]'
                        }
                    }
                ]
            } ,
            {
                test: /\.(csv|tsv)$/,
                use: [
                    'csv-loader'
                ]
            } ,
            {
                test: /\.xml$/ ,
                use: [
                    'xml-loader'
                ]
            } ,
            {
                test: /\.vue$/ ,
                loader: 'vue-loader'
            }
        ]
    } ,
    // 相关依赖
    // 简化导入
    resolve: {
        alias: {
            'vue': 'vue/dist/vue.esm.js' ,
            'vue-router': 'vue-router/dist/vue-router.esm.js' ,
            'vuex': 'vuex/dist/vuex.esm.js' ,
            'animate.css': 'animate.css/animate.min.css' ,
            'iview.css': 'iview/dist/styles/iview.css' ,
            'iview.js': 'iview/dist/iview.min.js' ,

            // 自定义路径简便名称
            'assets': path.resolve(__dirname , './source/assets') ,
            'api': path.resolve(__dirname , './source/api') ,
            'config': path.resolve(__dirname , './source/config') ,
            'mapping': path.resolve(__dirname , './source/mapping') ,
            '_vue_': path.resolve(__dirname , './source/vue')
        }
    }
};