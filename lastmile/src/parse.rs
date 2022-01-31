use lazy_static::lazy_static;
use regex::Regex;

pub fn parse_latency(text: &str) -> anyhow::Result<f32> {
    lazy_static! {
        static ref RE: Regex =
            Regex::new("Data Path Delay:[[:space:]]+([[:digit:]]+.[[:digit:]]+)ns").unwrap();
    }
    match RE.captures(text) {
        Some(c) => match c[1].parse::<f32>() {
            Err(_) => Err(anyhow::anyhow!("could not convert latency to f32")),
            Ok(c) => Ok(c),
        },
        None => Err(anyhow::anyhow!("could not parse latency")),
    }
}