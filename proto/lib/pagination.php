<?php

function pagination($products,$limit,$page, $total)
{
	if ($products !== false)
	{
		$product_count = isset($total) ? $total : ($products[0]['total_count']);
		$n_pages = ($product_count - $product_count % $limit) / $limit + ($product_count % $limit > 0);
	}
	else
		$n_pages = 0;

	$startpage = max(1,$page-2);
	$endpage = min($n_pages,$page+2);

	$dif = $endpage - $startpage;

	if ($dif < 4)
	{
		if ($startpage > 1)
			$startpage -= min($startpage-1,4-$dif);
		else if ($endpage < $n_pages)
			$endpage += min($n_pages-$endpage,4-$dif);
	}

	return array('n_pages' => $n_pages,'startpage' => $startpage,'endpage' => $endpage);
}