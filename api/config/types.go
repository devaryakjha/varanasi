package config

type ApiConfig struct {
	BaseURL         string   `mapstructure:"base_url"`
	Endpoint        ApiEndpoints `mapstructure:"endpoint"`
}

type ApiEndpoints struct {
	Discover Discover `mapstructure:"discover"`
}

type Discover struct {
	TopArtists string `mapstructure:"top_artists"`
	TopPlaylists string `mapstructure:"top_playlists"`
	NewReleases string `mapstructure:"new_releases"`
}
