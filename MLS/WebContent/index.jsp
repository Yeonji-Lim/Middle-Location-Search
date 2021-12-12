<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>키워드로 장소검색하고 목록으로 표출하기</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        html, body {height:100%;}
        .map_wrap, .map_wrap * {margin:0;padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
        .map_wrap a, .map_wrap a:hover, .map_wrap a:active{color:#000;text-decoration: none;}
        .map_wrap {position:relative;width:100%;height:100%;}
        #menu_wrap {position:relative;top:0;bottom:0;width:300px;height:500px;margin-left:75px;overflow-y:auto;background:rgba(255, 255, 255, 0.7);z-index: 1;font-size:12px;border-radius: 10px;overflow-y:scroll;}
        .bg_white {background:#fff;}
        #menu_wrap hr {display: block; height: 1px;border: 0; border-top: 2px solid #5F5F5F;margin:3px 0;}
        #menu_wrap .option{text-align: center;}
        #menu_wrap .option p {margin:10px 0;}  
        #menu_wrap .option button {margin-left:5px;}
        #placesList {text-align: left;}
        #placesList li {list-style: none;}
        #placesList .item {position:relative;border-bottom:1px solid #888;overflow: hidden;cursor: pointer;min-height: 65px;}
        #placesList .item span {display: block;margin-top:4px;}
        #placesList .item h5, #placesList .item .info {text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
        #placesList .item .info{padding:10px 0 10px 55px;}
        #placesList .info .gray {color:#8a8a8a;}
        #placesList .info .jibun {padding-left:26px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;}
        #placesList .info .tel {color:#009900;}
        #placesList .item .markerbg {float:left;position:absolute;width:36px; height:37px;margin:10px 0 0 10px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;}
        #placesList .item .marker_1 {background-position: 0 -10px;}
        #placesList .item .marker_2 {background-position: 0 -56px;}
        #placesList .item .marker_3 {background-position: 0 -102px}
        #placesList .item .marker_4 {background-position: 0 -148px;}
        #placesList .item .marker_5 {background-position: 0 -194px;}
        #placesList .item .marker_6 {background-position: 0 -240px;}
        #placesList .item .marker_7 {background-position: 0 -286px;}
        #placesList .item .marker_8 {background-position: 0 -332px;}
        #placesList .item .marker_9 {background-position: 0 -378px;}
        #placesList .item .marker_10 {background-position: 0 -423px;}
        #placesList .item .marker_11 {background-position: 0 -470px;}
        #placesList .item .marker_12 {background-position: 0 -516px;}
        #placesList .item .marker_13 {background-position: 0 -562px;}
        #placesList .item .marker_14 {background-position: 0 -608px;}
        #placesList .item .marker_15 {background-position: 0 -654px;}

        #menu_wrap2 {position:relative;top:0;bottom:0;width:300px;height:500px;margin-left:75px;overflow-y:auto;background:rgba(255, 255, 255, 0.7);z-index: 1;font-size:12px;border-radius: 10px;overflow-y:scroll;}
        .bg_white {background:#fff;}
        #menu_wrap2 hr {display: block; height: 1px;border: 0; border-top: 2px solid #5F5F5F;margin:3px 0;}
        #menu_wrap2 .option{text-align: center;}
        #menu_wrap2 .option p {margin:10px 0;}  
        #menu_wrap2 .option button {margin-left:5px;}

        *[id="placesList2"] {text-align: left;}
        *[id="placesList2"] li {list-style: none;}
        *[id="placesList2"] .item {position:relative;border-bottom:1px solid #888;overflow: hidden;cursor: pointer;min-height: 65px;}
        *[id="placesList2"] .item span {display: block;margin-top:4px;}
        *[id="placesList2"] .item h5, *[id="placesList2"] .item .info {text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
        *[id="placesList2"] .item .info{padding:10px 0 10px 55px;}
        *[id="placesList2"] .info .gray {color:#8a8a8a;}
        *[id="placesList2"] .info .jibun {padding-left:26px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;}
        *[id="placesList2"] .info .tel {color:#009900;}
        *[id="placesList2"] .item .markerbg {float:left;position:absolute;width:36px; height:37px;margin:10px 0 0 10px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;}
        *[id="placesList2"] .item .marker_1 {background-position: 0 -10px;}
        *[id="placesList2"] .item .marker_2 {background-position: 0 -56px;}
        *[id="placesList2"] .item .marker_3 {background-position: 0 -102px}
        *[id="placesList2"] .item .marker_4 {background-position: 0 -148px;}
        *[id="placesList2"] .item .marker_5 {background-position: 0 -194px;}
        *[id="placesList2"] .item .marker_6 {background-position: 0 -240px;}
        *[id="placesList2"] .item .marker_7 {background-position: 0 -286px;}
        *[id="placesList2"] .item .marker_8 {background-position: 0 -332px;}
        *[id="placesList2"] .item .marker_9 {background-position: 0 -378px;}
        *[id="placesList2"] .item .marker_10 {background-position: 0 -423px;}
        *[id="placesList2"] .item .marker_11 {background-position: 0 -470px;}
        *[id="placesList2"] .item .marker_12 {background-position: 0 -516px;}
        *[id="placesList2"] .item .marker_13 {background-position: 0 -562px;}
        *[id="placesList2"] .item .marker_14 {background-position: 0 -608px;}
        *[id="placesList2"] .item .marker_15 {background-position: 0 -654px;}

        #pagination {margin:10px auto;text-align: center;}
        #pagination a {display:inline-block;margin-right:10px;}
        #pagination .on {font-weight: bold; cursor: default;color:#777;}
        input[id="L_menuicon"] {
            display: none;
        }

        /*left menu icon box position*/
        input[id="L_menuicon"]+label {
            display: block;
            width: 60px;
            height: 100px;
            position: fixed;
            left: 0;
            top: calc(50% - 25px);
            cursor: pointer;
            transition: all.35s;
            border-style: solid;
            border-width: 2px;
            z-index: 2;
            background-color: white;
        }

        /*left icon shape*/
        input[id="L_menuicon"]+label span {
            display: block;
            position: absolute;
            width: 90%;
            height: 5px;
            border-radius: 30px;
            background: #000;
            transition: all.35s;
            z-index: 2;
            left: 5%;
        }

        input[id="L_menuicon"]+label span:nth-child(1) {
            top: 25%;
        }

        input[id="L_menuicon"]+label span:nth-child(2) {
            top: 50%;
            transform: translateY(-50%);
        }

        input[id="L_menuicon"]+label span:nth-child(3) {
            bottom: 25%;
        }


        /*left icon checked*/ 
        input[id="L_menuicon"]:checked+label {
            z-index: 2;
            left: 402px;
        }

        input[id="L_menuicon"]:checked+label span {
            background: #000;
        }

        input[id="L_menuicon"]:checked+label span:nth-child(1) {
            top: 50%;
            transform: translateY(-50%) rotate(45deg);
        }

        input[id="L_menuicon"]:checked+label span:nth-child(2) {
            opacity: 0;
        }

        input[id="L_menuicon"]:checked+label span:nth-child(3) {
            bottom: 50%;
            transform: translateY(50%) rotate(-45deg);
        }


        /*left sidebar shape and position*/

        div[class="L_sidebar"] {
            width: 400px;
            height: 100%;
            background: white;
            position: fixed;
            top: 0;
            left: -400px;
            z-index: 2;
            transition: all .35s;
            border-width: 2px;
            border-color: black;
            border-style: solid;
            overflow-y: scroll;
        }

        div[class="L_sidebar"]{
            text-align: center;
        }

        /*subsearch*/
        div[id="subsearch"]{
            height: 300px;
            overflow-y: scroll;
        }


        /*left sidebar checked*/
        input[id="L_menuicon"]:checked+label+div {
            left: 0;
        }

        input[type="radio"]{
            display: none;
        }

        li[class="item"]{
            background: yellow;
        }

        li[class="spot"]{
            background: blue;
        }

        /*right menuicon*/

        input[id="R_menuicon"] {
            display: none;
        }

        /*right menu icon box position*/
        input[id="R_menuicon"]+label {
            display: block;
            width: 60px;
            height: 100px;
            position: fixed;
            right: 0;
            top: calc(50% - 25px);
            cursor: pointer;
            transition: all.35s;
            border-style: solid;
            border-width: 2px;
            z-index: 2;
            background-color: white;
        }

        /*right icon shape*/
        input[id="R_menuicon"]+label span {
            display: block;
            position: absolute;
            width: 90%;
            height: 5px;
            border-radius: 30px;
            background: #000;
            transition: all.35s;
            z-index: 2;
            left: 5%;
        }
        
        input[id="R_menuicon"]+label span:nth-child(1) {
            top: 25%;
        }
        
        input[id="R_menuicon"]+label span:nth-child(2) {
            top: 50%;
            transform: translateY(-50%);
        }
        
        input[id="R_menuicon"]+label span:nth-child(3) {
            bottom: 25%;
        }
        /*right icon checked*/
        
        input[id="R_menuicon"]:checked+label {
            z-index: 2;
            right: 402px;
        }
        
        input[id="R_menuicon"]:checked+label span {
            background: #000;
        }
        
        input[id="R_menuicon"]:checked+label span:nth-child(1) {
            top: 50%;
            transform: translateY(-50%) rotate(45deg);
        }
        
        input[id="R_menuicon"]:checked+label span:nth-child(2) {
            opacity: 0;
        }
        
        input[id="R_menuicon"]:checked+label span:nth-child(3) {
            bottom: 50%;
            transform: translateY(50%) rotate(-45deg);
        }

        /*right sidebar shape and position*/
        div[class="R_sidebar"] {
            width: 400px;
            height: 100%;
            background: white;
            position: fixed;
            top: 0;
            right: -400px;
            z-index: 2;
            transition: all .35s;
            border-width: 2px;
            border-color: black;
            border-style: solid;
            text-align: center;
        }
        
        /*left sidebar checked*/
        input[id="R_menuicon"]:checked+label+div {
            right: 0;
        }
        div[id="loginAfter"]{
            visibility: hidden;
        }


    </style>
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
                    키워드 : <input type="text" value="서울특별시 중구 필동로 1길 30" id="keyword" size="15"> 
                    <button type="submit">검색하기</button> 
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
                <button type="button" onclick="loginPopup();">버튼</button>
            </div>
            <div id = "loginAfter">
                <h1 id = "name"></h1>
            </div>
            <div>
                <form onsubmit="searchPlaces2(); return false;">
                    키워드 : <input type="text" value="이태원 맛집" id="keyword2" size="15"> 
                    <button type="submit">검색하기</button> 
                </form>
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
    </div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9519a3a3b045964f59f79d575c08a44f&libraries=services"></script>
<script>
// 마커를 담을 배열입니다
var markers = [];
var SearchBounds;
var SearchX;
var SearchY;

//TODO: 위치를 보내는 방식을 버튼을 클릭하는 순간 리스트에 장소가 들어가 있는 곳만의 위치를 반환한다.
var spotPlaces = [""];

// TODO:개인 장소 마커
var spotmarkerList = [""];

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

// 장소 검색 객체를 생성합니다
var ps = new kakao.maps.services.Places();

//주소-좌표간 변환 서비스 객체를 생성합니다.
var geocoder = new kakao.maps.services.Geocoder();

// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
var infowindow = new kakao.maps.InfoWindow({zIndex:1});

//개별장소 검색창의 갯수를 나타낸다.
var num = 1;

// 키워드로 장소를 검색합니다
searchPlaces();

//중간장소 지점의 위치
var midLocPosition;

//중간 장소 지점의 마커
var Midmarker

// 중간장소 저장, isNull이 true이면 아직 계산하지 않은 상태
var midPlace = {
    y : 0,
    x : 0,
    isNull : true
};

//FIXME: 2개 지점일 때 위치가 이상하게 찍힌다.

function show_ML(){

    var spotPlacesJson = [];
    for(var i = 0; i < spotPlaces.length; i++) {
        if(spotPlaces[i] != ""){
            spotPlacesJson.push({ 
                lat : spotPlaces[i].getLat(),
                lng : spotPlaces[i].getLng()
            });
            console.log("spot : " + (i + 1) + spotPlaces[i].getLat() + ", " + spotPlaces[i].getLng())
        }
    }
        
    var user_id = <%=session.getAttribute("id")%>;
    if(user_id == null) {
    	user_id = 0;
    }
    console.log("user_id : "+user_id)

    $.ajax({
        type: "post",
        url : "calcMLServlet",
        data : {
	        	user_id : user_id, 
	        	locations : JSON.stringify(spotPlacesJson)
        	},
        success : function(data){
            console.log(data);

            midPlace.y = data["lat"];
            midPlace.x = data["lng"];
            midPlace.isNull = false;

            if(Midmarker != null)
                Midmarker.setMap(null);

            midLocPosition = new kakao.maps.LatLng(midPlace.y, midPlace.x);

            // 결과값으로 받은 위치를 마커로 표시합니다
            Midmarker = new kakao.maps.Marker({
                map: map,
                position: midLocPosition
            });
            console.log("result : " + midLocPosition.getLat() + ", " + midLocPosition.getLng())
            map.setCenter(midLocPosition);
            displayMLlist(midLocPosition);
            SearchX = midLocPosition.getLat();
            SearchY = midLocPosition.getLng();
            ps.categorySearch( 'FD6', placesSearchCB2,{location: new kakao.maps.LatLng(SearchX,SearchY), bounds:SearchBounds}); 
        },
        error: function(e) {
            alert("에러발생");
        }
    })
}

function displayMLlist(mLocation){
    var geocoder = new kakao.maps.services.Geocoder();

    var coord = new kakao.maps.LatLng(37.56496830314491, 126.93990862062978);
    var callback = function(result, status) {
        if (status === kakao.maps.services.Status.OK) {
            alert(result[0].address.address_name);
            console.log('그런 너를 마주칠까 ' + result[0].address.address_name + '을 못가');
            //geocoder.addressSearch( result[0].address.address_name, placesSearchCB);

        }
    };
    alert(mLocation.getLat());
    geocoder.coord2Address(coord.getLng(), coord.getLat(), callback);

}

function loginPopup(){
    window.open("login.html","a","width=500,height=350,top=350,left=1000");
}

// 마커를 생성하고 지도위에 표시하는 함수입니다
function addMarker(position) {
    // 마커를 생성합니다
    var marker = new kakao.maps.Marker({
        position: position
    });
}

function testalert(name, id){
    var loginAfter = document.getElementById('loginAfter');
    var loginBefore = document.getElementById('loginBefore');
    var n = document.getElementById('name');
    sessionStorage.setItem('name',name);
    sessionStorage.setItem('id',id);
    n.textContent = name;

    loginAfter.style.visibility = 'visible';
    loginBefore.style.visibility = 'hidden';
    alert(sessionStorage.getItem("name"));
    alert('asdf');
}

//TODO: 주소 검색이 되지만 주서만으로 하면 안될거 같다 키워드와 주소가 같이 검색할 수 있으면 좋겠다.
// 키워드 검색을 요청하는 함수입니다
function searchPlaces() {
    var keyword = document.getElementById('keyword').value;

    if (!keyword.replace(/^\s+|\s+$/g, '')) {
        alert('키워드를 입력해주세요!');
        return false;
    }

    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
    ps.keywordSearch( keyword, placesSearchCB);
    
    // 장소검색 객체를 통해 주소로 장소검색을 요청합니다
    geocoder.addressSearch( keyword, placesSearchCB);
}

function searchPlaces2() {
    var keyword = document.getElementById('keyword2').value;

    if (!keyword.replace(/^\s+|\s+$/g, '')) {
        alert('키워드를 입력해주세요!');
        return false;
    }

    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
    ps.keywordSearch( keyword, placesSearchCB2);
}

// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
//data 결과 목록 status 응답 코드 pagination pagination객체
function placesSearchCB(data, status, pagination) {
    if (status === kakao.maps.services.Status.OK) {

        // 정상적으로 검색이 완료됐으면
        // 검색 목록과 마커를 표출합니다
        displayPlaces(data);
        
        // 페이지 번호를 표출합니다
        displayPagination(pagination);

    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
        return;

    } else if (status === kakao.maps.services.Status.ERROR) {

        alert('검색 결과 중 오류가 발생했습니다.');
        return;

    }
}

function placesSearchCB2(data, status, pagination) {
    if (status === kakao.maps.services.Status.OK) {

        // 정상적으로 검색이 완료됐으면
        // 검색 목록과 마커를 표출합니다
        displayPlaces2(data);

        // 페이지 번호를 표출합니다
        displayPagination(pagination);

    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
        return;

    } else if (status === kakao.maps.services.Status.ERROR) {

        alert('검색 결과 중 오류가 발생했습니다.');
        return;

    }
}

// 검색 결과 목록과 마커를 표출하는 함수입니다
function displayPlaces(places) {
    var listEl = document.getElementById('placesList'),
    menuEl = document.getElementById('menu_wrap'),
    fragment = document.createDocumentFragment(), 
    bounds = new kakao.maps.LatLngBounds(), 
    listStr = '';
    
    // 검색 결과 목록에 추가된 항목들을 제거합니다
    removeAllChildNods(listEl);

    // 지도에 표시되고 있는 마커를 제거합니다
    removeMarker();
    
    for ( var i=0; i<places.length; i++ ) {

        // 마커를 생성하고 지도에 표시합니다
        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
            marker = addMarker(placePosition, i), 
            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        bounds.extend(placePosition);

        // 마커와 검색결과 항목에 mouseover 했을때
        // 해당 장소에 인포윈도우에 장소명을 표시합니다
        // mouseout 했을 때는 인포윈도우를 닫습니다
        (function(marker, title) {
            //마커의 마우스 이벤트
            kakao.maps.event.addListener(marker, 'mouseover', function() {
                displayInfowindow(marker, title);
            });

            kakao.maps.event.addListener(marker, 'mouseout', function() {
                infowindow.close();
            });
            //리스트의 마우스 이벤트
            itemEl.onmouseover =  function () {
                displayInfowindow(marker, title);
            };

            itemEl.onmouseout =  function () {
                infowindow.close();
            };

            //여기에 마우스 더블클릭 이벤트를 설정한다.
            //TODO: 여기에 spotmarker이 구현되어있음 리스트에 해당 마커를 지우고 새로운 장소의 마커를 표시한다
            itemEl.ondblclick = function(){
                if($("input:radio[name='spot']").is(':checked')){
                    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png', // 마커이미지의 주소입니다    
                        imageSize = new kakao.maps.Size(64, 69),
                        imageOption = {offset: new kakao.maps.Point(27, 69)};
                    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);

                    var Name = $(this).children('.info').children('h5').text();
                    $("input[name='spot']:checked").siblings("input[class='search']").val(Name);
                    var positionSpot = marker.getPosition();
                    var spot_index = $("input[name='spot']:checked").siblings("span[class='spot_num']").attr('id');

                    //해당 개인 장소 칸에 다른 장소가 있으면 해당 장소의 마커를 지운다.
                    if(spotmarkerList[parseInt(spot_index)-1] !== "")
                        spotmarkerList[parseInt(spot_index)-1].setMap(null);

                    spotPlaces[parseInt(spot_index)-1] = positionSpot;

                    //TODO: 여기를 고쳐야함
                    //개인 장소를 마커에 표시한다.
                    spotmarker = new kakao.maps.Marker({
                        map: map,
                        position: positionSpot,
                        image: markerImage
                    });

                    //새로운 장소의 마커객체를 대입한다.
                    spotmarkerList[parseInt(spot_index)-1] = spotmarker;
                }
            };

        })(marker, places[i].place_name);

        fragment.appendChild(itemEl);
    }

    // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
    listEl.appendChild(fragment);
    menuEl.scrollTop = 0;

    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
    map.setBounds(bounds);
}

function displayPlaces2(places) {

var listEl = document.getElementById('placesList2'), 
menuEl = document.getElementById('menu_wrap2'),
fragment = document.createDocumentFragment(), 
bounds = new kakao.maps.LatLngBounds(), 
listStr = '';
// 검색 결과 목록에 추가된 항목들을 제거합니다
removeAllChildNods(listEl);

// 지도에 표시되고 있는 마커를 제거합니다
removeMarker();

for ( var i=0; i<places.length; i++ ) {

    // 마커를 생성하고 지도에 표시합니다
    var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
        marker = addMarker(placePosition, i), 
        itemEl = getListItem2(i, places[i]); // 검색 결과 항목 Element를 생성합니다

    // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
    // LatLngBounds 객체에 좌표를 추가합니다
    bounds.extend(placePosition);

    // 마커와 검색결과 항목에 mouseover 했을때
    // 해당 장소에 인포윈도우에 장소명을 표시합니다
    // mouseout 했을 때는 인포윈도우를 닫습니다
    (function(marker, title) {
        kakao.maps.event.addListener(marker, 'mouseover', function() {
            displayInfowindow(marker, title);
        });

        kakao.maps.event.addListener(marker, 'mouseout', function() {
            infowindow.close();
        });

        itemEl.onmouseover =  function () {
            displayInfowindow(marker, title);
        };

        itemEl.onmouseout =  function () {
            infowindow.close();
        };
    })(marker, places[i].place_name);

    fragment.appendChild(itemEl);
}

// 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
listEl.appendChild(fragment);
menuEl.scrollTop = 0;

// 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
map.setBounds(bounds);

}



// 검색결과 항목을 Element로 반환하는 함수입니다
function getListItem(index, places) {
    var el = document.createElement('li'),
    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
                '<div class="info">' +
                '   <h5>' + places.place_name + '</h5>';

    if (places.road_address_name) {
        itemStr += '    <span>' + places.road_address_name + '</span>' +
                    '   <span class="jibun gray">' +  places.address_name  + '</span>';
    } else {
        itemStr += '    <span>' +  places.address_name  + '</span>'; 
    }
                 
      itemStr += '  <span class="tel">' + places.phone  + '</span>' +
                '</div>';           

    el.innerHTML = itemStr;
    el.className = 'item';
    return el;
}

function getListItem2(index, places) {

var el = document.createElement('li'),
itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
            '<div class="info">' +
            '   <h5>' + places.place_name + '</h5>';

            itemStr += '    <span>' + places.category_name + '</span>';
            itemStr += '<span>'+places.category_group_name+'</span>';
                     
          itemStr += '  <span class="tel">' + places.phone  + '</span>' +
                    '</div>';     

el.innerHTML = itemStr;
el.className = 'item';

return el;
}

// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
function addMarker(position, idx, title) {
    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
        imgOptions =  {
            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
        },
        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
        marker = new kakao.maps.Marker({
            position: position, // 마커의 위치
            image: markerImage 
        });

    marker.setMap(map); // 지도 위에 마커를 표출합니다
    markers.push(marker);  // 배열에 생성된 마커를 추가합니다

    return marker;
}

// 지도 위에 표시되고 있는 마커를 모두 제거합니다
function removeMarker() {
    for ( var i = 0; i < markers.length; i++ ) {
        markers[i].setMap(null);
    }   
    markers = [];
}

// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
function displayPagination(pagination) {
    var paginationEl = document.getElementById('pagination'),
        fragment = document.createDocumentFragment(),
        i; 

    // 기존에 추가된 페이지번호를 삭제합니다
    while (paginationEl.hasChildNodes()) {
        paginationEl.removeChild (paginationEl.lastChild);
    }

    for (i=1; i<=pagination.last; i++) {
        var el = document.createElement('a');
        el.href = "#";
        el.innerHTML = i;

        if (i===pagination.current) {
            el.className = 'on';
        } else {
            el.onclick = (function(i) {
                return function() {
                    pagination.gotoPage(i);
                }
            })(i);
        }

        fragment.appendChild(el);
    }
    paginationEl.appendChild(fragment);
}

// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
// 인포윈도우에 장소명을 표시합니다
function displayInfowindow(marker, title) {
    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

    infowindow.setContent(content);
    infowindow.open(map, marker);
}

 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
function removeAllChildNods(el) {   
    while (el.hasChildNodes()) {
        el.removeChild (el.lastChild);
    }
}



//검색창을 만들고 spotPlaces의 배열 요소를 하나 추가한다.
function create_spotbox(){
    $("#spot_list").append("<li class='spot'><input type='radio' name='spot' class='radio'><span class='spot_num' id = '" + ++num + "'>" + num + "</span> <input type='text' class='search'placeholder='장소 입력'><input type='button' class='delete' value='x'></li>");
    spotPlaces.push("");

    //TODO: 개인장소 마커 리스트를 늘린다.
    spotmarkerList.push("");
}

function uncheck(){
    $("input:radio[name='spot']").prop('checked', false);
    Uncheckedcolor();
}

function Uncheckedcolor(){
    for(var i = 1; i <= num; i++){
        $("span[id='" + i + "']").parent().css("background-color", "blue");
    }
}

function spotIDreset(){
    $('li.spot').each(function (index, item) {
        $(this).children('span').attr("id", index + 1);
        $(this).children('span').text(index + 1);
    });
}

$('html').click(function(e){
    if($(e.target).hasClass("L_sidebar")){
        uncheck();
    }
});

$(document).on("click", "li.spot", function(){
    $(this).children('input:radio').prop('checked', true);
    Uncheckedcolor();
    $(this).css("background-color", "red");
});

$(document).on("click", "input.delete", function(){
    var H = $(this).parent().remove();
    var Del_num = $(this).siblings('span').attr('id');
    spotPlaces.splice(Del_num-1, 1);
    spotmarkerList.splice(Del_num-1, 1);
    spotIDreset();
    num--;
});

$(document).ready(function() {
    $("#test1").click(function() {
        ps.categorySearch( 'FD6', placesSearchCB2,{location: new kakao.maps.LatLng(SearchX,SearchY), bounds:SearchBounds}); 
})
$("#test2").click(function() {
        ps.categorySearch( 'CE7', placesSearchCB2,{location: new kakao.maps.LatLng(SearchX,SearchY), bounds:SearchBounds}); 
})
$("#test3").click(function() {
        ps.categorySearch( 'CT1', placesSearchCB2,{location: new kakao.maps.LatLng(SearchX,SearchY), bounds:SearchBounds}); 
})
$("#test4").click(function() {
        ps.categorySearch( 'AT4', placesSearchCB2,{location: new kakao.maps.LatLng(SearchX,SearchY), bounds:SearchBounds}); 
})
});




</script>
</body>
</html>