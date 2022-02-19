let ecContractAddress = "0x0d7ae9620346Fb5Dc7B6aF16E87d4AA9aE555c62";
let candidateContractAddress;
let voterContractAddress;

let ecContract;
let candidateContract;
let voterContract;

const initializeMainContract = async (web3) => {
    const ecData = await $.getJSON("./js/contract/ElectionComission.json")
    ecContract = await new web3.eth.Contract(ecData.abi, ecContractAddress);
    // console.log("Contract loaded", ecContract);
    return ecContract;
}

const initializeCandidateContract = async (web3) => {
    const candidateData = await $.getJSON("./js/contract/Candidate.json")
    await ecContract.methods.getCandidateContractAddress().call( async (error, result) => {
        if (result) {
            candidateContractAddress = result;
            console.log("Candidate address",candidateContractAddress);
            candidateContract =  new web3.eth.Contract(candidateData.abi, candidateContractAddress);
            // console.log("candidate Contract loaded", candidateContract);
            return candidateContract;
        }
    });
}

const initializeVoterContract = async (web3) => {
    const candidateData = await $.getJSON("./js/contract/Voter.json")
    await ecContract.methods.getVoterContractAddress().call( async (error, result) => {
        if (result) {
            voterContractAddress = result;
            voterContract =  new web3.eth.Contract(candidateData.abi, voterContractAddress);
            // console.log("voter Contract loaded", voterContract);
            return voterContract;
        }
    });
}

async function initSetup() {
    console.log("i am in setup");
    web3 = await getweb3();
    initializeMainContract(web3).then(async ()=>{
       await initializeCandidateContract(web3);
    }).then( async()=>{
       await initializeVoterContract(web3);
    }).then(async ()=>{
        try{
        onLoad()
        }catch(err){
            console.log("On Load is not define");
        }

    })
 
}
initSetup();