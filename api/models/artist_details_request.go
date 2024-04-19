package models

type Module struct {
	Source                  string `json:"source"`
	Position                int    `json:"position"`
	Score                   string `json:"score"`
	Bucket                  string `json:"bucket"`
	ScrollType              string `json:"scroll_type"`
	Title                   string `json:"title"`
	Subtitle                string `json:"subtitle"`
	Highlight               string `json:"highlight"`
	SimpleHeader            bool   `json:"simpleHeader"`
	NoHeader                bool   `json:"noHeader"`
	ShowMore                struct {
		Type   string `json:"type"`
		Source string `json:"source"`
	} `json:"showMore,omitempty"`
	ViewMore     []interface{} `json:"view_more,omitempty"`
	IsJTModule   bool          `json:"is_JT_module"`
}

type DedicatedArtistPlaylistItem struct {
		ID       string `json:"id"`
		Title    string `json:"title"`
		Subtitle string `json:"subtitle"`
		Type     string `json:"type"`
		Image    string `json:"image"`
		PermaURL string `json:"perma_url"`
		MoreInfo struct {
			UID            string `json:"uid"`
			Firstname      string `json:"firstname"`
			ArtistName     any    `json:"artist_name"`
			EntityType     string `json:"entity_type"`
			EntitySubType  string `json:"entity_sub_type"`
			VideoAvailable bool   `json:"video_available"`
			IsDolbyContent any    `json:"is_dolby_content"`
			SubTypes       any    `json:"sub_types"`
			Images         any    `json:"images"`
			Lastname       string `json:"lastname"`
			SongCount      string `json:"song_count"`
			Language       string `json:"language"`
		} `json:"more_info"`
		ExplicitContent string `json:"explicit_content"`
		MiniObj         bool   `json:"mini_obj"`
		Numsongs        any    `json:"numsongs"`
	}

type ArtistDetailsRequest struct {
	ArtistID         string `json:"artistId"`
	Name             string `json:"name"`
	Subtitle         string `json:"subtitle"`
	Image            string `json:"image"`
	FollowerCount    string `json:"follower_count"`
	Type             string `json:"type"`
	IsVerified       bool   `json:"isVerified"`
	DominantLanguage string `json:"dominantLanguage"`
	DominantType     string `json:"dominantType"`
	TopSongs         []SongRequest `json:"topSongs"`
	TopAlbums []struct {
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
			Query     string `json:"query"`
			Text      string `json:"text"`
			Music     string `json:"music"`
			SongCount string `json:"song_count"`
			ArtistMap struct {
				PrimaryArtists []struct {
					ID       string `json:"id"`
					Name     string `json:"name"`
					Role     string `json:"role"`
					Image    string `json:"image"`
					Type     string `json:"type"`
					PermaURL string `json:"perma_url"`
				} `json:"primary_artists"`
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
	} `json:"topAlbums"`
	DedicatedArtistPlaylist []DedicatedArtistPlaylistItem `json:"dedicated_artist_playlist"`
	FeaturedArtistPlaylist []struct {
		ID       string `json:"id"`
		Title    string `json:"title"`
		Subtitle string `json:"subtitle"`
		Type     string `json:"type"`
		Image    string `json:"image"`
		PermaURL string `json:"perma_url"`
		MoreInfo struct {
			UID            string `json:"uid"`
			Firstname      string `json:"firstname"`
			ArtistName     any    `json:"artist_name"`
			EntityType     string `json:"entity_type"`
			EntitySubType  string `json:"entity_sub_type"`
			VideoAvailable bool   `json:"video_available"`
			IsDolbyContent any    `json:"is_dolby_content"`
			SubTypes       any    `json:"sub_types"`
			Images         any    `json:"images"`
			Lastname       string `json:"lastname"`
			SongCount      string `json:"song_count"`
			Language       string `json:"language"`
		} `json:"more_info"`
		ExplicitContent string `json:"explicit_content"`
		MiniObj         bool   `json:"mini_obj"`
		Numsongs        any    `json:"numsongs"`
	} `json:"featured_artist_playlist"`
	Singles []struct {
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
			Query     string `json:"query"`
			Text      string `json:"text"`
			Music     string `json:"music"`
			SongCount string `json:"song_count"`
			ArtistMap struct {
				PrimaryArtists []struct {
					ID       string `json:"id"`
					Name     string `json:"name"`
					Role     string `json:"role"`
					Image    string `json:"image"`
					Type     string `json:"type"`
					PermaURL string `json:"perma_url"`
				} `json:"primary_artists"`
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
	} `json:"singles"`
	LatestRelease []struct {
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
			Query     string `json:"query"`
			Text      string `json:"text"`
			Music     any    `json:"music"`
			SongCount string `json:"song_count"`
			ArtistMap struct {
				PrimaryArtists []struct {
					ID       string `json:"id"`
					Name     string `json:"name"`
					Role     string `json:"role"`
					Image    string `json:"image"`
					Type     string `json:"type"`
					PermaURL string `json:"perma_url"`
				} `json:"primary_artists"`
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
		ButtonTooltipInfo []any  `json:"button_tooltip_info"`
		Description       string `json:"description"`
	} `json:"latest_release"`
	SimilarArtists []any  `json:"similarArtists"`
	IsRadioPresent bool   `json:"isRadioPresent"`
	Bio            string `json:"bio"`
	Dob            string `json:"dob"`
	Fb             string `json:"fb"`
	Twitter        string `json:"twitter"`
	Wiki           string `json:"wiki"`
	Urls           struct {
		Albums   string `json:"albums"`
		Bio      string `json:"bio"`
		Comments string `json:"comments"`
		Songs    string `json:"songs"`
		Overview string `json:"overview"`
	} `json:"urls"`
	AvailableLanguages []string `json:"availableLanguages"`
	FanCount           string   `json:"fan_count"`
	TopEpisodes        []any    `json:"topEpisodes"`
	Modules map[string]Module `json:"modules"`
	IsFollowed bool `json:"is_followed"`
}