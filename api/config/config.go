package config

import (
	"fmt"
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
	fmt.Println("endpoint: ", config)
}

func GetApiConfig() *ApiConfig {
	return config
}