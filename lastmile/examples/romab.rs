use askama::Template;
use lastmile::rom::{Rom, RomA, RomB};
use rand::{rngs::StdRng, Rng, SeedableRng};

fn main() -> anyhow::Result<()> {
    let mut rng = StdRng::seed_from_u64(0);
    let size = 32;
    let data = 32;
    let mut rom = Rom::new(size, data);
    for _ in 0..size {
        rom.add_value(rng.gen());
    }
    let roma = RomA(rom.clone());
    let romb = RomB(rom);
    println!("{}", roma.render()?);
    println!("{}", romb.render()?);
    Ok(())
}
