package Feature.VDespa_API;

import com.intuit.karate.junit5.Karate;

public class Runner {

    @Karate.Test
    public Karate runTests() {
        return Karate.run("ProductTestCases").relativeTo(getClass());
    }
}
