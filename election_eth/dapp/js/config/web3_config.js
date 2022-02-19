var web3;
var myAccount;
var network;

var getweb3 =()=>{
    return  new Promise((res,rej)=>{
        window.addEventListener("load",async()=>{
            if(window.ethereum){
                const web3 = new Web3(window.ethereum);
                try{

                    await window.ethereum.request({method: "eth_requestAccounts"})
                    res(web3);
                }catch(err){
                    console.log(err);
                    rej(err);
                }
            }else{
                console.log("MateMask is not install");
            }
        })

    })
}


async function init(){
    web3 = await getweb3();

    myAccount= await web3.eth.getAccounts();

    network=await web3.eth.net.getId(); 

    window.ethereum.on("accountsChanged",logAccounts);// this will run when we change account in matemask

}
init();
const logAccounts= (accounts)=>{

    console.log(`Account: ${accounts.join("\n")}; `);
    myAccount[0]= `${accounts.join("\n")}`;
}; 