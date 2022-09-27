import "@rails/request.js"
import { Application } from "@hotwired/stimulus"

const application = Application.start()

import ShowHideController from "../controllers/show_hide_controller"

application.register("show-hide", ShowHideController)
