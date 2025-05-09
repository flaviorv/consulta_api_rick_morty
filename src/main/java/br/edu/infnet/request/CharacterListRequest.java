package br.edu.infnet.request;

import java.net.URL;
import java.util.Scanner;

import javax.net.ssl.HttpsURLConnection;

import com.fasterxml.jackson.databind.ObjectMapper;

import br.edu.infnet.domain.CharacterList;

public class CharacterListRequest {
	public static void getApi(String page) {
		try {
			URL url = new URL("https://rickandmortyapi.com/api/character/?page="+page);
			HttpsURLConnection connection = (HttpsURLConnection) url.openConnection();
			connection.setRequestMethod("GET");
			connection.connect();
			String informationString = "";
			Scanner scanner = new Scanner(url.openStream());
			while(scanner.hasNext()) {
				informationString += scanner.nextLine();
			}
			scanner.close();
			ObjectMapper objectMapper = new ObjectMapper();
			objectMapper.readValue(informationString, CharacterList.class);

		}catch(Exception e){
			System.out.println(e.getMessage());
		}
	}
}
