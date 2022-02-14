import pyrtl
from pyrtl.rtllib.aes import AES

def compile_aes(use_rom_fix, distributed, filename): 
    pyrtl.reset_working_block()
    aes = AES(use_rom_fix, distributed)
    plaintext = pyrtl.Input(bitwidth=128, name='aes_plaintext')
    key = pyrtl.Input(bitwidth=128, name='aes_key')
    aes_ciphertext = pyrtl.Output(bitwidth=128, name='aes_ciphertext')
    aes_cipher = aes.encryption(plaintext, key)
    aes_ciphertext <<= aes_cipher
    
    pyrtl.optimize()
    
    with open(filename, "w") as f: 
        pyrtl.output_to_verilog(f, clock_name="clock")


#compile_aes(False, False, "baseline.v")
compile_aes(True, False, "reticle_blk.v")
#compile_aes(True, True, "reticle_dis.v")
