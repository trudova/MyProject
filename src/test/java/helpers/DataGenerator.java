package helpers;

import com.github.javafaker.Faker;
import net.minidev.json.JSONObject;

public class DataGenerator {
    public static String getRendomeEmail(){
        Faker faker = new Faker();
        String email = faker.name().firstName().toLowerCase()
                + faker.random().nextInt(0,100) + "@test.com";
                return email;
    }
    public static String getUserName(){
        Faker faker = new Faker();
        String userName = faker.name().username();
        return userName;
    }
    public static JSONObject getRandomArticleValue(){
        Faker faker = new Faker();
        String title = faker.gameOfThrones().quote();
        String description = faker.gameOfThrones().house();
        String body =faker.gameOfThrones().quote()+ faker.gameOfThrones().house();
        JSONObject json = new JSONObject();
        json.put("title", title);
        json.put("description",description);
        json.put("body",body);
        return json;
    }

    public static JSONObject getRandomComment(){
        Faker faker = new Faker();
        String comment = faker.gameOfThrones().quote();

        JSONObject jsonObject = new JSONObject();
        JSONObject jsonObject1 = new JSONObject();
        jsonObject1.put("body", comment);
        jsonObject.put("comment",jsonObject1 );
        return jsonObject;
    }

//    public static void main(String[] args) {
//        System.out.println( getRandomComment());
//        System.out.println(getRandomArticleValue());
//    }
}
