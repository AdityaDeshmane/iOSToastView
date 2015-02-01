# iOSToastView
Android like toast popup with lot of customizable parameters


![      ](\1.png "") 


![      ](\2.png "") 


![      ](\3.png "") 


* Small code 
* Easy to modify 
* Many customizable parameter to meet whatever your requiment are

```obj-c
//Transparancy
#define kBackgroundAlpha 0.4

//Margins
#define kToastWidth 290
#define kToastLeadingTrailingTextMargin 10
#define kToastTopBottomTextMargin 10

//BackgroundColor
#define kBackgroundColor [UIColor darkGrayColor]

//Border
#define kBorderColor [UIColor cyanColor]
#define kCornerRadius 5.0
#define kBorderWidth  2.0

//Message
#define kMessageTextColor [UIColor cyanColor]
#define kDefaultMessageFontSize 16

//Display time
#define kDisplayTime 1.5
```

<em>This UI control can be used on all iPhones, iPods & iPads running iOS 5.0 and above.</em>

---
---

### Adding to your project

* Add Follwing two files to your project

```
'ADToastView.h'
'ADToastView.m'
```



### How to use ?

#### Sample Codes :

```obj-c

//1.  IMPORT
#import "ADToastView.h"



//2. CREATING INSTANCE OF CONTROL

    ADToastView *toastView = [[ADToastView alloc] initToastWithMessage:@"Test Toast Message"];



//3. SHOWING TOAST

    [toastView show];
```
---
---

### Requirements :

ADToastView works on iOS 5.0 & above versions and is compatible with ARC projects. There is no need of other frameworks/libraries

---
---

### Other details :

* XCode : Developed using 6.0
* Base sdk used while development : 8.1
* Testing : iOS: 6,7,8   Devices : iPad & 3.5, 4, 4.7, 5.5 inch iphones

---
---

### TODOs :

* Component polishing

---
---
