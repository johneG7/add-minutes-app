require "add_minutes"
require 'byebug'
describe AddMinutes do 
 
    describe "hours_mins_to_add" do
        context "given a negative minutes value" do
            it "provides correct hours and minutes to subtract" do 
                a = AddMinutes.new
                expect(a.hours_mins_to_add(-100)).to eq([-1,-40])
                expect(a.hours_mins_to_add(-59)).to eq([0,-59])
                expect(a.hours_mins_to_add(-22)).to eq([0,-22])
                expect(a.hours_mins_to_add(-103)).to eq([-1,-43])
            end
        end
        context "given a positive minutes value" do
            it "provides correct hours and minutes to subtract" do 
                a = AddMinutes.new
                expect(a.hours_mins_to_add(100)).to eq([1,40])
                expect(a.hours_mins_to_add(59)).to eq([0,59])
                expect(a.hours_mins_to_add(22)).to eq([0,22])
                expect(a.hours_mins_to_add(103)).to eq([1,43])
            end
        end
    end #hours_mins_to_add

    describe "calculate_new_time" do
        context "adding time that does NOT cause an am/pm switch" do
            it "provides the correct am/pm flag and time" do
                a = AddMinutes.new
                new_time = a.calculate_new_time([9,13],[1,13],"PM")
                expect(new_time).to eq([10,26,"PM"])
            end
            context "AND adding minutes that will increase the hour" do
                it "provides the correct am/pm flag and time" do
                    a = AddMinutes.new
                    new_time = a.calculate_new_time([9,13],[0,47],"PM")
                    expect(new_time).to eq([10,0,"PM"])
                end
            end
            context "AND subtracting minutes that will decrease the hour" do
                it "provides the correct am/pm flag and time" do
                    a = AddMinutes.new
                    new_time = a.calculate_new_time([9,13],[0,-14],"PM")
                    expect(new_time).to eq([8,59,"PM"])
                end
            end
        end

        context "adding time that causes an am/pm switch" do
            context "AND adding minutes that will increase the hour" do
                it "provides the correct am/pm flag and time" do
                    a = AddMinutes.new
                    new_time = a.calculate_new_time([11,13],[0,47],"PM")
                    expect(new_time).to eq([12,0,"AM"])
                end
            end
            context "AND subtracting minutes that will decrease the hour" do
                context "going from am to pm" do
                    it "provides the correct am/pm flag and time" do
                        a = AddMinutes.new
                        new_time = a.calculate_new_time([12,13],[0,-14],"AM")
                        expect(new_time).to eq([11,59,"PM"])
                    end
                end
                context "going from pm to am" do
                    it "provides the correct am/pm flag and time" do
                        a = AddMinutes.new
                        new_time = a.calculate_new_time([12,13],[0,-14],"PM")
                        expect(new_time).to eq([11,59,"AM"])
                    end
                end
            end
        end
    end #calculate_new_time

    describe "add_minutes" do
        context "given a negative minutes value" do
            it "provides correct time string" do 
                a = AddMinutes.new
                expect(a.add_minutes("9:13 PM",-10)).to eq("9:03 PM")
            end
            context "AND causes an am/pm change" do
                it "provides correct time string going from PM to AM" do 
                    a = AddMinutes.new
                    expect(a.add_minutes("9:13 PM",-600)).to eq("11:13 AM")
                end
                it "provides correct time string going from AM to PM" do 
                    a = AddMinutes.new
                    expect(a.add_minutes("1:13 AM",-180)).to eq("10:13 PM")
                end
            end
        end
        context "given a positive minutes value" do
            it "provides correct time string" do 
                a = AddMinutes.new
                expect(a.add_minutes("9:13 PM",10)).to eq("9:23 PM")
            end
            context "AND causes an am/pm change" do
                it "provides correct time string going from AM to PM" do 
                    a = AddMinutes.new
                    expect(a.add_minutes("1:13 AM",180)).to eq("4:13 AM")
                end
                it "provides correct time string going from PM to AM" do 
                    a = AddMinutes.new
                    expect(a.add_minutes("11:13 PM",600)).to eq("9:13 AM")
                end
            end
        end
    end #hours_mins_to_add

end