package models

type TopArtistRequest struct {
	Status     string `json:"status"`
	TopArtists []struct {
		Artistid      string `json:"artistid"`
		FollowerCount int    `json:"follower_count"`
		Image         string `json:"image"`
		IsFollowed    bool   `json:"is_followed"`
		Name          string `json:"name"`
		PermaURL      string `json:"perma_url"`
	} `json:"top_artists"`
}