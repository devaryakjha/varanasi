package models

type SongRequest struct {
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
		MoreInfo struct {
			Music                string `json:"music"`
			AlbumID              string `json:"album_id"`
			Album                string `json:"album"`
			Label                string `json:"label"`
			Origin               string `json:"origin"`
			IsDolbyContent       bool   `json:"is_dolby_content"`
			Three20Kbps          string `json:"320kbps"`
			EncryptedMediaURL    string `json:"encrypted_media_url"`
			EncryptedCacheURL    string `json:"encrypted_cache_url"`
			EncryptedDrmCacheURL string `json:"encrypted_drm_cache_url"`
			EncryptedDrmMediaURL string `json:"encrypted_drm_media_url"`
			AlbumURL             string `json:"album_url"`
			Duration             string `json:"duration"`
			Rights               struct {
				Code               string `json:"code"`
				Cacheable          string `json:"cacheable"`
				DeleteCachedObject string `json:"delete_cached_object"`
				Reason             string `json:"reason"`
			} `json:"rights"`
			CacheState    string `json:"cache_state"`
			HasLyrics     string `json:"has_lyrics"`
			LyricsSnippet string `json:"lyrics_snippet"`
			Starred       string `json:"starred"`
			CopyrightText string `json:"copyright_text"`
			ArtistMap     struct {
				PrimaryArtists []struct {
					ID       string `json:"id"`
					Name     string `json:"name"`
					Role     string `json:"role"`
					Image    string `json:"image"`
					Type     string `json:"type"`
					PermaURL string `json:"perma_url"`
				} `json:"primary_artists"`
				FeaturedArtists []interface{} `json:"featured_artists"`
				Artists         []struct {
					ID       string `json:"id"`
					Name     string `json:"name"`
					Role     string `json:"role"`
					Image    string `json:"image"`
					Type     string `json:"type"`
					PermaURL string `json:"perma_url"`
				} `json:"artists"`
			} `json:"artistMap"`
			ReleaseDate        interface{} `json:"release_date"`
			LabelURL           string      `json:"label_url"`
			Vcode              string      `json:"vcode"`
			Vlink              string      `json:"vlink"`
			TrillerAvailable   bool        `json:"triller_available"`
			RequestJiotuneFlag bool        `json:"request_jiotune_flag"`
			Webp               string      `json:"webp"`
			LyricsID           string      `json:"lyrics_id,omitempty"`
		} `json:"more_info,omitempty"`
		ButtonTooltipInfo []any `json:"button_tooltip_info"`
	}