package handlers

import (
	"aryak.dev/varanasi/api/app/services"
	"github.com/gofiber/fiber/v2"
)

func DiscoverHandler(c *fiber.Ctx) error {
	data, err := services.GetDiscoveryData()
	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
			"error": err.Error(),
		})
	}
	return c.JSON(data)
}