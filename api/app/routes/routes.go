package routes

import (
	"aryak.dev/varanasi/api/app/handlers"
	"github.com/gofiber/fiber/v2"
)

func SetupRoutes(app fiber.Router) {
	app.Get("/discover", handlers.DiscoverHandler);
}