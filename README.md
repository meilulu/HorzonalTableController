# HorzonalTableController
用tableView实现无限滚动


![](https://github.com/meilulu/HorzonalTableController/blob/master/Image/my11.gif)



**关键点：**

1.创建一个tableView后逆时针旋转90度，然后在```cellForRowAtIndexPath```把```cell.contentView```顺时针旋转90度。

2.以31231方式滚动。也就是如果我要显示1、2、3张图片，那么我再1前面插入3，然后再3后面插入1.当tableView从第一张图片往左滚动，我马上调用```[self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.pictures.count-2 inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];```跳到最后一张图片，反之跳到第一张图片，这样就实现了无限滚动。

3.tableView旋转后frame回改变，从新设置frame要考虑到tableView头部的空白。
