package services

import (
	"encoding/json"

	"aryak.dev/varanasi/api/app/repositories"
	"aryak.dev/varanasi/api/models"
	"aryak.dev/varanasi/api/utils"
	"aryak.dev/varanasi/api/utils/extensions"
)

func GetArtistDetailsData(token string) (any, error) {
	data, err := repositories.GetArtistDetailsData(token)
	
	response := transformArtistDetailsData(data)

	return response, err
}

func transformArtistDetailsData(data models.ArtistDetailsRequest) models.ArtistDetailsModel {
	return models.ArtistDetailsModel{
		Name: data.Name,
		ID: data.ArtistID,
		Bio: createBio(data),
		Pages: createPages(data),
	}
}

func createPages(req models.ArtistDetailsRequest) []models.Page {
	var pages []models.Page
	pages = append(pages, createOverviewPage(req))
	pages = append(pages, models.Page{
		Title: "Songs",
		Paginated: true,
		Children: extensions.Map(req.TopSongs, utils.CreateMediaFromSongRequest, 0),
		Sequence: 2,
	})
	pages = append(pages, models.Page{
		Title: "Albums",
		Paginated: true,
		Children: extensions.Map(req.TopAlbums, utils.CreateMediaFromAlbumRequest, 0),
		Sequence: 3,
	})
	return pages
}

func createOverviewPage(data models.ArtistDetailsRequest) models.Page {
	modules := data.Modules
	var moduleValues []models.Module
	var moduleKeys []string
	for key, module := range modules {
		moduleKeys = append(moduleKeys, key)
		moduleValues = append(moduleValues, module)
	}
	modulesLen := len(moduleValues)
	var blocks []models.Block
	for i := 0; i < modulesLen; i++ {
		mod := moduleValues[i]
		var orientation models.Orientation
		if (mod.ScrollType == "Cells_Standard") {
			orientation = models.Vertical
		} else {
			orientation = models.Horizontal
		}
		dataSourceKey := mod.Source
		if (dataSourceKey == "client") {
			dataSourceKey = moduleKeys[i]
		}
		if (dataSourceKey == "topSongs") {
			blocks = append(blocks,models.Block{
				Sequence: 1,
				Title: "Top Songs",
				Orientation: orientation,
				Children: extensions.Map(data.TopSongs, utils.CreateMediaFromSongRequest, 10),
			})
			continue
		}
		if (dataSourceKey == "dedicated_artist_playlist") {
			blocks = append(blocks,models.Block{
				Sequence: 2,
				Title: mod.Title,
				Orientation: orientation,
				Children: createMediaListFromDedicatedArtistPlaylist(data),
			})
			continue
		}
		
	}
	return models.Page{
		Title: "Overview",
		Blocks: blocks,
		Paginated: false,
		Sequence: 0,
	}
}

func createMediaListFromDedicatedArtistPlaylist(data models.ArtistDetailsRequest) []models.Media {
	var playlist = data.DedicatedArtistPlaylist
	result := extensions.Map(playlist, func(item models.DedicatedArtistPlaylistItem) models.Media {
		return models.Media{
			ID: item.ID,
			Title: item.Title,
			SubTitle: item.Subtitle,
			Token: utils.CreateTokenFromPermaURL(item.PermaURL),
			Images: utils.CreateImage(item.Image),
			Type: models.Playlist,
		}
	}, 0)
	return result
}


func createBio(data models.ArtistDetailsRequest) []models.Bio {
	var parsed []models.Bio
	json.Unmarshal([]byte(data.Bio), &parsed);
	bio := make([]models.Bio, 0, len(parsed) + 1)
	bio = append(bio, models.Bio{
		Title: "Born",
		Text: utils.FormatDate(utils.ParseDate(data.Dob)),
		Sequence: 0,
	})
	bio = append(bio,extensions.Filter(parsed, func(b models.Bio) bool {
		return b.Title != "Top 10 Songs"
	})...)
	return bio
}