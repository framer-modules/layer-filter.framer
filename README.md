# Layer filter
레이어 필터의 속성값을 슬라이드로 변경하여 실시간 상태 변화 확인

<br/>

데모 : https://framer-modules.github.io/layer-filter.framer/   
> 슬라이드를 이용하여 속성값을 변경하여 실시간 확인   

<br/>

## 미리보기

<br/>

## 기능
- Brightness
- Saturate
- HueRotate
- Contrast
- Invert
- Grayscale
- Sepia

<br/>

## 설치
별도의 설치는 필요하지 않음

<br/>

## 사용
[데모](https://framer-modules.github.io/layer-filter.framer/)에서 나온 수치를 프로토타입 개발 시 레이어 속성으로 설정  
`또는 소스 다운로드 후 미리보기 이미지를 변경 후 적용해 볼 수 있습니다.`  
> 레이어 속성에 대한 기본 설정은 [FramerJS Docs - Layer](https://framer.com/docs/#layer.layer) 를 참고하세요.  

<br/>

## APIs
### 레이어 속성
#### [Layer.brightness](https://framer.com/docs/#layer.brightness)
[Number] 밝기  
- 범위 : 0 ~ 1000
- 기본값 : 100  

#### [Layer.saturate](https://framer.com/docs/#layer.saturate)
[Number] 채도  
- 범위 : 0 ~ 100
- 기본값 : 100  

#### [Layer.hueRotate](https://framer.com/docs/#layer.hueRotate)
[Number] 색조회전  
- 범위 : 0 ~ 360
- 기본값 : 0  

#### [Layer.contrast](https://framer.com/docs/#layer.contrast)
[Number] 대비  
- 범위 : 0 ~ 100
- 기본값 : 100  

#### [Layer.invert](https://framer.com/docs/#layer.invert)
[Number] 반전
- 범위 : 0 ~ 100
- 기본값 : 0

#### [Layer.grayscale](https://framer.com/docs/#layer.grayscale)
[Number] 회색조
- 범위 : 0 ~ 100
- 기본값 : 0  

#### [Layer.sepia](https://framer.com/docs/#layer.sepia)
[Number] 갈색조
- 범위 : 0 ~ 100
- 기본값 : 0  

## 예제코드
```coffeescript
image = new Layer
    point: Align.center
    size: 192
    image: "framer/images/icon-192.png"
    brightness: 100
    saturate: 100
    hueRotate: 0
    contrast: 100
    invert: 0
    grayscale: 0
    sepia: 0
```
