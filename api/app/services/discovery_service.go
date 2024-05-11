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
				Orientation: models.Horizontal,
			}
		}
		wg.Done()
	}()

	wg.Add(1)
	go func() {
		data, err := repositories.GetTopPlaylistData()
		if err == nil {
			blocks[1] = models.Block{
				Title: "Top Playlists",
				Orientation: models.Horizontal,
				Children: transformTopPlaylistData(data),
			}
		}
		wg.Done()
	}()

	wg.Add(1)
	go func() {
		data, err := repositories.GetNewReleasesData()
		if err == nil {
			blocks = append(blocks, models.Block{
				Title: "New Releases",
				Orientation: models.Horizontal,
				Children: transformNewReleasesData(data),
			})
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
			Token: utils.CreateTokenFromPermaURL(artist.PermaURL),
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
			Token: utils.CreateTokenFromPermaURL(playlist.PermaURL),
		}
	}
	return media
}

func transformNewReleasesData(data *models.NewReleasesRequest) []models.Media {
	media := make([]models.Media, data.Count)
	for i, release := range data.Data {
		media[i] = models.Media{
			ID: release.ID,
			Title: release.Title,
			SubTitle: release.Subtitle,
			Type: models.Album,
			Images: utils.CreateImage(release.Image),
			Token: utils.CreateTokenFromPermaURL(release.PermaURL),
		}
	}
	return media
}