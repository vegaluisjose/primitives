import io
import pyrtl


# let values be a ^2 function
def rom_data_func(address):
    return address * address


# create initial values
rom_data_array = [rom_data_func(a) for a in range(8)]
print("initial values: ", ' '.join([hex(i) for i in rom_data_array]))


# declare a ROM block and ports
rom1 = pyrtl.RomBlock(bitwidth=8, addrwidth=3, romdata=rom_data_array, name="rom1", max_read_ports=1, asynchronous=False)

rom1_address = pyrtl.Input(bitwidth=3, name="rom1_address")
rom1_out = pyrtl.Output(bitwidth=8, name="rom1_out")


# here is now a ROM works
rom1_out <<= rom1[rom1_address]

# Verilog
with io.StringIO() as f:
    pyrtl.output_to_verilog(f)
    print(f.getvalue())
