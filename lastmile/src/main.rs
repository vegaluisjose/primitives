use lastmile::parse;
use std::fs::File;
use std::io::Read;
use std::path::Path;

fn read_file<P: AsRef<Path>>(file: P) -> anyhow::Result<String> {
    let mut f = File::open(file)?;
    let mut contents = String::new();
    f.read_to_string(&mut contents)?;
    Ok(contents)
}

fn main() -> anyhow::Result<()> {
    let timing = read_file("data/timing.rpt")?;
    let util = read_file("data/util.rpt")?;
    println!("{}", parse::parse_latency(&timing)?);
    println!("dsp:{:?}", parse::parse_dsp(&util)?);
    println!("lut:{:?}", parse::parse_lut(&util)?);
    println!("reg:{:?}", parse::parse_reg(&util)?);
    println!("lram:{:?}", parse::parse_lram(&util)?);
    println!("bram:{:?}", parse::parse_bram(&util)?);
    println!("uram:{:?}", parse::parse_uram(&util)?);
    Ok(())
}
