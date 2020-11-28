package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"strings"
)

type certKeyConfig struct {
	Algo string `json:"algo"`
	Size int    `json:"size"`
}
type nameConfig struct {
	C  string `json:"C"`
	ST string `json:"ST"`
	L  string `json:"L"`
	O  string `json:"O"`
	OU string `json:"OU"`
}

type certConfig struct {
	CN    string        `json:"CN"`
	Hosts []string      `json:"hosts"`
	Key   certKeyConfig `json:"key"`
	Names []nameConfig  `json:"names"`
}

func main() {
	if len(os.Args) < 3 {
		log.Fatal("program needs the certs config file and the hosts file")
	}
	configFileName := os.Args[1]
	hostsFileName := os.Args[2]

	configFile, err := ioutil.ReadFile(configFileName)
	if err != nil {
		log.Fatalf("open config file failed: %s, %s", configFileName, err)
	}
	hostsFile, err := ioutil.ReadFile(hostsFileName)
	if err != nil {
		log.Fatalf("open hosts file failed: %s, %s", hostsFileName, err)
	}

	certCfg := &certConfig{}
	err = json.Unmarshal(configFile, certCfg)
	if err != nil {
		log.Fatalf("parse cert config failed: %s, %s", configFileName, err)
	}

	hosts := strings.Split(string(hostsFile), "\n")
	newHosts := []string{}
	for i := range hosts {
		if len(hosts[i]) == 0 {
			continue
		}
		newHosts = append(newHosts, hosts[i])
	}

	if len(newHosts) > 0 {
		certCfg.Hosts = newHosts
	}

	newCertConfig, err := json.Marshal(certCfg)
	fmt.Print(string(newCertConfig))
}
