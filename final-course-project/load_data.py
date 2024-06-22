#%% Libraries
import os, glob
import pickle
#--+ folder
folder = '.data/'
# %% iterate
for f in glob.glob(os.path.join(folder, '*.pickle')):
    d = pickle.load(open(f, 'rb'))
    # ---
    # Add here your psycopg2 or pymongo pipeline
    # ---
# %%
