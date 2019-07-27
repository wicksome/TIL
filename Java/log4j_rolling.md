# log4j

> Log Rolling

**파일 사이즈로 롤링하기**

```xml
<appender name="withdrawAppender" class="org.apache.log4j.RollingFileAppender">
	<param name="File" value="/path/rolling.log" />
	<param name="Append" value="true" />
	<param name="MaxFileSize" value="10MB" /> <!-- 롤링될 파일 한개의 사이즈 -->
	<param name="MaxBackupIndex" value="100" /> <!-- 100개 파일 넘어가면 오래된 것부터 삭제 -->
	<layout class="org.apache.log4j.PatternLayout">
		<param name="ConversionPattern" value="%d{yyyy-MM-dd HH:mm:ss} [%-5p](%F:%L) %m%n" />
	</layout>
</appender>
```
**날짜별로 롤링하기**

```xml
<appender name="memoSync" class="org.apache.log4j.DailyRollingFileAppender">
	<param name="Threshold" value="INFO"/>
	<param name="file" value="/logs/rolling.log"/>
	<param name="append" value="true"/>
	<param name="DatePattern" value="'.'yyyy-MM-dd"/> <!-- 매일 로그 롤링, ex) rolling.log.2016.06.27  -->
	<layout class="org.apache.log4j.PatternLayout">
		<param name="ConversionPattern" value="[%d{yyyy-MM-dd HH:mm:ss}] [%-5p](%F:%L) %m%n"/>
	</layout>
</appender>	
```