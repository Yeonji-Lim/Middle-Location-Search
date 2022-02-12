<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Middle Location Search</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="index.css">
</head>
<body>
    <div class="map_wrap">
        <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
    
        <input type="checkbox" id="L_menuicon">
        <label for="L_menuicon">
            <span></span> <span></span> <span></span>
        </label>
        
        <div class="L_sidebar">
            <div id="mainsearch">
                <form onsubmit="searchPlaces(); return false;">
                    <input type="text" value="동대입구역" id="keyword" size="15"> 
                    <button type="submit">검색</button> 
                </form>
            </div>
            <div id="menu_wrap" class="bg_white">
                <div class="option">
                </div>
                <hr>
                <ul id="placesList" class = "placesList"></ul>
            </div>
            <div id="pagination"></div>
            <div id="subsearch">
                <h3>장소 입력하기</h3>
                <div id="spot_section">
                    <ul id="spot_list">
                        <li class="spot">
                            <input type="radio" name="spot">
                            <span class="spot_num" id = "1">1</span> 
                            <input type="text" class="search"placeholder="장소 입력"><input type="button" class="delete" value="x">
                        </li>
                    </ul>
                </div>
            </div>
            <button type="button" onclick="create_spotbox()" id="plus_box">+</button>
            <button type="button" onclick="show_ML()" id="submit">중간장소보기</button>
        </div>
        
        <input type="checkbox" id="R_menuicon">
        <label for="R_menuicon">
            <span></span> <span></span> <span></span>
        </label>
        <div class="R_sidebar">
            <div id ="loginBefore">
                <button type="button" onclick="loginPopup();">로그인</button>
            </div>
            <div id = "loginAfter">
                <h1 id = "name" value =""></h1>
                <form id ="showlist" action = "showlist.jsp" method="post">
                    <input type="hidden" id="uid" name="user_id" value="">
                    <input type="hidden" id="uname" name="name" value="">
                    <input type="button" onclick="listPopup();"value="중간장소 내역보기">
                    
                </form>
                <a href="logout.jsp">로그아웃</a>
            </div>
            <div id="menu_wrap2" class="bg_white">
                <div class="option">
                </div>
                <hr>
                <div>
                    <button id ="test1" type = "button">음식점</button>
                    <button id ="test2" type = "button">카페</button>
                    <button id ="test3" type = "button">문화시설</button>
                    <button id ="test4" type = "button">숙소</button>
                </div>
                <hr>
                <ul id="placesList2" class = "placesList"></ul>
            </div>
            <div id="pagination"></div>
        </div>
        <div>
            <input type="hidden" id="opener_user_id"value="">
            <input type="hidden" id="opener_id"value="">
        </div>
    </div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9519a3a3b045964f59f79d575c08a44f&libraries=services"></script>
<script type="text/javascript" src="./test.js"></script>
</body>
</html>