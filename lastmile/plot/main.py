import json
import seaborn as sns
import pandas as pd
import matplotlib.pyplot as plt


def process(rom="roma", use_bram=False, constraint=True):
    # it_data = [8, 16, 32]
    it_data = [16]
    it_size = [8, 16, 32, 64, 128, 256, 512, 1024, 2048]
    latency = []
    lut = []
    bram = []
    size = []
    folder = "data" if constraint else "data_wo_constraint"
    for d in it_data:
        for s in it_size:
            f = (
                open("../{}/{}_bram_d{}_s{}.json".format(folder, rom, d, s))
                if use_bram
                else open("../{}/{}_d{}_s{}.json".format(folder, rom, d, s))
            )
            j = json.load(f)
            fix = 0.068 if j["latency"] == 0 else j["latency"]
            latency.append(fix)
            lut.append(j["lut"]["used"] + j["lram"]["used"])
            bram.append(j["bram"]["used"])
            size.append(s)
    df = {
        "latency": latency,
        "lut": lut,
        "bram": bram,
    }
    return pd.DataFrame(df, index=size)

config = [("roma", False), ("romb", False), ("romb", True)]
_, axes = plt.subplots(2, 3, figsize=(16, 8))
titles = ["(a) Verilog", "(b) Verilog", "(c) Reticle"]
for i, c in enumerate(config):
    df = process(rom=c[0], use_bram=c[1], constraint=True)
    res = df.loc[:, ["lut", "bram"]]
    res.plot(ax=axes[0][i], kind="bar", stacked=True)
    axes[0][i].set_ylim(top=10)
    axes[0][i].grid(axis="y", linestyle="--")
    axes[0][i].set_title(titles[i])
    lat = df.loc[:, ["latency"]]
    lat.plot(ax=axes[1][i], kind="bar")
    axes[1][i].set_xlabel("Number of elements")
    axes[1][i].set_ylim(top=0.25)
    axes[1][i].grid(axis="y", linestyle="--")
    axes[1][i].get_legend().remove()
    if i == 0:
	axes[0][i].set_ylabel("Number of resources")
	axes[1][i].set_ylabel("Data path delay (ns)")
plt.savefig("rom.pdf")

