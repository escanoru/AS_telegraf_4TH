package main

import (
	"crypto/tls"
	"fmt"
	"net/http"
	"strings"

	"github.com/gocolly/colly"
)

func topicScrapper() {
	http.DefaultTransport.(*http.Transport).TLSClientConfig = &tls.Config{InsecureSkipVerify: true}
	// ChechArgLen(os.Args)

	// instantiate collector
	c := colly.NewCollector()

	c.OnError(func(_ *colly.Response, err error) {
		fmt.Println("Error:", err.Error())
	})

	// Topics array to hold data in the Metrics field
	metrics := []Topics{}

	// set up rule for table with topics-table id
	c.OnHTML("#topics-table", func(tab *colly.HTMLElement) {
		counter := 1
		tab.ForEach("tr", func(_ int, tr *colly.HTMLElement) {
			td_text := tr.Text
			// tds := tr.ChildText("td")
			// fmt.Println(td_text)
			new_row := Topics{
				Metrics: string(td_text),
			}
			counter++
			// append every row to table
			metrics = append(metrics, new_row)

		})

	})

	// launch collector
	c.Visit(topicsUrl)

	for i := 1; i < len(metrics); i++ {
		items := strings.Split(metrics[i].Metrics, "\n")
		OffsetSpace := strings.TrimSpace(items[12])
		OffsetSplit := strings.ReplaceAll(OffsetSpace, ",", "")
		fmt.Printf("exec_Kafka_Manager_Topic_Metrics,attribute=none,Topic=%v EPS=%v,Offset=%v,Partitions=%v,Brokers_Count=%v,Broker_Skew_%%=%v,Brokers_Leader_Skew_%%=%v,Under_Replicated_%%=%v,Replicas=%v,Brokers_Spread_%%=%v\n", strings.TrimSpace(items[1]), strings.TrimSpace(items[11]), OffsetSplit, strings.TrimSpace(items[2]), strings.TrimSpace(items[3]), strings.TrimSpace(items[5]), strings.TrimSpace(items[6]), strings.TrimSpace(items[8]), strings.TrimSpace(items[7]), strings.TrimSpace(items[4]))
	}

	// To test individual topic metrics
	// items := strings.Split(table[11].Metrics, "\n")
	// fmt.Println(items)
	// fmt.Printf("exec_Kafka_Manager_Topic_Metrics,attribute=none,Topic=%v EPS=%v,Offset=%v,Partitions=%v,Brokers_Count=%v,Broker_Skew_%%=%v,Brokers_Leader_Skew_%%=%v,Under_Replicated_%%=%v,Replicas=%v,Brokers_Spread_%%=%v", strings.TrimSpace(items[1]), strings.TrimSpace(items[11]), strings.TrimSpace(items[12]), strings.TrimSpace(items[2]), strings.TrimSpace(items[3]), strings.TrimSpace(items[5]), strings.TrimSpace(items[6]), strings.TrimSpace(items[8]), strings.TrimSpace(items[7]), strings.TrimSpace(items[4]))

	// Output example:
	// exec_Kafka_Manager_Topic_Metrics,attribute=none,Topic=th-arcsight-avro EPS=0.00,Offset=0,Partitions=24,Brokers_Count=3,Broker_Skew_%=0,Brokers_Leader_Skew_%=0,Under_Replicated_%=0,Replicas=2,Brokers_Spread_%=100

	// Index:
	// # Topics' Name -> $1
	// # Topics'EPS -> $11
	// # Summed Recent Offsets -> $12
	// # Partitions Topic -> $2
	// # Brokers Count -> $3
	// # Broker Skew % -> $5
	// # Brokers Leader Skew % -> $6
	// # Under Replicated % -> $8
	// # Replicas -> $7
	// # Brokers Spread % -> $4
	// -----------------------------------------

}

type Topics struct {
	Metrics string
}
