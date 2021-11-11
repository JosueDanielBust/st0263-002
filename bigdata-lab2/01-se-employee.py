from mrjob.job import MRJob

class SalarioPromedio(MRJob):
  def mapper(self, _, line):
    idemp,sececon,salary,year = line.split(',')
    yield idemp, int(sececon)

  def reducer(self, employee, values):
    l = list(values)
    total = len(l)
    yield employee, total

if __name__ == '__main__':
  SalarioPromedio.run()