use askama::Template;
use lastmile::rom::{Rom, RomA, RomB, RomType};
use rand::{rngs::StdRng, Rng, SeedableRng};
use std::fs::File;
use std::io::Write;
use std::path::PathBuf;
use structopt::StructOpt;

#[derive(Debug, StructOpt)]
#[structopt(name = "rom", about = "A tool for generating two types of roms")]
struct Opt {
    /// Size (number of elements) of ROM
    #[structopt(short, long)]
    size: u32,
    /// Data width of ROM
    #[structopt(short, long)]
    data: u32,
    /// Type of ROM
    #[structopt(short, long)]
    rom: RomType,
    /// Output file
    #[structopt(short, long)]
    output: Option<PathBuf>,
}

fn main() -> anyhow::Result<()> {
    let opt = Opt::from_args();
    let mut rng = StdRng::seed_from_u64(0);
    let mut rom = Rom::new(opt.size, opt.data);
    for _ in 0..opt.size {
        rom.add_value(rng.gen());
    }
    let s = match opt.rom {
        RomType::A => RomA(rom).render()?,
        RomType::B => RomB(rom).render()?,
    };
    // let s = genrom.render()?;
    if let Some(output) = opt.output {
        let mut file = File::create(output)?;
        file.write_all(s.as_bytes())?;
    } else {
        println!("{}", s);
    }
    Ok(())
}
