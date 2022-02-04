use lazy_static::lazy_static;
use regex::Regex;

pub fn parse_latency(input: &str) -> anyhow::Result<f32> {
    lazy_static! {
        static ref RE: Regex =
            Regex::new(r"Data Path Delay:[[:space:]]+([[:digit:]]+.[[:digit:]]+)ns").unwrap();
    }
    match RE.captures(input) {
        Some(c) => match c[1].parse::<f32>() {
            Err(_) => Err(anyhow::anyhow!("could not convert latency to f32")),
            Ok(c) => Ok(c),
        },
        None => Err(anyhow::anyhow!("could not parse latency")),
    }
}

// return used and available
pub fn parse_dsp(input: &str) -> anyhow::Result<(u32, u32)> {
    lazy_static! {
        static ref RE: Regex =
            Regex::new(r"\|[[:space:]]+DSPs[[:space:]]+\|[[:space:]]+([[:digit:]]+)[[:space:]]+\|[[:space:]]+[[:digit:]]+[[:space:]]+\|[[:space:]]+[[:digit:]]+[[:space:]]+\|[[:space:]]+([[:digit:]]+)[[:space:]]+\|").unwrap();
    }
    match RE.captures(input) {
        Some(c) => match (c[1].parse::<u32>(), c[2].parse::<u32>()) {
            (Ok(used), Ok(avail)) => Ok((used, avail)),
            (_, _) => Err(anyhow::anyhow!("could not convert dsp used to u32")),
        },
        None => Err(anyhow::anyhow!("could not parse dsp")),
    }
}

// return used and available
pub fn parse_bram(input: &str) -> anyhow::Result<(u32, u32)> {
    lazy_static! {
        static ref RE: Regex =
            Regex::new(r"\|[[:space:]]+Block RAM Tile[[:space:]]+\|[[:space:]]+([[:digit:]]+)[[:space:]]+\|[[:space:]]+[[:digit:]]+[[:space:]]+\|[[:space:]]+[[:digit:]]+[[:space:]]+\|[[:space:]]+([[:digit:]]+)[[:space:]]+\|").unwrap();
    }
    match RE.captures(input) {
        Some(c) => match (c[1].parse::<u32>(), c[2].parse::<u32>()) {
            (Ok(used), Ok(avail)) => Ok((used, avail)),
            (_, _) => Err(anyhow::anyhow!("could not convert dsp used to u32")),
        },
        None => Err(anyhow::anyhow!("could not parse bram")),
    }
}

// return used and available
pub fn parse_uram(input: &str) -> anyhow::Result<(u32, u32)> {
    lazy_static! {
        static ref RE: Regex =
            Regex::new(r"\|[[:space:]]+URAM[[:space:]]+\|[[:space:]]+([[:digit:]]+)[[:space:]]+\|[[:space:]]+[[:digit:]]+[[:space:]]+\|[[:space:]]+[[:digit:]]+[[:space:]]+\|[[:space:]]+([[:digit:]]+)[[:space:]]+\|").unwrap();
    }
    match RE.captures(input) {
        Some(c) => match (c[1].parse::<u32>(), c[2].parse::<u32>()) {
            (Ok(used), Ok(avail)) => Ok((used, avail)),
            (_, _) => Err(anyhow::anyhow!("could not convert dsp used to u32")),
        },
        None => Ok((0, 0)),
    }
}

pub fn parse_lram(input: &str) -> anyhow::Result<(u32, u32)> {
    lazy_static! {
        static ref RE: Regex =
            Regex::new(r"\|[[:space:]]+LUT as Memory[[:space:]]+\|[[:space:]]+([[:digit:]]+)[[:space:]]+\|[[:space:]]+[[:digit:]]+[[:space:]]+\|[[:space:]]+[[:digit:]]+[[:space:]]+\|[[:space:]]+([[:digit:]]+)[[:space:]]+\|").unwrap();
    }
    match RE.captures(input) {
        Some(c) => match (c[1].parse::<u32>(), c[2].parse::<u32>()) {
            (Ok(used), Ok(avail)) => Ok((used, avail)),
            (_, _) => Err(anyhow::anyhow!("could not convert dsp used to u32")),
        },
        None => Err(anyhow::anyhow!("could not parse lram")),
    }
}

// return used and available
pub fn parse_lut(input: &str) -> anyhow::Result<(u32, u32)> {
    lazy_static! {
        static ref RE: Regex =
            Regex::new(r"\|[[:space:]]+LUT as Logic[[:space:]]+\|[[:space:]]+([[:digit:]]+)[[:space:]]+\|[[:space:]]+[[:digit:]]+[[:space:]]+\|[[:space:]]+[[:digit:]]+[[:space:]]+\|[[:space:]]+([[:digit:]]+)[[:space:]]+\|").unwrap();
    }
    match RE.captures(input) {
        Some(c) => match (c[1].parse::<u32>(), c[2].parse::<u32>()) {
            (Ok(used), Ok(avail)) => Ok((used, avail)),
            (_, _) => Err(anyhow::anyhow!("could not convert dsp used to u32")),
        },
        None => Err(anyhow::anyhow!("could not parse lut")),
    }
}

pub fn parse_reg(input: &str) -> anyhow::Result<(u32, u32)> {
    lazy_static! {
        static ref RE: Regex =
            Regex::new(r"\|[[:space:]]+CLB Registers[[:space:]]+\|[[:space:]]+([[:digit:]]+)[[:space:]]+\|[[:space:]]+[[:digit:]]+[[:space:]]+\|[[:space:]]+[[:digit:]]+[[:space:]]+\|[[:space:]]+([[:digit:]]+)[[:space:]]+\|").unwrap();
    }
    match RE.captures(input) {
        Some(c) => match (c[1].parse::<u32>(), c[2].parse::<u32>()) {
            (Ok(used), Ok(avail)) => Ok((used, avail)),
            (_, _) => Err(anyhow::anyhow!("could not convert dsp used to u32")),
        },
        None => Err(anyhow::anyhow!("could not parse reg")),
    }
}
