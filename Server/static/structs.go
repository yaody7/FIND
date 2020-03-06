package static

import (
//	"github.com/dgrijalva/jwt-go"
//	"github.com/jinzhu/gorm"
)

type UserInfo struct {
	Username string `json:"username" gorm:"primary_key"`
	Password string `json:"password"`
	Contact string `json:"contact"`
	Lost string `json:"lost"`
	Found string `json:"found"`
	Succeed string `json:succeed`
	Reward string `json:reward`
	Portrait string `json:portrait`
}

type PostInfo struct {
	Username string `json:"username`
	Type string `json:"type"`
	Thing string `json:thing`
	Picture string `json:picture`
	Detail string `json:detail`
	Time string `json:time`
	Portrait string `json:portrait`
	Contact string `json:"contact"`
}


