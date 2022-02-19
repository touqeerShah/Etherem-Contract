async function  getAllParties(){

    await candidateContract.methods.getAllCandidatePartName().call( (error, result) => {
        if (result) {
            console.log("parties list",result);
            result.forEach(element => {
                $("#parties").append("<li> <a href='viewPartyDetails.html?partiyname="+element+"'>"+element+"</a></li>")
            });
        }else{
            console.log("Error",error);

        }
    });

}