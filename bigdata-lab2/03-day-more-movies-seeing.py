from mrjob.job import MRJob

class DayMoreMoviesSeeing(MRJob):
  def mapper(self, _, line):
    user,movie,rating,genre,date = line.split(',')
    yield date, int(movie)

  def reducer(self, date, movie):
    d = list(movie)
    movies = len(d)
    yield date, movies

if __name__ == '__main__':
  DayMoreMoviesSeeing.run()