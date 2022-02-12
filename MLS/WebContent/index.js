// 마커를 담을 배열
var markers = [];
var SearchBounds;
var SearchX;
var SearchY;
var user_num;
var MLlocation = [];

//TODO: 위치를 보내는 방식을 버튼을 클릭하는 순간 리스트에 장소가 들어가 있는 곳만의 위치를 반환한다.
var spotPlaces = [""];

//TODO:개인 장소 마커
var spotmarkerList = [""];

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = {
		center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
		level: 3 // 지도의 확대 레벨
	};

// 지도를 생성
var map = new kakao.maps.Map(mapContainer, mapOption);

// 장소 검색 객체
var ps = new kakao.maps.services.Places();

// 주소-좌표간 변환 서비스 객체
var geocoder = new kakao.maps.services.Geocoder();

// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우
var infowindow = new kakao.maps.InfoWindow({ zIndex: 1 });

// 개별장소 검색창의 갯수
var num = 1;

// 키워드로 장소를 검색
searchPlaces();

// 중간장소 지점의 위치
var midLocPosition;

// 중간 장소 지점의 마커
var Midmarker

// 중간장소 저장, isNull이 true이면 아직 계산하지 않은 상태
var midPlace = {
	y: 0,
	x: 0,
	isNull: true
};

//FIXME: 2개 지점일 때 위치가 이상하게 찍힌다.

function show_ML() {

	var spotPlacesJson = [];
	for (var i = 0; i < spotPlaces.length; i++) {
		if (spotPlaces[i] != "") {
			spotPlacesJson.push({
				lat: spotPlaces[i].getLat(),
				lng: spotPlaces[i].getLng()
			});
			console.log("spot : " + (i + 1) + spotPlaces[i].getLat() + ", " + spotPlaces[i].getLng())
		}
	}

	var user_id = document.getElementById('opener_user_id').value;
	if (user_id == "") {
		user_id = "0";
	}
	console.log("typeof user_id : " + typeof (user_id))

	$.ajax({
		type: "post",
		url: "calcMLServlet",
		data: {
			user_id: user_id,
			locations: JSON.stringify(spotPlacesJson)
		},
		success: function(data) {
			console.log(data);

			midPlace.y = data["lat"];
			midPlace.x = data["lng"];
			midPlace.isNull = false;

			if (Midmarker != null)
				Midmarker.setMap(null);

			midLocPosition = new kakao.maps.LatLng(midPlace.y, midPlace.x);

			// 결과값으로 받은 위치를 마커로 표시합니다
			var imageSrc = './image/yello.png', // 마커이미지의 주소입니다    
				imageSize = new kakao.maps.Size(30, 45),
				imageOption = { offset: new kakao.maps.Point(27, 69) };
			var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);

			Midmarker = new kakao.maps.Marker({
				map: map,
				position: midLocPosition,
				image: markerImage
			});
			console.log("result : " + midLocPosition.getLat() + ", " + midLocPosition.getLng())
			map.setCenter(midLocPosition);
			displayMLlist(midLocPosition);
			SearchX = midLocPosition.getLat();
			SearchY = midLocPosition.getLng();
			ps.categorySearch('FD6', placesSearchCB2, { location: new kakao.maps.LatLng(SearchX, SearchY), bounds: SearchBounds });

			if (user_num != "null") {
				var stemp = displayMLlist(midLocPosition);
				MLlocation.push(stemp);

			}

		},
		error: function(e) {
			alert("에러발생");
		}
	})
}

function displayMLlist(mLocation) {
	var geocoder = new kakao.maps.services.Geocoder();

	var coord = new kakao.maps.LatLng(mLocation.getLat(), mLocation.getLng());
	var callback = function(result, status) {
		if (status === kakao.maps.services.Status.OK) {
			return result[0].address.address_name;
		}
	};
	geocoder.coord2Address(coord.getLng(), coord.getLat(), callback);
}

function loginPopup() {
	window.open("login.html", "a", "width=500,height=350,top=350,left=1000");
}
function listPopup() {
	//window.open("showlist.jsp","a","width=500,height=350,top=350,left=1000");

	var pop_title = "popupOpener";

	window.open("", pop_title, "width=500,height=800,top=350,left=1000");
	var frmData = document.getElementById('showlist');
	frmData.target = pop_title;
	frmData.action = "showlist.jsp";

	frmData.submit();

}


// 마커를 생성하고 지도위에 표시하는 함수
function addMarker(position) {
	// 마커 생성
	var marker = new kakao.maps.Marker({
		position: position
	});
}


function testalert(_name, _user_id, _id) {
	var loginAfter = document.getElementById('loginAfter');
	var loginBefore = document.getElementById('loginBefore');
	var n = document.getElementById('name');
	var u = document.getElementById('opener_user_id');
	var i = document.getElementById('opener_id');
	var showlist = document.getElementById('uid');
	var uname = document.getElementById('uname');
	uname = _name;
	showlist.value = _user_id;
	u.value = _user_id;
	i.value = _id;
	n.textContent = _name;
	loginAfter.style.visibility = 'visible';
	loginBefore.style.visibility = 'hidden';
}


//TODO: 주소 검색이 되지만 주서만으로 하면 안될거 같다 키워드와 주소가 같이 검색할 수 있으면 좋겠다.
// 키워드 검색을 요청하는 함수
function searchPlaces() {
	var keyword = document.getElementById('keyword').value;

	if (!keyword.replace(/^\s+|\s+$/g, '')) {
		alert('키워드를 입력해주세요!');
		return false;
	}

	// 장소검색 객체를 통해 키워드로 장소검색을 요청
	ps.keywordSearch(keyword, placesSearchCB);

	// 장소검색 객체를 통해 주소로 장소검색을 요청
	geocoder.addressSearch(keyword, placesSearchCB);
}

function searchPlaces2() {
	var keyword = document.getElementById('keyword2').value;

	if (!keyword.replace(/^\s+|\s+$/g, '')) {
		alert('키워드를 입력해주세요!');
		return false;
	}

	// 장소검색 객체를 통해 키워드로 장소검색을 요청
	ps.keywordSearch(keyword, placesSearchCB2);
}

// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
// data 결과 목록 status 응답 코드 pagination pagination객체
function placesSearchCB(data, status, pagination) {
	if (status === kakao.maps.services.Status.OK) {

		// 정상적으로 검색이 완료됐으면
		// 검색 목록과 마커를 표출
		displayPlaces(data);

		// 페이지 번호를 표출
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
		// 검색 목록과 마커를 표출
		displayPlaces2(data);

		// 페이지 번호를 표출
		displayPagination(pagination);

	} else if (status === kakao.maps.services.Status.ZERO_RESULT) {
		return;

	} else if (status === kakao.maps.services.Status.ERROR) {

		alert('검색 결과 중 오류가 발생했습니다.');
		return;

	}
}

// 검색 결과 목록과 마커를 표출하는 함수
function displayPlaces(places) {
	var listEl = document.getElementById('placesList'),
		menuEl = document.getElementById('menu_wrap'),
		fragment = document.createDocumentFragment(),
		bounds = new kakao.maps.LatLngBounds(),
		listStr = '';

	// 검색 결과 목록에 추가된 항목들을 제거
	removeAllChildNods(listEl);

	// 지도에 표시되고 있는 마커를 제거
	removeMarker();

	for (var i = 0; i < places.length; i++) {

		// 마커를 생성하고 지도에 표시
		var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
			marker = addMarker(placePosition, i),
			itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성

		// 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
		// LatLngBounds 객체에 좌표를 추가
		bounds.extend(placePosition);

		// 마커와 검색결과 항목에 mouseover 했을때
		// 해당 장소에 인포윈도우에 장소명을 표시
		// mouseout 했을 때는 인포윈도우를 닫
		(function(marker, title) {
			//마커의 마우스 이벤트
			kakao.maps.event.addListener(marker, 'mouseover', function() {
				displayInfowindow(marker, title);
			});

			kakao.maps.event.addListener(marker, 'mouseout', function() {
				infowindow.close();
			});
			//리스트의 마우스 이벤트
			itemEl.onmouseover = function() {
				displayInfowindow(marker, title);
			};

			itemEl.onmouseout = function() {
				infowindow.close();
			};

			// 여기에 마우스 더블클릭 이벤트를 설정
			//TODO: 여기에 spotmarker이 구현되어있음 리스트에 해당 마커를 지우고 새로운 장소의 마커를 표시한다
			itemEl.ondblclick = function() {
				if ($("input:radio[name='spot']").is(':checked')) {
					var imageSrc = './image/red.png', // 마커이미지의 주소  
						imageSize = new kakao.maps.Size(30, 45),
						imageOption = { offset: new kakao.maps.Point(27, 69) };
					var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);

					var Name = $(this).children('.info').children('h5').text();
					$("input[name='spot']:checked").siblings("input[class='search']").val(Name);
					var positionSpot = marker.getPosition();
					var spot_index = $("input[name='spot']:checked").siblings("span[class='spot_num']").attr('id');

					// 해당 개인 장소 칸에 다른 장소가 있으면 해당 장소의 마커를 지운다.
					if (spotmarkerList[parseInt(spot_index) - 1] !== "")
						spotmarkerList[parseInt(spot_index) - 1].setMap(null);

					spotPlaces[parseInt(spot_index) - 1] = positionSpot;

					//TODO: 여기를 고쳐야함
					// 개인 장소를 마커에 표시
					spotmarker = new kakao.maps.Marker({
						map: map,
						position: positionSpot,
						image: markerImage
					});

					// 새로운 장소의 마커객체를 대입
					spotmarkerList[parseInt(spot_index) - 1] = spotmarker;
				}
			};

		})(marker, places[i].place_name);

		fragment.appendChild(itemEl);
	}

	// 검색결과 항목들을 검색결과 목록 Elemnet에 추가
	listEl.appendChild(fragment);
	menuEl.scrollTop = 0;

	// 검색된 장소 위치를 기준으로 지도 범위를 재설정
	map.setBounds(bounds);
}

function displayPlaces2(places) {

	var listEl = document.getElementById('placesList2'),
		menuEl = document.getElementById('menu_wrap2'),
		fragment = document.createDocumentFragment(),
		bounds = new kakao.maps.LatLngBounds(),
		listStr = '';
	// 검색 결과 목록에 추가된 항목들을 제거
	removeAllChildNods(listEl);

	// 지도에 표시되고 있는 마커를 제거
	removeMarker();

	for (var i = 0; i < places.length; i++) {

		// 마커를 생성하고 지도에 표시
		var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
			marker = addMarker(placePosition, i),
			itemEl = getListItem2(i, places[i]); // 검색 결과 항목 Element를 생성

		// 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
		// LatLngBounds 객체에 좌표를 추가
		bounds.extend(placePosition);

		// 마커와 검색결과 항목에 mouseover 했을때
		// 해당 장소에 인포윈도우에 장소명을 표시합니다
		// mouseout 했을 때는 인포윈도우를 닫는다.
		(function(marker, title) {
			kakao.maps.event.addListener(marker, 'mouseover', function() {
				displayInfowindow(marker, title);
			});

			kakao.maps.event.addListener(marker, 'mouseout', function() {
				infowindow.close();
			});

			itemEl.onmouseover = function() {
				displayInfowindow(marker, title);
			};

			itemEl.onmouseout = function() {
				infowindow.close();
			};
		})(marker, places[i].place_name);

		fragment.appendChild(itemEl);
	}

	// 검색결과 항목들을 검색결과 목록 Elemnet에 추가
	listEl.appendChild(fragment);
	menuEl.scrollTop = 0;

	// 검색된 장소 위치를 기준으로 지도 범위를 재설정
	map.setBounds(bounds);

}

// 검색결과 항목을 Element로 반환하는 함수
function getListItem(index, places) {
	var el = document.createElement('li'),
		itemStr = '<span class="markerbg marker_' + (index + 1) + '"></span>' +
			'<div class="info">' +
			'   <h5>' + places.place_name + '</h5>';

	if (places.road_address_name) {
		itemStr += '    <span>' + places.road_address_name + '</span>' +
			'   <span class="jibun gray">' + places.address_name + '</span>';
	} else {
		itemStr += '    <span>' + places.address_name + '</span>';
	}

	itemStr += '  <span class="tel">' + places.phone + '</span>' +
		'</div>';

	el.innerHTML = itemStr;
	el.className = 'item';
	return el;
}

function getListItem2(index, places) {

	var el = document.createElement('li'),
		itemStr = '<span class="markerbg marker_' + (index + 1) + '"></span>' +
			'<div class="info">' +
			'   <h5>' + '<a href="' + places.place_url + '" target="_blank">' + places.place_name + '</a>' + '</h5>';

	itemStr += '    <span>' + places.category_name + '</span>';
	itemStr += '<span>' + places.category_group_name + '</span>';

	itemStr += '  <span class="tel">' + places.phone + '</span>' +
		'</div>';

	el.innerHTML = itemStr;
	el.className = 'item';

	return el;
}

// 마커를 생성하고 지도 위에 마커를 표시하는 함수
function addMarker(position, idx, title) {
	var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
		imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
		imgOptions = {
			spriteSize: new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
			spriteOrigin: new kakao.maps.Point(0, (idx * 46) + 10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
			offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
		},
		markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
		marker = new kakao.maps.Marker({
			position: position, // 마커의 위치
			image: markerImage
		});

	marker.setMap(map); // 지도 위에 마커를 표출
	markers.push(marker);  // 배열에 생성된 마커를 추가

	return marker;
}

// 지도 위에 표시되고 있는 마커를 모두 제거
function removeMarker() {
	for (var i = 0; i < markers.length; i++) {
		markers[i].setMap(null);
	}
	markers = [];
}

// 검색결과 목록 하단에 페이지번호를 표시는 함수
function displayPagination(pagination) {
	var paginationEl = document.getElementById('pagination'),
		fragment = document.createDocumentFragment(),
		i;

	// 기존에 추가된 페이지번호를 삭제
	while (paginationEl.hasChildNodes()) {
		paginationEl.removeChild(paginationEl.lastChild);
	}

	for (i = 1; i <= pagination.last; i++) {
		var el = document.createElement('a');
		el.href = "#";
		el.innerHTML = i;

		if (i === pagination.current) {
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

// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수
// 인포윈도우에 장소명을 표시
function displayInfowindow(marker, title) {
	var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

	infowindow.setContent(content);
	infowindow.open(map, marker);
}

// 검색결과 목록의 자식 Element를 제거하는 함수
function removeAllChildNods(el) {
	while (el.hasChildNodes()) {
		el.removeChild(el.lastChild);
	}
}

// 검색창을 만들고 spotPlaces의 배열 요소를 하나 추가
function create_spotbox() {
	$("#spot_list").append("<li class='spot'><input type='radio' name='spot' class='radio'><span class='spot_num' id = '" + ++num + "'>" + num + "</span> <input type='text' class='search'placeholder='장소 입력'><input type='button' class='delete' value='x'></li>");
	spotPlaces.push("");

	//TODO: 개인장소 마커 리스트를 늘린다.
	spotmarkerList.push("");
}

function uncheck() {
	$("input:radio[name='spot']").prop('checked', false);
	Uncheckedcolor();
}

function Uncheckedcolor() {
	for (var i = 1; i <= num; i++) {
		$("span[id='" + i + "']").parent().css("background-color", "");
	}
}

function spotIDreset() {
	$('li.spot').each(function(index, item) {
		$(this).children('span').attr("id", index + 1);
		$(this).children('span').text(index + 1);
	});
}

$('html').click(function(e) {
	if ($(e.target).hasClass("L_sidebar")) {
		uncheck();
	}
});

$(document).on("click", "li.spot", function() {
	$(this).children('input:radio').prop('checked', true);
	Uncheckedcolor();
	$(this).css("background-color", "gray");
});

$(document).on("click", "input.delete", function() {
	var H = $(this).parent().remove();
	var Del_num = $(this).siblings('span').attr('id');
	spotPlaces.splice(Del_num - 1, 1);
	if (spotmarkerList[Del_num - 1] !== "")
		spotmarkerList[Del_num - 1].setMap(null);
	spotmarkerList.splice(Del_num - 1, 1);
	spotIDreset();
	num--;
});

$(document).ready(function() {
	$("#test1").click(function() {
		ps.categorySearch('FD6', placesSearchCB2, { location: new kakao.maps.LatLng(SearchX, SearchY), bounds: SearchBounds });
	})
	$("#test2").click(function() {
		ps.categorySearch('CE7', placesSearchCB2, { location: new kakao.maps.LatLng(SearchX, SearchY), bounds: SearchBounds });
	})
	$("#test3").click(function() {
		ps.categorySearch('CT1', placesSearchCB2, { location: new kakao.maps.LatLng(SearchX, SearchY), bounds: SearchBounds });
	})
	$("#test4").click(function() {
		ps.categorySearch('AT4', placesSearchCB2, { location: new kakao.maps.LatLng(SearchX, SearchY), bounds: SearchBounds });
	})
});