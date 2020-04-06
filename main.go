package main

import (
	"log"

	"github.com/gin-gonic/gin"
)

func main() {
	r := gin.Default()

	r.GET("/app-b", func(c *gin.Context) {
		c.JSON(200, "sample-app-b")
	})

	log.Fatal(r.Run(":8080"))
}
