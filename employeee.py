# -*- coding: utf-8 -*-
"""
Created on Tue Nov  9 21:59:54 2021

@author: FabiDiamanti
"""


class insertBd:
    def load_excel(self):
        import csv
        self.archivo = open(r"C:\Users\FabiDiamanti\Documents\Fabian\entrevista_python\employee.csv",encoding="utf8")
        self.filas = csv.reader(self.archivo, delimiter=";")
        self.lista = list(self.filas)
        del (self.lista[0])
        #self.columns = self.lista[0];
        self.tuplaa = tuple(self.lista)
        #print(self.tuplaa)
        
        
    def ins_employs(self):
        import psycopg2
        self.connection = psycopg2.connect("dbname=pub user=postgres password=dataf345")
        self.cursor = self.connection.cursor()
        #print(self.tuplaa)

        self.cursor.executemany("INSERT INTO employee  (  fname, minit, lname, job_id, job_lvl, pub_id )  VALUES (%s,%s,%s,%s,%s,%s )",self.tuplaa)
        self.connection.commit()
        self.connection.close()
    
        
        
        
    def selectt(self): 
        import psycopg2
        self.connection = psycopg2.connect("dbname=pub user=postgres password=dataf345")
        self.cursor = self.connection.cursor()
        self.query = "SELECT * FROM employee;"
        self.cursor.execute(self.query)
        self.all_items = self.cursor.fetchall()
        self.cursor.close()
        self.connection.close()
        print (self.all_items)
        
        
insBd = insertBd()
insBd.load_excel()
insBd.ins_employs()
insBd.selectt()
