# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

pin 'application', preload: true
pin 'name', to: 'https://ga.jspm.io/npm:name@0.0.2/core.js'
pin 'react', to: 'https://ga.jspm.io/npm:react@17.0.2/index.js'
pin 'object-assign', to: 'https://ga.jspm.io/npm:object-assign@4.1.1/index.js'
pin 'scheduler', to: 'https://ga.jspm.io/npm:scheduler@0.20.2/index.js'
pin  'chartkick', to: 'chartkick.js'
pin  'Chart.bundle', to: 'Chart.bundle.js'
pin 'jquery', to: 'https://code.jquery.com/jquery-3.6.0.min.js', preload: true
pin_all_from 'app/javascript/controllers', under: 'controllers', preload: true
