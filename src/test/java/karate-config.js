function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    apiUrl: 'https://api.realworld.io/api/'
  }
  if (env == 'dev') {
    config.userEmail ='liv2@gmail.com'
    config.userPassword ='123liv'
  }
  if (env == 'sys') {
//  fake credentials
    config.userEmail ='liv3@gmail.com'
    config.userPassword ='1234liv'
  }

 var accessToken = karate.callSingle('classpath:helpers/CreateToken.feature', config).authToken
 karate.configure('headers', {Authorization: "Token "+ accessToken})

  return config;
}