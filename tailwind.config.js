/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/frontend/stylesheets/*.css',
    './app/frontend/entrypoints/*.js',
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
