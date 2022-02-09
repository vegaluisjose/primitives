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
for i, c in enumerate(config):
    df = process(rom=c[0], use_bram=c[1], constraint=True)
    res = df.loc[:, ["lut", "bram"]]  
    res.plot(ax=axes[0][i], kind='bar', stacked=True)
    lat = df.loc[:, ["latency"]]
    lat.plot(ax=axes[1][i], kind='bar', stacked=True)
plt.savefig("rom.pdf")


# if c[1]:
#     plt.savefig("resource_{}_with_bram.pdf".format(c[0]))
# else:
#     plt.savefig("resource_{}.pdf".format(c[0]))
# lat = df.loc[:, ["latency"]]
# lat.plot(kind='bar', stacked=True)
# if c[1]:
#     plt.savefig("latency_{}_with_bram.pdf".format(c[0]))
# else:
#     plt.savefig("latency_{}.pdf".format(c[0]))
