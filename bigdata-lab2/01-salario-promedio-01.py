from mrjob.job import MRJob

class SalarioPromedio(MRJob):
  def mapper(self, _, line):
    idemp,sececon,salary,year = line.split(',')
    yield sececon, int(salary)

  def reducer(self, sector, values):
    l = list(values)
    avg = sum(l)/len(l)
    yield sector, avg

if __name__ == '__main__':
  SalarioPromedio.run()