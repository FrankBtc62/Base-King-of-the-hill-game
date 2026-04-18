const { ethers } = require("hardhat");

async function main() {
  const Contract = await ethers.getContractFactory("x402King");
  const contract = await Contract.deploy();

  await contract.waitForDeployment();

  console.log("x402King deployed to:", contract.target);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
