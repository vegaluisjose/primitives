use askama::Template;
use rand::{rngs::StdRng, Rng, SeedableRng};

#[derive(Template)]
#[template(path = "rom.txt")]
pub struct Rom {
    pub use_bram: bool,
    pub addr: u32,
    pub data: u32,
    pub values: Vec<String>,
}

impl Rom {
    pub fn new(size: u32, data: u32) -> Self {
        Self {
            use_bram: false,
            addr: (size as f32).log2() as u32,
            data,
            values: Vec::new(),
        }
    }
    pub fn new_with_bram(size: u32, data: u32) -> Self {
        Self {
            use_bram: true,
            addr: (size as f32).log2() as u32,
            data,
            values: Vec::new(),
        }
    }
    pub fn add_value(&mut self, value: u64) {
        let value_hex = match self.data {
            64 => format!("{:016X}", value),
            32 => format!("{:08X}", 0xffffffff & value),
            16 => format!("{:04X}", 0xffff & value),
            8 => format!("{:02X}", 0xff & value),
            4 => format!("{:01X}", 0xf & value),
            _ => format!("{:X}", value),
        };
        self.values.push(value_hex);
    }
}

fn main() -> anyhow::Result<()> {
    let mut rng = StdRng::seed_from_u64(0);
    let size = 32;
    let data = 16;
    let mut rom = Rom::new(size, data);
    for _ in 0..size {
        rom.add_value(rng.gen());
    }
    println!("{}", rom.render()?);
    Ok(())
}
