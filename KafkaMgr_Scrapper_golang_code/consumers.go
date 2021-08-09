package main

import (
	"crypto/tls"
	"fmt"
	"net/http"
	"strings"

	"github.com/gocolly/colly"
)

func consumerScrapper() {
	http.DefaultTransport.(*http.Transport).TLSClientConfig = &tls.Config{InsecureSkipVerify: true} // Allow non-trusted certificates

	// instantiate the main Colly collector
	c := colly.NewCollector()

	// Clone the main Colly collector to so it can be used on the sub-sequent consumers' pages
	infoCollector := c.Clone()

	// Consumer array to hold data in the consumerMetrics field
	consumerStruct := []Consumers{}

	// map to hold the consumers' name:
	consumerName := make(map[string]string)

	c.OnError(func(_ *colly.Response, err error) {
		fmt.Println("Error:", err.Error())
	})

	// Visit the first link of each consumer's name (which containes the consumer's metrics), the 2nd link is ignored as it redirects to the topic list page.
	c.OnHTML("#consumer-table", func(e *colly.HTMLElement) {
		e.ForEach("tr", func(_ int, tr *colly.HTMLElement) {
			i := 0
			tr.ForEach("a", func(_ int, href *colly.HTMLElement) {
				for i < 1 {
					nextConsumer := href.Request.AbsoluteURL(href.Attr("href"))
					// fmt.Println(href.Text) // For debug porpuses
					consumerName["tempConsumer"] = string(href.Text)
					// fmt.Println("Visiting:", nextConsumer) // For debug porpuses
					infoCollector.Visit(nextConsumer) // Visit each consumer's page to get the metrics
					i++
				}
				consumerStruct = []Consumers{}
			})
		})
	})

	// Get the metrics from the consumer's table
	infoCollector.OnHTML("tbody", func(con *colly.HTMLElement) {
		con.ForEach("tr", func(_ int, tr_con *colly.HTMLElement) {
			td_text := tr_con.ChildText("td")
			// fmt.Println(td_text) // For debug porpuses
			// append every row to the consumerMetrics struct
			new_consumer_row := Consumers{
				consumerMetrics: string(td_text),
			}
			consumerStruct = append(consumerStruct, new_consumer_row)
			// fmt.Println(consumerStruct) // debug

			// iterate over the consumerStruct to get the individual metrics
			for c2 := 0; c2 < len(consumerStruct); c2++ {
				items := strings.Split(consumerStruct[c2].consumerMetrics, "\n")
				fmt.Printf("exec_Kafka_Manager_Consumer_Metrics,attribute=none,Consumer=%v --consuming--from--%v,Type=KF Coverage_%%=%v ,LAG=%v\n", consumerName["tempConsumer"], strings.TrimSpace(items[0]), strings.TrimSpace(items[1]), strings.TrimSpace(items[2]))
				consumerStruct = []Consumers{} // Must clean the struct, otherwise it will duplicate entries
			}

			// ----------------------- To test a particular consumer's metric --------------------
			// items := strings.Split(consumerStruct[0].consumerMetrics, "\n")
			// fmt.Println(items)
			// fmt.Printf("exec_Kafka_Manager_Consumer_Metrics,attribute=none,Consumer=%v --consuming--from--%v,Type= Coverage_%%=%v ,LAG=%v", consumerName["tempConsumer"], strings.TrimSpace(items[0]), strings.TrimSpace(items[1]), strings.TrimSpace(items[2]))
			// Output example:
			// exec_Kafka_Manager_Consumer_Metrics,attribute=none,Consumer=LOG-136.221_th-cef_G5 --consuming--from--th-cef,Type= Coverage_%=100 ,LAG=-2304
			// -----------------------------------------------------------------------------------
		})
	})

	// Launch the main collector
	c.Visit(consumersUrl)
}

// Struct to hold the consumers' metrics
type Consumers struct {
	consumerMetrics string
}
