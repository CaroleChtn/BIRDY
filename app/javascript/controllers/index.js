// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import ChatroomSubscriptionController from "./chatroom_subscription_controller"
application.register("chatroom-subscription", ChatroomSubscriptionController)

import FavoritesController from "./favorites_controller"
application.register("favorites", FavoritesController)

import FlatpickrController from "./flatpickr_controller"
application.register("flatpickr", FlatpickrController)

import MapController from "./map_controller"
application.register("map", MapController)

import NavbarController from "./navbar_controller"
application.register("navbar", NavbarController)

import ToggleDaysController from "./toggle_days_controller"
application.register("toggle-days", ToggleDaysController)
