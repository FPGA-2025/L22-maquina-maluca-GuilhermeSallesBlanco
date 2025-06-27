`timescale 1ns/1ps

module tb();

reg clk;
reg rst_n;
reg start;
wire [3:0] state;

// Colocando estados para facilitar a leitura
    localparam IDLE                = 4'd1;
    localparam LIGAR_MAQUINA       = 4'd2;
    localparam VERIFICAR_AGUA      = 4'd3;
    localparam ENCHER_RESERVATORIO = 4'd4;
    localparam MOER_CAFE           = 4'd5;
    localparam COLOCAR_NO_FILTRO   = 4'd6;
    localparam PASSAR_AGITADOR     = 4'd7;
    localparam TAMPEAR             = 4'd8;
    localparam REALIZAR_EXTRACAO   = 4'd9;

maquina_maluca dut (
    .clk   (clk),
    .rst_n (rst_n),
    .start (start),
    .state (state),
    .agua_enchida (agua_enchida)
);

initial clk = 0;
always begin
    clk = 1'b0;
    #5;
    clk = 1'b1;
    #5;
end

integer i;

initial begin
    $dumpfile("saida.vcd");
    $dumpvars(0, tb);
    //$monitor("Start: %d", start);

    rst_n = 1'b0;
    start = 1'b0;
    #5;
    rst_n = 1'b1;
    start = 1'b1; // Inicia a máquina
    if(state == IDLE)
        $display("OK - Estado: IDLE");

    for(i = 0; i < 10; i = i + 1) begin
        @(posedge clk);
        #1;
        case(i)
            0: begin
                start = 1'b0;
                if(state == LIGAR_MAQUINA)
                    $display("OK - Estado: LIGAR_MAQUINA");
                else
                    $display("ERRO - Esperado LIGAR_MAQUINA, mas estado atual é %d", state);
            end
            1: begin
                if(state == VERIFICAR_AGUA) begin
                    $display("OK - Estado: VERIFICAR_AGUA");
                    if(!agua_enchida)
                        $display("Sem água!");
                    else
                        $display("Água disponível.");
                end else begin
                    $display("ERRO - Esperado VERIFICAR_AGUA, mas estado atual é %d", state);
                end
            end
            2: begin
                if(state == ENCHER_RESERVATORIO)
                    $display("OK - Estado: ENCHER_RESERVATORIO");
                else
                    $display("ERRO - Esperado ENCHER_RESERVATORIO, mas estado atual é %d", state);
            end
            3: begin
                if(state == VERIFICAR_AGUA) begin
                    $display("OK - Estado: VERIFICAR_AGUA");
                    if(!agua_enchida)
                        $display("Sem água!");
                    else
                        $display("Água disponível.");
                end else begin
                    $display("ERRO - Esperado VERIFICAR_AGUA, mas estado atual é %d", state);
                end
            end
            4: begin
                if(state == MOER_CAFE)
                    $display("OK - Estado: MOER_CAFE");
                else
                    $display("ERRO - Esperado MOER_CAFE, mas estado atual é %d", state);
            end
            5: begin
                if(state == COLOCAR_NO_FILTRO)
                    $display("OK - Estado: COLOCAR_NO_FILTRO");
                else
                    $display("ERRO - Esperado COLOCAR_NO_FILTRO, mas estado atual é %d", state);
            end
            6: begin
                if(state == PASSAR_AGITADOR)
                    $display("OK - Estado: PASSAR_AGITADOR");
                else
                    $display("ERRO - Esperado PASSAR_AGITADOR, mas estado atual é %d", state);
            end
            7: begin
                if(state == TAMPEAR)
                    $display("OK - Estado: TAMPEAR");
                else
                    $display("ERRO - Esperado TAMPEAR, mas estado atual é %d", state);
            end
            8: begin
                if(state == REALIZAR_EXTRACAO)
                    $display("OK - Estado: REALIZAR_EXTRACAO");
                else
                    $display("ERRO - Esperado REALIZAR_EXTRACAO, mas estado atual é %d", state);
            end
            9: begin
                if(state == IDLE)
                    $display("OK - Estado: IDLE. Processo concluído.");
                else
                    $display("ERRO - Esperado IDLE, mas estado atual é %d", state);
            end
        endcase
    end
    $finish;
end

endmodule
