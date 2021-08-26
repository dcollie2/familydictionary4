const { environment } = require('@rails/webpacker')
const webpack = require('webpack')
// Adds `var jQuery = require('jquery') to legacy jQuery plugins
environment.plugins.append(
    'Provide',
    new webpack.ProvidePlugin({
        $: 'jquery',
        jQuery: 'jquery',
        jquery: 'jquery',
        Popper: ['popper.js', 'default']
    })
)

// environment.plugins.prepend('Provide',
//     new webpack.ProvidePlugin({
//         $: 'jquery/src/jquery',
//         jQuery: 'jquery/src/jquery',
//         Popper: ['popper.js', 'default']
//     })
// )

module.exports = environment
