package br.edu.infnet.controller;

import java.util.Optional;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import br.edu.infnet.request.CharacterListRequest;

@Controller
public class CharacterListController {
	@GetMapping(value="/")
	public ModelAndView telaCharacters(@RequestParam("page") Optional<String> pageParam) {
		String page = pageParam.isEmpty()?"1":pageParam.get();
		CharacterListRequest.consumirApi(page);
		ModelAndView mv= new ModelAndView("characters");
		mv.addObject("page", page);
		mv.addObject("nextPage", Integer.parseInt(page)+1);
		mv.addObject("previousPage", Integer.parseInt(page)-1);
		return mv;
	}

}
