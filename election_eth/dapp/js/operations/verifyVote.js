

async function  verify(){

    var party= $("#partiesName").val();
    console.log("fname",party, "lname",myAccount[0]);

    await voterContract.methods.verifyVote(party).call( (error, result) => {
        // console.log("onSubmite",result);

        if (result) {
            console.log("onSubmite",result);
            $("#result").text(result);
        }else{
            console.log("Error",error);
        }
    });
}

async function  getAllPartyName(){

    await candidateContract.methods.getAllCandidatePartName().call( (error, result) => {
        if (result) {
            result.forEach(element => {
                $("#partiesName").append("<option value="+element+">"+element+"</option>")
            });

        }else{
            console.log("Error",error);

        }
    });

}
 function onLoad(){
    getAllPartyName();
 }
