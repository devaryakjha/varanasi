package repositories

import (
	"aryak.dev/varanasi/api/config"
	library "aryak.dev/varanasi/api/lib"
	"aryak.dev/varanasi/api/models"
)


func GetArtistDetailsData(token string) (models.ArtistDetailsRequest, error) {
	var requestData models.ArtistDetailsRequest
	additionalParams := map[string]string{
		"p": "0",
		"n_song": "50",
		"n_album": "50",
		"type": "artist",
		"token": token,
	}
	library.GetApiService().Get(func(c config.ApiEndpoints) string {
		return c.Details.Artists
	}, additionalParams, &requestData)
	return requestData, nil
}
