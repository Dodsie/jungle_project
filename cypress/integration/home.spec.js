describe('Jungle Home Page Tests', () => {
  beforeEach(() => {
        cy.visit('localhost:3000')
  })


  xit("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("There is 12 products on the page", () => {
    cy.get(".products article").should("have.length", 12);
  });
})