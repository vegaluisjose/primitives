use askama::Template;

#[derive(Template)]
#[template(path = "rom.txt")]
pub struct Rom {
    pub use_bram: bool,
    pub addr: u32,
    pub data: u32,
    pub size: u32,
    pub values: Vec<String>,
}

impl Rom {
    pub fn new(addr: u32, data: u32) -> Self {
        Self {
            use_bram: false,
            addr,
            data,
            size: u32::pow(2, addr),
            values: Vec::new(),
        }
    }
    pub fn new_with_bram(addr: u32, data: u32) -> Self {
        Self {
            use_bram: true,
            addr,
            data,
            size: u32::pow(2, addr),
            values: Vec::new(),
        }
    }
    pub fn add_value(&mut self, value: u64) {
        self.values.push(format!("{:016X}", value));
    } 
}

fn main() -> anyhow::Result<()> {
    let mut rom = Rom::new(3, 64);
    rom.add_value(4);
    rom.add_value(2);
    println!("{}", rom.render()?);
    Ok(())
}