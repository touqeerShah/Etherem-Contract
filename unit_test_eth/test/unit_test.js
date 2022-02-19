 var studentContract = artifacts.require("Student");

 contract("Student",async (accounts)=>{

    it("the test deafult values",()=>{
        return studentContract.deployed().then(instance=>{
            return instance.getStudent.call().then(function(jsonData){
                // console.log(jsonData);
                assert.equal(jsonData._name,"Ali","this name was not some as it was set in constractor");
                assert.equal(jsonData._age,17,"this age was not some as it was set in constractor");
                assert.equal(jsonData._isStudent,true,"this isStudent was not some as it was set in constractor");
            });
        })
    }),
    it("the test set values",()=>{
        return studentContract.deployed().then(instance=>{
            return instance.setStudent("touqeer",27,false,{from:accounts[0]}).then(function(){
                return instance.getStudent.call().then(function(jsonData){
                    // console.log(jsonData);
                    assert.equal(jsonData._name,"touqeer","this name was not some as it was set in constractor");
                    assert.equal(jsonData._age,27,"this age was not some as it was set in constractor");
                    assert.equal(jsonData._isStudent,false,"this isStudent was not some as it was set in constractor");
                });
            });
        })
    }), it("the test async values", async()=>{
        var instance= await studentContract.deployed();
        var jsonData = await instance.getStudent.call();
        // console.log(jsonData);
        assert.equal(jsonData._name,"touqeer","this name was not some as it was set in constractor");
        assert.equal(jsonData._age,27,"this age was not some as it was set in constractor");
        assert.equal(jsonData._isStudent,false,"this isStudent was not some as it was set in constractor");    
    }), it("the test only owner will check is complete values", async()=>{
        var instance= await studentContract.deployed();
        var jsonData;
        var check= false;
        try {
            jsonData = await instance.getCompleted.call({from:accounts[0]});
            
        } catch (error) {
            console.log(error);
            check = true;
        }
        assert.equal(check,true,"Only Admin will allow to access the methode");

    })

 });