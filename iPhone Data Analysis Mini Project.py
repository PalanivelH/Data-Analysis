#!/usr/bin/env python
# coding: utf-8

# In[2]:


import pandas as pd


# In[3]:


df = pd.read_csv('C:/Users/HP/Downloads/apple_products.csv')


# In[4]:


df.head()


# In[5]:


df.count()


# In[8]:


df['Mrp'].max()


# In[9]:


df['Mrp'].min()


# In[10]:


df[df['Mrp']==df['Mrp'].min()]


# In[13]:


df.sort_values(by=['Star Rating'],ascending=False)


# In[62]:


list(df['Product Name'])[0][5:15].strip()


# In[28]:


type(df['Product Name'])


# In[34]:


df['Model Name']=df['Product Name'].str[5:15]
df['Model Name']


# In[35]:


df


# In[39]:


df[df['Ram']=='4 GB'].count()


# In[41]:


df.sort_values(by='Discount Percentage',ascending=False).head() #Top Five Maximum Discounted iPhones


# In[42]:


df['Product Name']


# In[51]:


df['Storage'] = df['Product Name'].str[-7:-1]


# In[52]:


df


# In[60]:


df[df['Storage']=='256 GB']


# In[ ]:




