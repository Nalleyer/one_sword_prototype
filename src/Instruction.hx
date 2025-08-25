// 一个指令
class Instruction {
    // 每个指令有基础类型
    var type: InstructionType;
}

enum InstructionType {
    Attack;
    Defend;
    Heal;
}