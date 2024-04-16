package main

import (
	"flag"
	"fmt"
	"log"
	"os"
	"time"

	"github.com/goccy/go-json"
	"github.com/gofiber/fiber/v2"
	"github.com/gofiber/fiber/v2/middleware/cache"
	"github.com/gofiber/fiber/v2/middleware/logger"
	"github.com/spf13/pflag"
	"github.com/spf13/viper"
)

func initViper()  {
	flag.Bool("debug", false, "Enable debug mode")

	pflag.CommandLine.AddGoFlagSet(flag.CommandLine)
	pflag.Parse()
	viper.BindPFlags(pflag.CommandLine)

    viper.SetConfigFile("config.yaml")

    if err := viper.ReadInConfig(); err != nil {
        panic(fmt.Errorf("fatal error config file: %w", err))
    }
}

func main() {
    initViper()

    // first we must setup new Instance of FIber
	app := fiber.New(fiber.Config{
		// ======== Start of JSON Config ========
		JSONEncoder: json.Marshal,
		JSONDecoder: json.Unmarshal,
		// ======== End of JSON Config ========
	})

    // Add logger middleware
	app.Use(logger.New())

    // add caching middleware
    isDebug := viper.GetBool("debug")
    fmt.Println("debug: ", isDebug)
    if !isDebug {
        app.Use(cache.New(cache.Config{
            Expiration: 24 * time.Hour,
        }))
    }

	app.Get("/", func(c *fiber.Ctx) error {
    	return c.SendString("Hello, World!")
    })

    // create http connection for this api
	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
		log.Printf("Defaulting to port %s", port)
	}

	log.Printf("Listening on port %s", port)
	if err := app.Listen(":" + port); err != nil {
		log.Fatal(err)
	}

}