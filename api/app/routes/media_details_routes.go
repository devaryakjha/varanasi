package routes

import (
	"aryak.dev/varanasi/api/app/handlers"
	"github.com/gofiber/fiber/v2"
)

func SetupMediaDetailsRoutes(app fiber.Router) {
	mediaDetailsRouter := app.Group("/media-details")
	mediaDetailsRouter.Get("/artists/:token", handlers.ArtistDetailsHandler)
}