const Tickets = artifacts.require("Tickets");
const assert = require('assert');


contract('Tickets', (accounts) => {
    const BUYER = accounts[1];
    const TICKET_ID = 0;

    it('should allower a user to buy a ticket', async () => {
        const instance = await Tickets.deployed();
        const originalTicket = await instance.tickets(TICKET_ID);
        await instance.buyTickets(TICKET_ID, { from: BUYER, value: originalTicket.price });
        const updatedTicket = await instance.tickets(TICKET_ID);
        assert.equal(updatedTicket.owner, BUYER, 'the buyer should be the owner of the ticket');
    })
});