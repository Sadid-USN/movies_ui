import 'package:biz_card/models/model_movie.dart';
import 'package:biz_card/ui/movie_ui.dart';
import 'package:flutter/material.dart';

class ListViewOfMovies extends StatefulWidget {
  @override
  _ListViewOfMoviesState createState() => _ListViewOfMoviesState();
}

class _ListViewOfMoviesState extends State<ListViewOfMovies> {
  final List<ModelMovie> movieList = ModelMovie.getMovies();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.black87,
          title: Text('Muvies'),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: ListView.builder(
          itemCount: movieList.length,
          itemBuilder: (BuildContext context, int index) {
            return Stack(children: [
              movieCard(
                movieList[index],
                context,
              ),
              Positioned(top: 20.0, child: movieImage(movieList[index].poster)),
            ]);
          },
        ));
  }

  Widget movieCard(ModelMovie movie, BuildContext context) {
    return InkWell(
        child: Container(
          margin: EdgeInsets.only(left: 20),
          padding: EdgeInsets.symmetric(horizontal: 5),
          width: MediaQuery.of(context).size.width,
          height: 150.0,
          child: Card(
            color: Colors.black87,
            child: Padding(
              padding: EdgeInsets.only(left: 80),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            movie.title,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          'Rating: ${movie.imdbRating} / 10',
                          style: myTextStyle(),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Released: ${movie.released}',
                        style: myTextStyle(),
                      ),
                      Text(movie.runtime, style: myTextStyle()),
                      Text(movie.rated, style: myTextStyle()),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        onTap: () =>
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return NewScreenMovieDetails(
                movie: movie,
              );
            })));
  }

  Widget movieImage(String posterImage) {
    return Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: NetworkImage(posterImage), fit: BoxFit.cover)),
    );
  }
}

class NewScreenMovieDetails extends StatelessWidget {
  final String? movieName;
  final ModelMovie? movie;
  NewScreenMovieDetails({
    Key? key,
    this.movieName,
    this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black87,
          title: Text('${movie?.title}'),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            MovieDetails(
              thumbnail: movie?.images[2],
            ),
            MovieDetailsHeaderWithPoster(
              movie: movie,
            ),
            MovieCast(
              movie: movie,
            ),
            AllMovieImages(
              images: movie?.images,
            )
          ],
        ));
  }
}
