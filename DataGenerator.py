import random as Rand
import time
from datetime import datetime

class DataGenerator(object):
    def __init__(self):
       self.columns = []
       self.ids = []
       self.id_index = 0;
       Rand.seed();
       self.tracking = False

    def define_schema(self,schema):
        self.schema = schema

    def define_table(self,table):
        self.table = table

    def define_range_int_column(self,name,min,max):
        column = {"name":name,"type":"int","min":min,"max":max}
        self.add_column(column)

    def define_unique_int_column(self,name,start):
        self.ids.append(start)
        column = {"name":name,"type":"int","unique":"unique","index":self.id_index}
        self.id_index += 1
        self.add_column(column)

    # For List, follow format: [1,6,9,2 ...]
    def define_list_int_column(self,name,list):
        column = {"name":name,"type":"int","list":list}
        self.add_column(column)

    def define_num_column(self,name,min,max):
        column = {"name":name,"type":"numeric(17,2)","min":min,"max":max}
        self.add_column(column)

    def define_str_column(self,name,size):
        column = {"name":name,"type":"varchar("+str(size)+")"}
        self.add_column(column)

    def define_list_str_column(self,name,size,list):
        column = {"name":name,"type":"varchar("+str(size)+")","list":list}
        self.add_column(column)

    # In criteria, follow format >,<,==,>=,<= {date} ex:    " > '2000-01-01'"
    def define_date_column(self,name,operator,date):
        column = {"name":name,"type":"datetime2","operator":operator,"date":date}
        self.add_column(column)

    def add_column(self,column):
        self.columns.append(column)

    def generate_entry(self):
        res = []
        for column in self.columns:
            res.append(self.generate_column(column))
        return res

    def generate_column(self,column):
        res = "Nothing"
        type = column.get("type")
        if type == "int" and column.has_key("unique"):
            res = self.ids[int(column.get("index"))]
            self.ids[int(column.get("index"))] += 1
        if type == "int" and column.has_key("max"):
            res = self.random_int_in_range(column.get("max"),column.get("min"))
        if type == "int" and column.has_key("list"):
            res = self.random_int_in_list(column.get("list"))
        if type == "numeric(17,2)" and column.has_key("max"):
            res = self.random_float_in_range(column.get("max"),column.get("min"))
        if type == "datetime2":
            res = self.random_date_with_op(column.get("operator"),column.get("date"))
        if type.startswith("varchar") and column.has_key("list"):
            res = self.random_str_in_list(column.get("list"))
        return res

    def random_int_in_range(self,max,min):
        i_max = int(max)
        i_min = int(min)
        return Rand.randint(i_min,i_max)

    def random_int_in_list(self,list):
        max = len(list)-1
        min = 0
        index = Rand.randint(min,max)
        return list[index]

    def random_str_in_list(self,list):
        max = len(list)-1
        min = 0
        index = Rand.randint(min,max)
        return list[index]

    def random_float_in_range(self,max,min):
        f_max = float(max)
        f_min = float(min)
        return round(Rand.uniform(min,max),2)

    def random_date_with_op(self,op,date):
        min = '2000-01-01'
        max = '2017-12-31'
        format = "%Y-%m-%d"
        start =  date if op == ">" else min
        end = date if op == "<" else max
        stime = time.mktime(time.strptime(start,format))
        etime = time.mktime(time.strptime(end,format))
        ptime = stime + Rand.random() * (etime - stime)
        return datetime.fromtimestamp(ptime).strftime('%Y-%m-%d')

    def generate_insert_script(self,fullpath):
        with open(fullpath,'w') as script:
            script.write('insert into '+self.schema+"."+self.table+"(\n")
            cols = ""
            for column in self.columns:
                cols=cols+" "+column.get("name")+","
            script.write(cols[:-1]+") values \n")
            for i in range(0,self.count):
                self.track(i)
                entry = self.generate_entry()
                script.write("("+str(entry)[1:-1]+")")
                if i < self.count-1:
                    script.write(",\n")
            script.write(";")

    def generate_csv(self,fullpath):
        with open(fullpath,'w') as script:
            #script.write('insert into '+self.schema+"."+self.table+"(\n")
            cols = ""
            for column in self.columns:
                cols=cols+column.get("name")+","
            script.write(cols[:-1]+"\r\n")
            for i in range(0,self.count):
                self.track(i)
                entry = self.generate_entry()
                script.write(""+str(entry)[1:-1]+",")
                if i < self.count-1:
                    script.write("\r\n")
            script.write("")

    def define_count(self,count):
        self.count = count
        assert count > 0

    def activate_track(self,track):
        if self.count == 0:
            raise Exception('Count must be initialized')
        self.tracking = track
        if self.tracking:
            self.tracking_graph = []
            for i in range(1,101):
                self.tracking_graph.append(self.count * (i/100.0))

    def track(self,i):
        if self.tracking:
            if i in self.tracking_graph:
                print(str(self.tracking_graph.index(i)+1)+"%")

        
