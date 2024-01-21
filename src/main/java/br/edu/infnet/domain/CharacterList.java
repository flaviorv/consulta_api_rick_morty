package br.edu.infnet.domain;

import java.util.List;

public class CharacterList {
	private static Info info;
	private static List<Character> results;
	
	
	public static Info getInfo() {
		return info;
	}
	public void setInfo(Info info) {
		CharacterList.info = info;
	}
	public static List<Character> getResults() {
		return results;
	}
	public void setResults(List<Character> results) {
		CharacterList.results = results;
	}
	
	
}
