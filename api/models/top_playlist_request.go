package models

type TopPlaylistRequest struct {
	Data []struct {
		ID       string `json:"id"`
		Title    string `json:"title"`
		Subtitle string `json:"subtitle"`
		Type     string `json:"type"`
		Image    string `json:"image"`
		PermaURL string `json:"perma_url"`
		MoreInfo struct {
			SongCount     string `json:"song_count"`
			Firstname     string `json:"firstname"`
			FollowerCount string `json:"follower_count"`
			LastUpdated   string `json:"last_updated"`
			UID           string `json:"uid"`
		} `json:"more_info"`
		ExplicitContent string `json:"explicit_content"`
		MiniObj         bool   `json:"mini_obj"`
	} `json:"data"`
	Count    int  `json:"count"`
	LastPage bool `json:"last_page"`
}