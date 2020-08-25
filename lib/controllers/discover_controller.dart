
import 'package:movie_app/components/models/movie_model.dart';
import 'package:movie_app/networking/api.dart';

class DiscoverController{

  handleDiscoverItems()async{
    Api api = Api();
    var discoverResults = await api.discover();
    if(discoverResults["status"] == "success"){
      List<Map<String,dynamic>> discoverMovies = discoverResults["results"];
      List<Movie> discover = [];
      for(int i = 0 ; i < 3 ;i++){
        Movie movie = Movie.fromJson(discoverMovies[i]);
        discover.add(movie);
      }
      return discover;
    }else{
      return discoverResults["status_message"];
    }
  }
}