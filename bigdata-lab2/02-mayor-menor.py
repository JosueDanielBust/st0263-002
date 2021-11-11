from mrjob.job import MRJob

class StockMayorMenor(MRJob):
  def mapper(self, _, line):
    company,price,date = line.split(',')
    yield company, [float(price), date]

  def reducer(self, company, data):
    d = list(data)
    prices = [x[0] for x in d]
    dates = [x[1] for x in d]
    min_date = dates[prices.index(min(prices))]
    max_date = dates[prices.index(max(prices))]
    yield company, [min_date, max_date]

if __name__ == '__main__':
  StockMayorMenor.run()