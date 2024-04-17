package repositories

import (
	"aryak.dev/varanasi/api/config"
	library "aryak.dev/varanasi/api/lib"
	"aryak.dev/varanasi/api/models"
)

func GetTopArtistsData() (*models.TopArtistRequest, error) {
	var requestData models.TopArtistRequest
	library.GetApiService().Get(func(c config.ApiEndpoints) string {
		return c.Discover.TopArtists
	}, nil, &requestData)
	return &requestData, nil
}