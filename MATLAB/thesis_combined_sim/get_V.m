
function V_arr = get_V(x1,x2)
    global  V;
    V_arr = [];
    for i = 1:length(x1)
        x = [x1(i); x2(i)];
        V_arr = [V_arr V(x)];
    end
end