import { Application } from "@hotwired/stimulus"
import BasketController from "./controllers/basket_controller";

const application = Application.start();
<<<<<<< HEAD
application.register("basket", BasketController);
=======
>>>>>>> 0a8bf63839e9fd9aba9c42ca38c8a593f039522f
// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
