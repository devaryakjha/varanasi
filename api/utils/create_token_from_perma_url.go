package utils

import (
	"strings"

	"aryak.dev/varanasi/api/utils/extensions"
)

// https://www.jiosaavn.com/artist/arijit-singh-songs/LlRWpHzy3Hk_
func CreateTokenFromPermaURL(permaURL string) string {
	return extensions.Last(strings.Split(permaURL, "/"))
}