package library

import (
	"net/url"

	"aryak.dev/varanasi/api/config"
	"github.com/goccy/go-json"
	"github.com/gofiber/fiber/v2"
)


type apiService struct {
	Config config.ApiConfig
	Client fiber.Client
}

var instance *apiService

func createApiService() *apiService {
	instance = &apiService{
		Config: *config.GetApiConfig(),
		Client: fiber.Client{
			// ======== Start of JSON Config ========
			JSONEncoder: json.Marshal,
			JSONDecoder: json.Unmarshal,
			// ======== End of JSON Config ========
		},
	}
	return instance
}

func GetApiService() *apiService {
	if instance == nil {
		return createApiService()
	}
	return instance
}

func (s *apiService) getBaseURL() string {
	return s.Config.BaseURL
}

func (s *apiService) getEndpoints() config.ApiEndpoints {
	return s.Config.Endpoint
}

func (s *apiService) Get(
	pathResolver func(c config.ApiEndpoints) string,
	query map[string]string,
	v any,
) (any, error) {
	fulluri, _ := url.Parse(s.getBaseURL())

	q := fulluri.Query()
	q.Add("_format", "json")
	q.Add("_marker", "0")
	q.Add("ctx", "web6dot0")
	q.Add("__call", pathResolver(s.getEndpoints()))
	q.Add("api_version", "4")

	for k, v := range query {
		q.Add(k, v)
	}
	var lang string
	if !q.Has("language") || q.Get("language") == "" {
		lang = "english"
		q.Add("language", "english")
	} else {
		lang = url.QueryEscape(q.Get("language"))
	}

	fulluri.RawQuery = q.Encode()

	url := fulluri.String()

	agent := s.Client.Get(url)

	// ======== Start of Headers Config ========
	agent.ContentType("application/json")
	agent.Cookie("DL", lang)
	agent.Cookie("L", lang)
	// ======== End of Headers Config ========

	_, response, _ := agent.Bytes()

	error := s.Client.JSONDecoder(response, v)
	return v, error
}
