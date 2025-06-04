import { application } from "./application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"

// Load all controllers from the folder automatically
eagerLoadControllersFrom("controllers", application)

// Import and register any manual controllers (if you want manual)
// import ModalController from "./modal_controller"
// application.register("modal", ModalController)

// Register others if you want
import HideHeaderController from "./hide_header_controller"
application.register("hide-header", HideHeaderController)

import BasketController from "./basket_controller";
application.register("basket", BasketController)
