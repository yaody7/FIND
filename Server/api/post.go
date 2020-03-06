package api

import (
	"strconv"
	"FIND/static"
//	"encoding/json"
	"fmt"
	"net/http"
//	"github.com/boltdb/bolt"
	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/mysql"
	"github.com/gin-gonic/gin"
)

func Post(c *gin.Context) {
	var receive static.PostInfo
	c.BindJSON(&receive)
	//get dataBase
	db, err := gorm.Open("mysql", "root:root@tcp(127.0.0.1:3306)/FIND?charset=utf8")
	db.SingularTable(true)
	if err != nil {
		fmt.Println(err)
		c.JSON(http.StatusOK, gin.H{
			"status":  "success",
		})
	//	panic("Open DB error!")
	}
	//get the userinfo
	var user static.UserInfo
	db.Where("username = ?", receive.Username).First(&user)
	if receive.Type == "LOST" {
		l := user.Lost
		n, _ := strconv.Atoi(l)
		n++
		db.Delete(&user)
		l = strconv.Itoa(n)
		user.Lost = l
		db.Create(&user)
	} else {
		l := user.Found
		n, _ := strconv.Atoi(l)
		n++
		db.Delete(&user)
		l = strconv.Itoa(n)
		user.Found = l
		db.Create(&user)
	}
	defer db.Close()
	db.AutoMigrate(&static.PostInfo{})
	db.Create(&receive)
	c.JSON(http.StatusOK, gin.H{
		"status":  "success",
	})
}

func GetPost(c *gin.Context) {
	//get dataBase
	db, err := gorm.Open("mysql", "root:root@tcp(127.0.0.1:3306)/FIND?charset=utf8")
	db.SingularTable(true)
	if err != nil {
		fmt.Println(err)
	//	panic("Open DB error!")
	}
	defer db.Close()
	db.AutoMigrate(&static.PostInfo{})
	var posts []static.PostInfo
	db.Find(&posts)
	c.JSON(http.StatusOK, gin.H{
		"status": "success",
		"items":posts,
	})
}
