from mrjob.job import MRJob

class StockBlackDay(MRJob):
  def mapper(self, _, line):
    company,price,date = line.split(',')
    yield date, float(price)

  def reducer(self, date, data):
    d = list(data)
    avg = sum(d)/len(d)
    yield date, avg

if __name__ == '__main__':
  StockBlackDay.run()