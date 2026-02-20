# AnalySeals

This project is a **2024 graduation project**.  
AnalySeals is an iOS app focused on college exploration, school-fit analysis, and student note sharing.

## Overview

AnalySeals combines:

- College information exploration (school links, rankings, historical scores)
- School-fit analysis (application recommendation by score)
- MBTI-based personality analysis and department suggestions
- Community notes (post, image upload, collect, like/dislike, ranking)
- Personalized settings and daily notifications
- Task planning with CoreData/SwiftData

## Main Modules

- `Home`: browse and search notes
- `Prefer`: school recommendations and score charts
- `Post`: publish text/image notes to Firebase
- `Point`: score input + crawler API for school-fit results
- `Test`: 60-question MBTI flow and result report
- `Sidebar`: notifications, school links, school ranking, official notes, note ranking, wish/lottery features

## Tech Stack

- iOS App: `SwiftUI`, `SwiftData`, `CoreData`, `UserNotifications`
- Cloud: `Firebase Authentication`, `Realtime Database`, `Firestore`, `Firebase Storage`
- Crawlers/API: `Python`, `Flask`, `Selenium`, `BeautifulSoup`
- iOS packages: Firebase iOS SDK, ChartView, SwiftUI Introspect

## Project Structure

```text
.
├── README.md
└── AnalySeals
    ├── Topic10914              # iOS app (Xcode project)
    ├── WindowsSpider           # Web crawlers for Windows
    ├── MacSpider               # Web crawlers for macOS
    └── Documentation           # SRS / SDD / SUM / project docs
```

## Requirements

- macOS + Xcode (iOS Deployment Target: `17.0`)
- Python `3.9+`
- Google Chrome
- ChromeDriver (must match your local Chrome version)
- Firebase config (`GoogleService-Info.plist`)

## Quick Start

### 1. Run the iOS app

1. Open `AnalySeals/Topic10914/Topic10914.xcodeproj`
2. Confirm `AnalySeals/Topic10914/GoogleService-Info.plist` exists
3. Resolve Swift packages in Xcode.
4. Run on iOS 17+ simulator/device.

### 2. Run crawler services

The app calls local/LAN crawler APIs for school-fit analysis and MBTI features:

- `5000`: school-fit crawler (type T)
- `8000`: school-fit crawler (type D)
- `8080`: MBTI crawler

#### Option A: `WindowsSpider` (run on Windows)

```bash
cd AnalySeals/WindowsSpider
python 1111FinalT.py
python 1111FinalD.py
python mbti_Final_Version.py
```

#### Option B: `MacSpider` (run on macOS)

```bash
cd AnalySeals/MacSpider
unzip crawler.zip
cd crawler
python 1111FinalT.py
python 1111FinalD.py
python mbti_Final_Version.py
```

## Required Configuration Before Running

### 1. Crawler host IP in Swift code

Replace the hardcoded IP with your local/LAN host IP:

- `AnalySeals/Topic10914/Topic10914/View/PointView.swift`
- `AnalySeals/Topic10914/Topic10914/View/TestView.swift`

Current hardcoded host: `http://172.20.10.3`

### 2. ChromeDriver path in Python scripts

Update `Service(...)` paths in:

- `AnalySeals/WindowsSpider/1111FinalT.py`
- `AnalySeals/WindowsSpider/1111FinalD.py`
- `AnalySeals/WindowsSpider/mbti_Final_Version.py`
- or equivalent files after extracting `MacSpider/crawler.zip`

### 3) Crawler login credentials (if used)

Some crawler flows include third-party website login in the scripts.  
Use your own test credentials and avoid committing secrets.

## Troubleshooting

### ChromeDriver error

- Symptom: Selenium fails to start or crashes immediately.
- Fix: use a ChromeDriver version matching your Chrome major version.

### School-fit / MBTI request fails

- Confirm Flask services are running on ports `5000`, `8000`, `8080`.
- Confirm Swift-side host IP is correct.
- Confirm simulator/device can reach the crawler host.

### CoreData / SwiftData issues

- Clean build and reinstall the app (or remove the simulator app) to rebuild local stores.

## Documentation

- `AnalySeals/Documentation/SRS.pdf`: Software Requirements Specification
- `AnalySeals/Documentation/SDD.pdf`: Software Design Description
- `AnalySeals/Documentation/SUM.pdf`: Software User Manual
- `AnalySeals/Documentation/Project Management.pdf`: Project Management Report
- `AnalySeals/Documentation/Presentation.pdf`: Presentation slides

## Extra Download

If files are missing due to file size limits, use:

- [Download Link](https://drive.google.com/file/d/17OekX1YU66_CRFZTnNhIdpAjSJmIp0a2/view?usp=sharing)
