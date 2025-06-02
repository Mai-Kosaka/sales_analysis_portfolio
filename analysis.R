#データ読み込み
df=read.csv("dummy_sales.csv",fileEncoding="UTF-8")
df$日付=as.Date(df$日付)

#日付から曜日を抽出
weekdays_jp=c("Sun","Mon","Tue","Wed","Thu","Fri","sat")
df$曜日=weekdays_jp[as.POSIXlt(df$日付)$wday+1]

#曜日を順番つきfactorに変換
df$曜日=factor(df$曜日,levels=c("Mon","Tue","Wed","Thu","Fri"))

#箱ひげ図(天気ごとの売上)
png("boxplot_weather.png",width=800,height=600)
boxplot(売上~天気,data=df,main="天気ごとの売上",ylab="売上",xlab="天気")
dev.off()

#平均売上(天気ごと)
print(aggregate(売上~天気,data=df,FUN=mean))

#分散分析(天気と売上)
print(summary(aov(売上~天気,data=df)))

#箱ひげ図(曜日ごとの売上)
png("boxplot_weekday.png",width=800,height=600)
boxplot(売上~曜日,data=df,main="曜日ごとの売上",ylab="売上",xlab="曜日")
dev.off()

#平均売上(曜日ごと)
print(aggregate(売上~曜日,data=df,FUN=mean))

#分散分析(曜日と売上)
print(summary(aov(売上~曜日,data=df)))
