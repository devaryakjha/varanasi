package routes

import (
	"aryak.dev/varanasi/api/app/handlers"
	"github.com/gofiber/fiber/v2"
	"github.com/gofiber/fiber/v2/middleware/etag"
)

func SetupRoutes(app fiber.Router) {
	discoverRouter := app.Group("/discover")
	discoverRouter.Use(etag.New())
	discoverRouter.Get("", handlers.DiscoverHandler)
	SetupMediaDetailsRoutes(app)
}
