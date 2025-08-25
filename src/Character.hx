class Character {
    var hp: Int;
    var instruction_length: Int;
    var instruction_pointer: Int;

    var instructions:List<Instruction>;
    var buffs: List<Buff>;


    public function reset_instruction_pointer():Void {
        instruction_pointer = 0;
    }
}