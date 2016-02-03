--[[ 	Author: Hewdraw
		Date: 17.05.2015	]]

function MoonShardActive( keys )
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local modifier_as = keys.modifier_as
	local modifier_vision = keys.modifier_vision
	
	AddStacks(ability, caster, target, modifier_as, 1, true)
	ability:ApplyDataDrivenModifier(caster, target, modifier_vision, {})
	target:EmitSound("Item.MoonShard.Consume")
	caster:RemoveItem(ability)
end