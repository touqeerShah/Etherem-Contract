async function  onSubmitForm(){

    var nic= $("#nic").val();

    var party= $("#partiesName").val();
    console.log("fname",party, "lname",myAccount[0]);

    await voterContract.methods.insertVoteByPartyName(nic,party).send({from:myAccount[0],gasprice:web3.utils.toWei("4.1","gwei")}, (error, result) => {
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
            $("#ethAccount").val(myAccount[0]);

        }else{
            console.log("Error",error);

        }
    });

}
 function onLoad(){
    getAllPartyName();
 }
