# FJSPicMixCollectionViewLayout
like 500px the picture that emerged was mixed.1模仿IMDb和格瓦拉的图片集混合排布展示效果.2.普通瀑布流waterFlow3.跨列混合瀑布流waterFlow4.中间图片放大

![image](https://github.com/BestJoker/FJSPicMixCollectionViewLayout/blob/master/练习/FJSPicMixCollectionViewFlowLayout.gif?raw=true)

格瓦拉图片排布的特点.

1.图片保持原来比例,没有拉伸的情况下,可以恰好宽度和与屏幕相同.

2.每一行的图片数量不确定,一行的图片整体高度相同,切不同行高度不确定.

3.与图片尺寸无关,无论什么比例的图片流,都可以按照如规律进行排布.


根据分析,找到了格瓦拉的排布规律:

1.计算出每一张图片的宽度和高度比,同时每一行存在一个最大高度,假设为宽度的一半,也就是说,同一行的图片的宽高比的和要小于一个比例,即2.0.

2.累加一行的宽高比,如果小于2.0,继续添加图片,如果大于2.0,则重新压缩这一行的图片,调整他们的高度和宽度,使其刚好与屏幕同宽.











