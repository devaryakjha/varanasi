package config

import (
	"sync"
)

var lock = &sync.Mutex{}

var config *ApiConfig

func LoadApiConfig() {
	if config != nil {
		return 
	}
	lock.Lock()
	defer lock.Unlock()
	GetMap("api_config", &config);
}

func GetApiConfig() *ApiConfig {
	return config
}