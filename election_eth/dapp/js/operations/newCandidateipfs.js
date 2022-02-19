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

function onIPFSAdd(event){
    ret = confirm("Are you Sure you want to upload");
    event.stopPropagation();
    event.preventDefault();
    saveToIPFS(event.target.files)
}

function saveToIPFS(files){

    ipfs.add([...files],{progress:(prog)=>console.log("prog  ",prog)}).
    then((res)=>{
      $("#partySymbol").val(res.path);  
    }).catch((err)=>{
        console.log(err);
    })


}