console.log("\n\n\n\nfile loaded");
async function  viewAllVotes(){

    await candidateContract.methods.getAllCandidatePartName().call( async(error, result) => {
        if (result) {
            console.log("parties list",result);
            result.forEach(element => {
                countVote(element)

            });
        }else{
            console.log("Error",error);

        }
    });

}
async function countVote(partyname){
    await voterContract.methods.getVoteCount(partyname).call( (error, result) => {
        if (result) {
            console.log("parties = ",partyname,"  result =",result);
            $("#parties").append("<li> Party name = "+partyname+" Number of Votes = "+result+"</li>")

        }else{
            console.log("Error",error);
        }
    });

}