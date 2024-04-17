package services

import (
	"aryak.dev/varanasi/api/app/repositories"
	"aryak.dev/varanasi/api/models"
	"aryak.dev/varanasi/api/utils"
)


func GetDiscoveryData() (models.DiscoveryModel, error) {
	response := models.DiscoveryModel{}
	var blocks []models.Block
	data, err := repositories.GetTopArtistsData()
	if err == nil {
		blocks = append(blocks, models.Block{
			Title: "Top Artists",
			Children: transformTopArtistsData(data),
		})
	}
	response.Blocks = blocks
	return response, nil
}


func transformTopArtistsData(data *models.TopArtistRequest) []models.Media {
	media := make([]models.Media, len(data.TopArtists))
	for i, artist := range data.TopArtists {
		media[i] = models.Media{
			ID: artist.Artistid,
			Title: artist.Name,
			SubTitle: utils.CreateSubtitleFromFollowerCount(artist.FollowerCount),
			Type: models.Artist,
			Images: utils.CreateImage(artist.Image),
		}
	}
	return media
}