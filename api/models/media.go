package models

type MediaType string

const (
	Artist MediaType = "artist"
	Playlist MediaType = "playlist"
	Album MediaType = "album"
	Song MediaType = "song"
)

type Media struct {
	ID    string `json:"id"`
	Title string `json:"title"`
	SubTitle string `json:"sub_title"`
	Token string `json:"token"`
	Type  MediaType `json:"type"`
	Images []Image `json:"images"`
	DownloadLinks []DownloadLink `json:"download_links,omitempty"`
}