use crate::parse;
use std::fs::File;
use std::io::Read;
use std::path::Path;

#[derive(Clone, Debug)]
pub struct Value {
    pub used: u32,
    pub total: u32,
}

impl From<(u32, u32)> for Value {
    fn from(input: (u32, u32)) -> Self {
        Value {
            used: input.0,
            total: input.1,
        }
    }
}

#[derive(Clone, Debug)]
pub struct Profile {
    pub latency: f32,
    pub lut: Value,
    pub dsp: Value,
    pub reg: Value,
    pub lram: Value,
    pub bram: Value,
    pub uram: Value,
}

fn read_file<P: AsRef<Path>>(file: P) -> anyhow::Result<String> {
    let mut f = File::open(file)?;
    let mut contents = String::new();
    f.read_to_string(&mut contents)?;
    Ok(contents)
}

impl Profile {
    pub fn from_timing_and_utilization<P: AsRef<Path>, Q: AsRef<Path>>(
        t: P,
        u: Q,
    ) -> anyhow::Result<Profile> {
        let timing = read_file(t)?;
        let util = read_file(u)?;
        Ok(Profile {
            latency: parse::parse_latency(&timing)?,
            lut: parse::parse_lut(&util)?.into(),
            dsp: parse::parse_dsp(&util)?.into(),
            reg: parse::parse_reg(&util)?.into(),
            lram: parse::parse_lram(&util)?.into(),
            bram: parse::parse_bram(&util)?.into(),
            uram: parse::parse_uram(&util)?.into(),
        })
    }
}
