use lastmile::parse;
use std::fs::File;
use std::io::Read;

fn main() -> anyhow::Result<()> {
    let mut file = File::open("data/timing.rpt")?;
    let mut contents = String::new();
    file.read_to_string(&mut contents)?;
    println!("{}", parse::parse_latency(&contents)?);
    Ok(())
}
