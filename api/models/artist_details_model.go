package models

type Bio struct {
	Sequence int    `json:"sequence"`
	Text     string `json:"text"`
	Title    string `json:"title"`
}

type ArtistDetailsModel struct {
	Name string `json:"name"`
	ID string `json:"id"`
	Pages []Page `json:"pages"`
	Bio []Bio `json:"bio"`
}