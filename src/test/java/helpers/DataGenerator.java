package helpers;

import com.github.javafaker.Faker;

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
}
