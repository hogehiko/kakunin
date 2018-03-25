import luigi

class MyTask(luigi.Task):
	x = luigi.Parameter()
	def run(self):
		print("hoge********" + self.x)

