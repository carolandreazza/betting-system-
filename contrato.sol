contract apostas{

    bool apostaDisponivel = true;
    string private resultadoAposta = "Flamengo";
    string pessoaApostaValor = "";

    address payable pessoaAposta;
    uint256 valueAposta;


    function deposit() public payable{} //se quiser depositar crypto nativa no contrato

    //deposita fundos e valo da aposta
    function setarApostaa(string memory aposta) public payable{
        pessoaApostaValor = aposta;
        valueAposta = msg.value;
        pessoaAposta = payable(msg.sender);
    }

    //chamada na blockchain
    function checkAposta() external view returns (string memory){
        if(apostaDisponivel){
            return resultadoAposta;
        }else{
            return "";
        }
    }


    function pegarRecompensa() public{
        if(keccak256(abi.encodePacked((resultadoAposta))) == keccak256(abi.encodePacked((pessoaApostaValor)))){
            //Ganhou
            bool sent = pessoaAposta.send(address(this).balance);//ta enviando pro apostador o valor que tem nesse contrato
            require(sent, "Failed to send Ether");
        }else{
            //perde
        }
    }


    // verifica se o jogado ganhou
    function checkResultado() external view returns (bool){
        if(keccak256(abi.encodePacked((resultadoAposta))) == keccak256(abi.encodePacked((pessoaApostaValor)))){
            return true;
        }else{
            return false;
        }
    }


}