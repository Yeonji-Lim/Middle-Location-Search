# 📍 Middle-Location-Search

각 사용자의 위치를 통해 중간에 위치한 장소를 검색하는 사이트입니다. 📍🗺

약속 장소를 고르고 싶을 때 서로 출발점을 기준으로 중간에 모이고 싶지만 중간 장소를 고르는 것이 쉽지 않은 경우가 많습니다. 🤔

이럴 때 중간 장소를 빠르고 쉽게 추천해주는 사이트가 있다면 약속 장소를 정하는 데 있어서 피로를 줄일 수 있을 것이라고 생각하여 개발한 서비스입니다. 😎

A site that searches for a place located in the middle through location of each user. 📍🗺

When people want to choose an appointment place, they want to gather in the middle based on the point where they depart from each other, but it is often not easy to choose an intermediate place. 🤔

In this case, we thought that if we had a site that recommended an intermediate place quickly and easily, we could reduce fatigue in determining an appointment place. 😎

## 👀 This is our service

http://52.79.59.95:8080/MLS/

![image](https://user-images.githubusercontent.com/57888020/188383125-e31de038-7c45-46a8-99cf-9f791a53e7a2.png)

위 화면이 서비스 동작화면 입니다. 
왼쪽 사이드바에서 장소 검색 및 입력할 수 있고, 
중간 장소 보기를 입력하면 중간 장소가 노란 표시로 표시되며, 
약속 추천 장소는 오른쪽 사이드바에서 리스트로도 볼 수 있고, 지도에 파란 표시로도 볼 수 있습니다.

The above screen is the service operation screen. 
You can search and enter places in the left sidebar 
When you enter the middle place view, the middle place is marked with a yellow mark 
You can see the recommend places in the list on the right sidebar or in blue on the map.

## 💻 Contents

1. Map

2. Locations

3. Middle Location

4. Location Recommendation

## 🖥 Screen composition

본 프로젝트는 SPA(Single Page Application)으로 구현되었습니다.

화면 전체에 지도가 있고 반응형 사이드바가 양쪽에 있습니다.

사용자는 햄버거 버튼를 통해 사이드바를 표시하거나 숨길 수 있습니다.

모든 기능을 한 사이드바에 제공하는 것이 아니라 사이드바를 양쪽으로 나누어 기능을 구분하여 제공하고 있습니다.

정보 입력 부분과 정보  부분을 구분하여 사용자가 웹 페이지를 이용하는 것이 편리하게끔 하였습니다.

This project has been implemented as a Single Page Application (SPA).

There is a map throughout the screen, and reactive sidebars are on both sides.

The user can show or hide the sidebar through the hamburger button. 

Instead of providing all the functions to one sidebar, we provide the functions separately by dividing the sidebar into two sides.

It is convenient for a user to use a web page by distinguishing between a portion for inputting information and a portion for receiving information.

## 📐 Algorithm to Calculate Middle Location

We use smallest-circle Algorithm

https://en.wikipedia.org/wiki/Smallest-circle_problem


## 🤝 Team Info
| 정채우 [(drei2898)](https://github.com/drei2898) | 임연지 [(Yeonji-Lim)](https://github.com/Yeonji-Lim) | 유성민 [(dolppe)](https://github.com/dolppe) |
| :---: | :---: | :---: | 
|<img src="https://avatars.githubusercontent.com/u/77949323?v=4" width="200px" height="200px" />|<img src ="https://avatars.githubusercontent.com/u/57888020?v=4" width = "200px" height="200px" />|<img src ="https://avatars.githubusercontent.com/u/35285591?v=4" width = "200px" height="200px" />|
|FrontEnd Developer|BackEnd Developer|FrontEnd Developer|
