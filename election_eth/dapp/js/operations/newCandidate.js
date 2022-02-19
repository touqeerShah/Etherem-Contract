async function  onSubmitForm(){
    var fname= $("#fname").val();
    var lname= $("#lname").val();
    var party= $("#partyname").val();
    var partySymbol= $("#partySymbol").val();
    var address= $("#address").val();
    console.log("fname",fname, "lname",myAccount[0]);

    await ecContract.methods.insertNewCandidate(fname,lname,party,partySymbol,address).send({from:myAccount[0],gasprice:web3.utils.toWei("4.1","gwei")}, (error, result) => {
        // console.log("onSubmite",result);

        if (result) {
            console.log("onSubmite",result);
            $("#result").text(result);
        }else{
            console.log("Error",error);
        }
    });

}