package services

import (
	"sync"

	"aryak.dev/varanasi/api/app/repositories"
	"aryak.dev/varanasi/api/models"
	"aryak.dev/varanasi/api/utils"
)


func GetDiscoveryData() (models.DiscoveryModel, error) {
	response := models.DiscoveryModel{}
	blocks := make([]models.Block, 2)
	
	wg := sync.WaitGroup{}

	wg.Add(1)
	go func() {
		data, err := repositories.GetTopArtistsData()
		if err == nil {
			blocks[0] = models.Block{
				Title: "Top Artists",
				Children: transformTopArtistsData(data),
			}
		}
		wg.Done()
	}()

	wg.Add(1)
	go func() {
		data2, err := repositories.GetTopPlaylistData()
		if err == nil {
			blocks[1] = models.Block{
				Title: "Top Playlists",
				Children: transformTopPlaylistData(data2),
			}
		}
		wg.Done()
	}()

	wg.Wait()
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

func transformTopPlaylistData(data *models.TopPlaylistRequest) []models.Media {
	media := make([]models.Media, data.Count)
	for i, playlist := range data.Data {
		media[i] = models.Media{
			ID: playlist.ID,
			Title: playlist.Title,
			SubTitle: playlist.Subtitle,
			Type: models.Playlist,
			Images: utils.CreateImage(playlist.Image),
		}
	}
	return media
}