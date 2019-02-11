# -*- coding:utf8 -*-
import json
import csv
import re
import os
dir_path = os.path.dirname(os.path.realpath(__file__))



def getAPICalls(path):
    pp = set()
    with open(path,"r+") as files:
        reader = csv.reader(files)
        for row in reader:
           print  row[2]


if __name__ == '__main__':
    path = dir_path+"/monitor.csv"

    getAPICalls(path)