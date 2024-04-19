package handlers

import (
	"aryak.dev/varanasi/api/app/services"
	"github.com/gofiber/fiber/v2"
)

func ArtistDetailsHandler(c *fiber.Ctx) error {
	token := c.Params("token")
	data, err := services.GetArtistDetailsData(token)
	if err != nil {
		return c.Status(500).JSON(err)
	}
	return c.JSON(data)
}