package runners;

import com.intuit.karate.junit5.Karate;

public class TestRunner {

    @Karate.Test
    Karate testProjects() {
        return Karate.run("classpath:features/project/project.feature");
    }
}