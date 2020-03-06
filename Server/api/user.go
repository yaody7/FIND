package api

import (
	"FIND/static"
//	"encoding/json"
	"fmt"
	"net/http"
//	"github.com/boltdb/bolt"
	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/mysql"
	"github.com/gin-gonic/gin"
)

func Login(c *gin.Context) {
	var receive static.UserInfo
	c.BindJSON(&receive)
	//get dataBase
	db, err := gorm.Open("mysql", "root:root@tcp(127.0.0.1:3306)/FIND?charset=utf8")
	db.SingularTable(true)
	if err != nil {
		fmt.Println(err)
	//	panic("Open DB error!")
	}
	defer db.Close()
	db.AutoMigrate(&static.UserInfo{})

	//get the userinfo
	var user static.UserInfo
	db.Where("username = ?", receive.Username).First(&user)
	//check whether the user exist
	if user==(static.UserInfo{}){
		c.JSON(http.StatusOK, gin.H{
			"status":  "fail",
			"err_msg": "No such user",
		})
	}else{
		//check whether the password is correct
		if user.Password != receive.Password{
			c.JSON(http.StatusOK, gin.H{
				"status":  "fail",
				"err_msg": "Wrong username or password",
			})
		}else{
			c.JSON(http.StatusOK, gin.H{
				"status":  "success",
				"lost": user.Lost,
				"found": user.Found,
				"succeed": user.Succeed,
				"name": user.Username,
				"contact": user.Contact,
				"reward": user.Reward,
				"portrait": user.Portrait,
			})
		}
	}
}

func Register(c *gin.Context) {
	var receive static.UserInfo
	c.BindJSON(&receive)
	//get dataBase
	db, err := gorm.Open("mysql", "root:root@tcp(127.0.0.1:3306)/FIND?charset=utf8")
	db.SingularTable(true)
	if err != nil {
		fmt.Println(err)
	//	panic("Open DB error!")
	}
	defer db.Close()
	db.AutoMigrate(&static.UserInfo{})

	//check whether if duplicate
	var duplicate static.UserInfo
	db.Where(&receive).First(&duplicate)
	db.Where("username = ? OR contact = ?", receive.Username, receive.Contact).First(&duplicate)
	if duplicate==(static.UserInfo{}){
		receive.Lost="0";
		receive.Found="0";
		receive.Reward="0";
		receive.Succeed="0";
		db.Create(&receive)
		c.JSON(http.StatusOK, gin.H{
			"status":  "success",
			"lost": receive.Lost,
			"found": receive.Found,
			"succeed": receive.Succeed,
			"name": receive.Username,
			"contact": receive.Contact,
			"reward": receive.Reward,
		})
	}else{
		c.JSON(http.StatusOK, gin.H{
			"status":  "fail",
			"err_msg": "Your username or contact is duplicate",
		})
	}
}

func SetPortrait(c *gin.Context) {
	var receive static.UserInfo
	c.BindJSON(&receive)

	//get dataBase
	db, err := gorm.Open("mysql", "root:root@tcp(127.0.0.1:3306)/FIND?charset=utf8")
	db.SingularTable(true)
	if err != nil {
		fmt.Println(err)
	//	panic("Open DB error!")
	}
	defer db.Close()
	db.AutoMigrate(&static.UserInfo{})

	//get the userinfo
	var user static.UserInfo
	db.Where("username = ?", receive.Username).First(&user)
	//check whether the user exist
	if user==(static.UserInfo{}){
		c.JSON(http.StatusOK, gin.H{
			"status":  "fail",
			"err_msg": "No such user",
		})
	}else{
		db.Delete(&user)
		user.Portrait = receive.Portrait
		db.Create(&user)
		c.JSON(http.StatusOK, gin.H{
			"status":  "success",
		})
	}
}