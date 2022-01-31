use askama::Template;
use derive_more::{Deref, DerefMut};
use std::fmt;
use std::str::FromStr;

#[derive(Clone, Debug)]
pub struct Rom {
    pub name: String,
    pub size: u32,
    pub addr: u32,
    pub data: u32,
    pub values: Vec<String>,
    pub use_bram: bool,
}

impl Rom {
    pub fn new(name: &str, size: u32, data: u32) -> Self {
        Self {
            name: name.into(),
            size,
            addr: (size as f32).log2() as u32,
            data,
            values: Vec::new(),
            use_bram: false,
        }
    }
    pub fn new_with_bram(name: &str, size: u32, data: u32) -> Self {
        Self {
            name: name.into(),
            size,
            addr: (size as f32).log2() as u32,
            data,
            values: Vec::new(),
            use_bram: true,
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

#[derive(Template, Clone, Debug, Deref, DerefMut)]
#[template(path = "roma.txt")]
pub struct RomA(pub Rom);

#[derive(Template, Clone, Debug, Deref, DerefMut)]
#[template(path = "romb.txt")]
pub struct RomB(pub Rom);

#[derive(Clone, Debug)]
pub enum RomType {
    A,
    B,
}

impl fmt::Display for RomType {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        let backend = match self {
            RomType::A => "a",
            RomType::B => "b",
        };
        write!(f, "{}", backend)
    }
}

impl FromStr for RomType {
    type Err = anyhow::Error;
    fn from_str(input: &str) -> anyhow::Result<Self> {
        match input {
            "a" => Ok(RomType::A),
            "b" => Ok(RomType::B),
            n => Err(anyhow::anyhow!("unsupported rom {}", n)),
        }
    }
}
