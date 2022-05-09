
import React from 'react';
//Setup Drizzle Instance
import {
    AccountData,
    ContractData,
    ContractForm,
    LoadingContainer
  } from "@drizzle/react-components";
function hp1() {
    return (
        <LoadingContainer>
            <div>
                <h2>Balance of first account</h2>
                <AccountData accountIndex={0} uints={"ether"} precision={3} />
            </div>
        </LoadingContainer>
    );
}
export default hp1;