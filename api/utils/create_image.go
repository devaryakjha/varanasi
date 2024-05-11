package utils

import (
	"regexp"

	"aryak.dev/varanasi/api/models"
)

func CreateImage(rawLink string) []models.Image{
	if rawLink == "" {
		return []models.Image{}
	}
	qualities := []string{"50x50", "150x150", "500x500"}
	links := make([]models.Image, 3)
	for i, quality := range qualities {
		firstLevelReplace := regexp.MustCompile(`\d{1,3}x\d{1,3}`).ReplaceAllString(rawLink, quality)
		secondLevelReplace := regexp.MustCompile(`\d{1,3}x\d{1,3}_\d{1,3}x\d{1,3}`).ReplaceAllString(firstLevelReplace, quality)

		links[i] = models.Image{
			Quality: quality,
			Link:    secondLevelReplace,
		}
	}
	return links
}