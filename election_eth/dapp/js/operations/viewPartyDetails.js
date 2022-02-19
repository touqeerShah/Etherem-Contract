async function  getPartyDetails(){

    var params = new URLSearchParams(location.search);
    partyName= params.get("partiyname");
    // console.log("candidateContract",partyName,"candidateContract",candidateContract);
    await candidateContract.methods.getCandidateByPartyName(partyName).call( (error, result) => {
        if (result) {
            console.log("parties list",result);
            $("#fname").val(result[0]);
            $("#lname").val(result[1]);
            $("#partyname").val(result[2]);
            $("#partySymbol").val(result[3]);
            $("#address").val(result[4]);

            getImage(result[3])            
        }else{
            console.log("Error",error);

        }
    });

}
 function onLoad(){
    getPartyDetails();
 }


 async function getImage(cid){
console.log("CID",cid);
    for await( const file of ipfs.get(cid)){
        console.log(file);
        const content=[]
        for await(const chunk of file.content){
            content.push(chunk);
        }
        document.getElementById('myImage').src= URL.createObjectURL(
            new Blob(content,{type:'image/jpeg'})
        );
    }
 }