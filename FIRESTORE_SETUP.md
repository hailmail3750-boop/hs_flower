# Firestore 설정 가이드

## 1. Firestore 컬렉션 생성

Firebase Console에서 `items` 컬렉션을 생성하고 다음과 같은 구조로 문서를 추가하세요.

## 2. 샘플 데이터 (JSON format)

```json
// 꽃 - 빨간장미
{
  "name": "빨간장미",
  "category": "꽃",
  "storagePath": "flowers/red-rose.jpg",
  "colors": ["빨간장미 그림", "노란장미 그림", "주황장미 그림", "분홍장미 그림"]
}

// 꽃 - 해바라기
{
  "name": "해바라기",
  "category": "꽃",
  "storagePath": "flowers/sunflower.jpg",
  "colors": ["노란해바라기 그림", "주황해바라기 그림"]
}

// 필러 - 안개꽃
{
  "name": "안개꽃",
  "category": "필러",
  "storagePath": "fillers/baby-breath.jpg",
  "colors": ["하얀안개꽃 그림", "파란안개꽃 그림", "분홍안개꽃 그림"]
}

// 포장지 - 빨간색
{
  "name": "빨간색",
  "category": "포장지",
  "storagePath": "wrapping-papers/red.jpg",
  "colors": ["빨간색 포장지"]
}

// 리본 - 빨간 리본
{
  "name": "빨간 리본",
  "category": "리본",
  "storagePath": "ribbons/red-ribbon.jpg",
  "colors": ["빨간 리본"]
}

// 문구 - 생일축하
{
  "name": "생일축하",
  "category": "문구",
  "storagePath": "messages/happy-birthday.jpg",
  "colors": ["생일축하"]
}
```

## 3. Firebase Storage 폴더 구조 (이미지 업로드)

```
flowers/
├── red-rose.jpg
├── sunflower.jpg
└── ... (다른 꽃 이미지)

fillers/
├── baby-breath.jpg
├── hydrangea.jpg
└── ...

wrapping-papers/
├── red.jpg
├── green.jpg
└── ...

ribbons/
├── red-ribbon.jpg
├── white-ribbon.jpg
└── ...

messages/
├── happy-birthday.jpg
├── thank-you.jpg
└── ...
```

## 4. 이미지 업로드 방법

- Firebase Console → Storage 탭
- 위 폴더 구조로 폴더 생성
- 각 이미지 파일 업로드
- `storagePath`는 업로드한 경로 정확히 기입

## 5. 보안 규칙 설정

Firebase Console → Firestore → 규칙에서 아래처럼 설정:

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /items/{document=**} {
      allow read;
      allow write: if request.auth != null;
    }
  }
}

service firebase.storage {
  match /b/{bucket}/o {
    match /{allPaths=**} {
      allow read;
      allow write: if request.auth != null;
    }
  }
}
```
