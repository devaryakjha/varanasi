package config

import (
	"flag"
	"fmt"

	"github.com/spf13/pflag"
	"github.com/spf13/viper"
)

// LoadConfig loads the configuration from the env.yaml file
// and sets the values to the viper instance

func LoadConfig() {
	flag.Bool("debug", false, "Enable debug mode")

	pflag.CommandLine.AddGoFlagSet(flag.CommandLine)
	pflag.Parse()
	viper.BindPFlags(pflag.CommandLine)

    viper.SetConfigFile("env.yaml")

    if err := viper.ReadInConfig(); err != nil {
        panic(fmt.Errorf("fatal error config file: %w", err))
    }

	LoadApiConfig()
}

func Get(key string) any {
	return viper.Get(key)
}

func GetMap(key string, rawVal any) any {
	return viper.UnmarshalKey(key, rawVal)
}

func GetString(key string) string {
	return viper.GetString(key)
}

func GetInt(key string) int {
	return viper.GetInt(key)
}

func GetBool(key string) bool {
	return viper.GetBool(key)
}
