package org.graceful_shutdown;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ExampleResource {
    @GetMapping("/example")
    public String example() throws InterruptedException {
        for (int i = 1; i <= 10; i++) {
            Thread.sleep(5000);
            System.out.println("Hello World :) " + i);
        }
        return "Hello from /example!";
    }
}
