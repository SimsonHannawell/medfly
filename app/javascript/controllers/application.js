import { Application } from "@hotwired/stimulus"
import BasketController from "./controllers/basket_controller";

const application = Application.start();

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
