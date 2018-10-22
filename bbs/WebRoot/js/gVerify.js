//封装一个文本框获得焦点事件的函数
function inputOnfocus(element,elementInfo,message){
    if(element.value === ""){
        elementInfo.className = "text-muted";
        elementInfo.innerHTML = message;
    }
}
//封装一个文本框失去焦点事件的函数
function inputOnblur(element,elementInfo,regExp,message1,message2,message3){
    if(element.value === "") {
        elementInfo.className = "text-danger";
        elementInfo.innerHTML = message1;
        return false;
    }else if(regExp) {
        elementInfo.className = "text-danger";
        elementInfo.innerHTML = message2;
        return false;
    }else{
        elementInfo.className = "text-success";
        elementInfo.innerHTML = message3;
        return true;
    }
}


/*邮箱*/
var email = document.getElementById("email");
var usernameInfo = document.getElementById("usernameInfo");
//中文、字母、英文、数字、并且2-18位
var usernameReg = /^[A-Za-z\d]+([-_.][A-Za-z\d]+)*@([A-Za-z\d]+[-.])+[A-Za-z\d]{2,4}$/;

//用户名获得焦点的时候
email.onfocus = function(){
    inputOnfocus(email,usernameInfo,"");
};
//用户名失去焦点的时候
email.onblur = function(){
    usernameOnblur();
};
function usernameOnblur(){
    var regExp = usernameReg.test(email.value) != true;
    return inputOnblur(email,usernameInfo,regExp," 请输入有效邮箱"," 请输入有效邮箱","");
}

/*/!*用户名*!/
var name = document.getElementById("name");
var nameInfo = document.getElementById("nameInfo");
//中文、字母、英文、数字、并且2-18位
var nameReg = /^[a-zA-Z0-9_-]{4,16}$/;
//用户名获得焦点的时候
name.onfocus = function(){
    inputOnfocus(name,nameInfo,"");
};
//用户名失去焦点的时候
name.onblur = function(){
    nameOnblur();
};
function nameOnblur(){
    var regExp2 = nameReg.test(name.value) != true;
    return inputOnblur(name,nameInfo,regExp2,"请输入有效用户名","请输入有效用户名","");
}*/



/*密码1*/
var password = document.getElementById("password");
var passwordInfo = document.getElementById("passwordInfo");
//字母数字并且6-18
var passwordReg = /^[0-9a-zA-Z]{6,18}$/;
//密码1获得焦点的时候
password.onfocus = function(){
    /*if(password.value === ""){
        passwordInfo.className = "text-muted";
        passwordInfo.innerHTML = "支持字母、数字的6-18个字符";
    }*/
    inputOnfocus(password,passwordInfo,"");
};
//密码1失去焦点的时候
password.onblur = function(){
    /*var regExp = passwordReg.test(password.value) != true;
    inputOnblur(password,passwordInfo,regExp,"请输入密码","格式错误，仅支持字母、数字6-18个字符","对了");
    */
    passwordOnblur();
};
function passwordOnblur(){
    var regExp = passwordReg.test(password.value) != true;
    return inputOnblur(password,passwordInfo,regExp,"请输入有效密码","请输入正确密码","");

}
//密码1释放键盘的时候
password.onkeyup = function(){ //某个键盘按键被松开。
    var i = password.value.length;
    if (i < 6){
        password.style.borderColor = "#a94442";
        return false;
    }else if (i > 18){
        password.style.borderColor = "#a94442";
        return false;
    }else{
        password.style.borderColor = "#3c763d";
        return true;
    }
};



/*密码2*/
var password2 = document.getElementById("password2");
var password2Info = document.getElementById("password2Info");
//密码2获得焦点的时候
password2.onfocus = function(){
    inputOnfocus(password2,password2Info,"");
};
//密码2失去焦点的时候
password2.onblur = function(){
    /*var regExp = password.value != password2.value;
    inputOnblur(password2,password2Info,regExp,"请再次输入密码","密码不一致","密码一致");
    */
    password2Onblur();
};
function password2Onblur(){
    var regExp = password.value != password2.value;
    return inputOnblur(password2,password2Info,regExp,"请再次输入密码","密码不一致","");
};
/*验证码*/
var codes = document.getElementById("code");
var code; //在全局定义验证码
//产生验证码
window.onload = function() {
    createCode();
}

function createCode() {
    code = "";
    var codeLength = 5; //验证码的长度
    var checkCode = document.getElementById("checkCode");
    var random = new Array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R',
        'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'); //随机数
    for(var i = 0; i < codeLength; i++) { //循环操作
        var charIndex = Math.floor(Math.random() * 36); //取得随机数的索引
        code += random[charIndex]; //根据索引取得随机数加到code上
    }
    checkCode.value = code; //把code值赋给验证码
}
codes.onblur = function(){
    codeOnblur();
};
function codeOnblur(){
    var inputCode = document.getElementById("code").value.toUpperCase(); //取得输入的验证码并转化为大写
    if (inputCode.length <= 0 || inputCode != code) {
        codeInfo.className = "text-danger";
        codeInfo.innerHTML = '请输入正确验证码'
        return false;
    } else {
        codeInfo.innerHTML = ''
        return true;
    }
};
function tijiao(){ //提交
    if(usernameOnblur() && passwordOnblur() && password2Onblur()  && codeOnblur()){
        return true;
    }else{
        alert("请确认信息是否完整");
        return false;
    }
}