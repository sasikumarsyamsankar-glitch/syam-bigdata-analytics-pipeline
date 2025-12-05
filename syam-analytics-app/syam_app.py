import pandas as pd

print("Developer: Syam Sankar Sasikumar")

df = pd.read_csv("syam_data.csv")

print("Average Score:", df["score"].mean())
print("Highest Score:", df["score"].max())
print("Lowest Score:", df["score"].min())
print("Total Score:", df["score"].sum())
print("Number of Records:", len(df))
