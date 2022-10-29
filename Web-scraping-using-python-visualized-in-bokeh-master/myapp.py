#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pandas as pd
data=pd.read_csv('D:/User/Google Drive/Proyectos/Python & R diversos/Python/Sources/airbnbpricesLima2.csv')
data.info()
data.nunique()
data.head()


# In[2]:


data.head()
data['index']=range(0,len(data.url))


# In[3]:


data['bed']=data['bed'].apply(lambda x: str(x).split(' ')[0] )
data['bed']=data['bed'].astype(float)


# In[4]:


data['bath']=data['bath'].apply(lambda x: str(x).split(' ')[0] )
data['bath']=data['bath'].astype(float)


# In[5]:


data['reviews']=data['reviews'].apply(lambda x: str(x).split(' ')[0].replace("(",""))
data['reviews']=data['reviews'].astype(float)


# In[6]:


data['price']=data['price'].apply(lambda x: str(x)[1:].replace(' ','').replace('an','0'))
data['price']=data['price'].astype(float)


# In[7]:


data['feat_amenities']=data['feat_amenities'].apply(lambda x: str(x)[8:11].replace(' ','0')+'0')
data['feat_amenities']=data['feat_amenities'].astype(float)


# In[8]:


# data[data['reviews'].isna()==True].count()
data['no_reviews']=(data['reviews'].isna()==True)*1
data['no_rate']=(data['rate'].isna()==True)*1


# In[9]:


data2=data[data['title'].isna()==False][['index','location','bed','bath','feat_amenities','rate','reviews','price']]


# In[10]:


# data2['rate']=data2['rate'].fillna(data2['rate'] .mean())
# data2['reviews']=data2['reviews'].fillna(data2['reviews'] .mean())
data2['rate']=data2['rate'].fillna(0)
data2['reviews']=data2['reviews'].fillna(0)
data2['feat_amenities']=data2['feat_amenities']/10
data2['freq']=1


# In[11]:


data2['location']=data2['location'].replace('San Isidro, Distrito de Lima','San Isidro')
data2['location']=data2['location'].replace('San Miguel, Lima','San Miguel')
data2['location']=data2['location'].replace('Lince, Lima Perú','Lince')
data2['location']=data2['location'].replace('Distrito de Barranco','Barranco')
data2['location']=data2['location'].replace('Lima Province','Lima Region')
data2['location']=data2['location'].replace('Cercado de Lima','Distrito de Lima')
data2['location']=data2['location'].replace('Distrito de Lima','Cercado de Lima')
data2['location']=data2['location'].replace('Constitutional Province of Callao','Callao')
data2['location']=data2['location'].replace('La Perla','Callao')
data2['location']=data2['location'].replace('Lima','Lima Region')
data2['location']=data2['location'].replace('Distrito de Surco','Surco')
data2['location']=data2['location'].replace('Santiago de Surco','Surco')

#We include all the non-district specific observations in 'others' 
data2['location']=data2['location'].replace('Lima Region','Other')
data2['location']=data2['location'].replace('PE','Other')


# In[12]:


data2.head()


# In[13]:


data2.groupby('location').mean()


# Price vs Rate \n
# 
# Price vs Reviews
# 
# Price vs Ammenities
# 
# Plot of price and frequency per district
# 

# In[14]:


# from bokeh.plotting import figure, show, output_file

# grouped_data=data2.groupby('location').mean()
# output_file('hbar.html')
# p = figure(plot_width=400, plot_height=400)
# p.hbar(y=grouped_data['location'], height=0.5, left=0,
#        right=grouped_date['price'], color="navy")
# show(p)
grouped_data=data2.groupby('location').mean()
grouped_data.reset_index(level=0, inplace=True)
grouped_data=grouped_data.sort_values(by='price', ascending=False)
data2['location']=data2['location'].replace('Cercado de Lima','Lima')
data2['location']=data2['location'].replace('Surco','Santiago de surco')
data2['location']=data2['location'].replace('San Isidro','Centro financiero de San Isidro')






data2['location']=data2['location'].replace('Surco','Santiago de surco')
data2['location']=data2['location'].replace('San Isidro','Centro financiero de San Isidro')
from bokeh.io import output_file, show
from bokeh.models import ColumnDataSource, GMapOptions
from bokeh.plotting import gmap
map_options = GMapOptions(lat=-12.0621065, lng=-77.0365256, map_type="roadmap", zoom=11)
from geopy.geocoders import Nominatim
geolocator = Nominatim(user_agent="Hello")
latitudes=[]
longitudes=[]
addresses=[]
for i in data2['location'].unique():
    if i!='Other':
        location = geolocator.geocode(i+" Lima Peru")
        print(location.address)
        addresses.append(location.address)
        latitudes.append(location.latitude)
        longitudes.append(location.longitude) 
maplima = gmap('AIzaSyBFqFxGEsIZ06EEfzNcbnstavezymFa-WI', map_options, title="Districts of Lima")
source = ColumnDataSource(
    data=dict(lat=latitudes,
              lon=longitudes)
)
maplima.circle(x="lon", y="lat", size=15, fill_color="blue", fill_alpha=0.8, source=source)








# In[18]:


from bokeh.io import curdoc
from bokeh.layouts import column
from bokeh.layouts import row
from bokeh.models import ColumnDataSource,Select
from bokeh.plotting import figure
from numpy.random import random, normal, lognormal
from bokeh.client import push_session, pull_session

source=ColumnDataSource(data={'x':data2[data2['rate']>0]["rate"],'y':data2[data2['rate']>0]["price"]})

#Create plots and widgets
plot=figure(title='Scatterplot of multiple variables vs. Price')
plot.circle(x='x',y='y',source=source)

menu=Select(options=['rate','reviews','amenities'],value='rate',title='variable')

#add callback to widgets
def callback(attr,old,new):
    if menu.value=='rate':f='rate'
    elif menu.value=='reviews': f='reviews'
    else: f='feat_amenities'
    source.data={'x':data2[data2[f]>0][f],'y':data2[data2[f]>0]["price"]}
menu.on_change('value',callback)


location = grouped_data['location']
price = grouped_data['price']
p = figure(x_range=location, plot_height=250, title="Average Airbnb rental prices per district",
           toolbar_location=None, tools="")

p.vbar(x=location, top=price, width=0.9)
p.xaxis.major_label_orientation = 1
# p.xgrid.grid_line_color = None
p.y_range.start = 0














#arrange plots and widgets in layout
layout=row(column(menu,plot),column(p,maplima))
# grid = gridplot([[p1, p2, p3], [None,p,None]], plot_width=450, plot_height=450)
curdoc().add_root(layout)
# #create a session
# session = push_session(curdoc().add_root(layout))
# session.show()
# session.loop_until_closed()

