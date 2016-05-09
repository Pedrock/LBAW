{assign var="cur_level" value=$level}
{assign var="prev_id" value=$category_id}
{foreach from=$categories item=category}
		{assign var="n" value=25}
		{$color=-255/($n - 1)*$category.level + 255}
		<a href="#{$category.id}" class="list-group-item collapsed clearfix" data-toggle="collapse" id="cat_{$category.id}" data-id="{$category.id}" style="background-color: rgb({$color|round:0},{$color|round:0},{$color|round:0});">
			<span class="icon {if $category.numChilds eq 0}hidden{/if}"></span>
			<span class="categ_name">
				{$category.name}
				<span class="categ_num_child">{if $category.numChilds neq 0}{$category.numChilds} subcategories{/if}</span>
			</span>
			<span class="pull-right">
				<button class="href_add" data-toggle="modal" data-target="#add">
					<span class="hidden category_id">{$category.id}</span>
					<span class="glyphicon glyphicon-plus"></span>
				</button>
				<button class="href_edit" data-toggle="modal" data-target="#edit">
					<span class="hidden category_id">{$category.id}</span>
					<span class="hidden category_name">{$category.name}</span>
					<span class="hidden category_parent">{$category.parent}</span>
					<span class="glyphicon glyphicon-pencil"></span>
				</button>
				<button class="href_del" data-toggle="modal" data-target="#del">
					<span class="hidden category_id">{$category.id}</span>
					<span class="hidden category_name">{$category.name}</span>
					<span class="glyphicon glyphicon-trash"></span>
				</button>
			</span>
		</a>
{assign var="prev_id" value=$category.id}
{/foreach}
