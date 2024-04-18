package models

type NewReleasesRequest struct {
	Data []struct {
		ID              string `json:"id"`
		Title           string `json:"title"`
		Subtitle        string `json:"subtitle"`
		HeaderDesc      string `json:"header_desc"`
		Type            string `json:"type"`
		PermaURL        string `json:"perma_url"`
		Image           string `json:"image"`
		Language        string `json:"language"`
		Year            string `json:"year"`
		PlayCount       string `json:"play_count"`
		ExplicitContent string `json:"explicit_content"`
		ListCount       string `json:"list_count"`
		ListType        string `json:"list_type"`
		List            string `json:"list"`
		MoreInfo        struct {
			SongCount   string `json:"song_count"`
			ReleaseDate string `json:"release_date"`
			ArtistMap   struct {
				PrimaryArtists  []any `json:"primary_artists"`
				FeaturedArtists []any `json:"featured_artists"`
				Artists         []struct {
					ID       string `json:"id"`
					Name     string `json:"name"`
					Role     string `json:"role"`
					Image    string `json:"image"`
					Type     string `json:"type"`
					PermaURL string `json:"perma_url"`
				} `json:"artists"`
			} `json:"artistMap"`
		} `json:"more_info"`
		ButtonTooltipInfo []any `json:"button_tooltip_info"`
	} `json:"data"`
	Count    int  `json:"count"`
	LastPage bool `json:"last_page"`
}