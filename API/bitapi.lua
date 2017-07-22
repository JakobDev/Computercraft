function toBits(num)
    local t={}
    for i=1,8 do
        t[i] = 0
    end
    local count = 0
    while num>0 do
        rest=math.fmod(num,2)
        t[#t-count]=rest
        num=(num-rest)/2
        count = count + 1
    end
    return t
end

function toNumber(values)
local max = 0
for index = 1,#values,1 do
   max = max + 2^(#values-index)*values[index]
end 
return max
end
