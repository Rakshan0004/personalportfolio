package in.rakshan.personalportfolio.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {

    @RequestMapping({"/", "", "/home", "/rakshan", "/wolkop"})
    public String showHomePage() {
        return "home";
    }
}
