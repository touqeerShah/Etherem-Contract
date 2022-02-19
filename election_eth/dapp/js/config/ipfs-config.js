
const ipfs = window.IpfsHttpClient.create({ host: '127.0.0.1', port: 5001 })
console.log("ipfs",ipfs);

// async function test(){
//   var {cid} = await ipfs.add("ytess");
//   console.log(cid);
// }
// test();