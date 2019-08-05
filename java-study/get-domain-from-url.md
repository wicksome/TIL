
**getDomainFromUrl.java**

```java
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @author yeongjun on 2016\. 9\. 7.
 */
public class DomainUrlUtils {
    private static String[] TLD = {"com", "net"}; // top-level domain
    private static String[] SLD = {"co\\.kr"}; // second-level domain

    /**
     * 도메인 가져오기
     * 주의: 새로운 top-level, second-level이 있다면 TLD, SLD에 추가할 것
     *
     * @param url
     * @return domain
     */
    public static String getDomainName(String url) {
        Pattern pattern = Pattern.compile("(?<=)[^(\\.|\\/)]\\w+\\.(" + joinTldAndSld("|") + ")$");
        Matcher match = pattern.matcher(url);
        String domain = null;

        if (match.find()) {
            domain = match.group();
        }

        return domain;
    }

    /**
     * TLD, SLD를 delimiter로 이어주기
     *
     * @param delimiter
     * @return
     */
    private static String joinTldAndSld(String delimiter) {
        String t = String.join(delimiter, TLD);
        String s = String.join(delimiter, SLD);

        return new StringBuilder(t).append(s.isEmpty() ? "" : "|" + s).toString();
    }
}
```
