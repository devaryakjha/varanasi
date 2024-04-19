package utils

import (
	"aryak.dev/varanasi/api/models"
)

func CreateMediaFromSongRequest(req models.SongRequest) models.Media {
	return models.Media{
		ID: req.ID,
		Title: req.Title,
		SubTitle: req.Subtitle,
		Token: CreateTokenFromPermaURL(req.PermaURL),
		Type: models.Song,
		Images: CreateImage(req.Image),
	}
}

func CreateMediaFromAlbumRequest(req models.AlbumRequest) models.Media {
	return models.Media{
		ID: req.ID,
		Title: req.Title,
		SubTitle: req.Subtitle,
		Token: CreateTokenFromPermaURL(req.PermaURL),
		Type: models.Album,
		Images: CreateImage(req.Image),
	}
}
