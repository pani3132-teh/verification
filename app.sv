module apb(pclk, prstn, paddr, psel0, penable, pwrite, pwdata, pstrobe, prdata, pready, pslaverr);
  input pclk, prstn;
  input [31:0] paddr;
  input [31:0] pwdata;
  input psel0, penable, pwrite;
  input [3:0] pstrobe;
  output reg [31:0] prdata;
  output reg pready;
  output reg pslaverr;

  // memory block
  reg [7:0] mem [0:999]; 

  always @(posedge pclk) begin
    if (prstn == 0) begin
      pready = 0;
      prdata = 0;
      pslaverr = 0;
    end else begin
      if (psel0 == 1) begin
        pready = 1;
        if (penable == 1) begin
          if (paddr % 4 == 0) begin
            if (pwrite == 1) begin
              mem[paddr]   = (pstrobe[0]) ? pwdata[7:0]   : 8'b0;
              mem[paddr+1] = (pstrobe[1]) ? pwdata[15:8]  : 8'b0;
              mem[paddr+2] = (pstrobe[2]) ? pwdata[23:16] : 8'b0;
              mem[paddr+3] = (pstrobe[3]) ? pwdata[31:24] : 8'b0;
            end else begin
              prdata = {mem[paddr+3], mem[paddr+2], mem[paddr+1], mem[paddr]};
            end
          end else begin
            pslaverr = 1;
          end
        end
      end
    end
  end
endmodule

// ===========================
// TEST BENCH
// ===========================
module top;
  bit pclk;
  apb_interface pif(pclk);

  gen g = new();
  bfm b = new();

  initial begin
    pclk = 0;
    forever #5 pclk = ~pclk;
  end

  apb dut(
    .pclk(pif.pclk),
    .prstn(pif.prstn),
    .paddr(pif.paddr),
    .psel0(pif.psel0),
    .penable(pif.penable),
    .pwrite(pif.pwrite),
    .pstrobe(pif.pstrobe),
    .pwdata(pif.pwdata),
    .prdata(pif.prdata),
    .pready(pif.pready),
    .pslaverr(pif.pslaverr)
  );

  initial begin
    com::vif = pif;
    repeat (10) begin
      g.gen_task();
      b.bfm_task();
      @(posedge pif.pclk);
    end
    #100 $finish;
  end
endmodule




