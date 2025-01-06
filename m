Received: from invmail3.skhynix.com (exvmail3.skhynix.com [166.125.252.90])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B182FC52;
	Mon,  6 Jan 2025 07:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736148977; cv=none; b=AVGwrwYKTRK94JiGUKlw8ziaOt4Jm6Cx9qdctni/S10ik92pqipOO3RE/DLJmisHM6CcZDiina9RaYc2ll3Teqm812ZNSroFCSTbzf9TNG+j2W+y1g6qOfGmw8kZgD3nVGeAAIEZvywluXKTMDMFAKDYfBAUvDTINa629LjcA8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736148977; c=relaxed/simple;
	bh=Jfn7Eu/yK6trgfIGGAQuYjQmi5oYpmx4+wLY7t7bH6A=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=t53i/CdM27H/7t2+i5iPIemiaYiE6A7AhASzw4Dv1u4S63aVpYhr4o0QhzJafsNOv6SySYM0FAP4RYCb8j9rYfv1LW5f03cqXA5FR8qNwIOP0XD9q3+EA7DMBMdVU2i/k3CEHwpmUilfV3hyp0jD684iQOXJUxtSWU/bFGjQ59k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc59-7a9ff700000194b3-c3-677b845f600d
Message-ID: <9ceb805c-4b42-4517-93cf-6b3cd3cdce5f@sk.com>
Date: Mon, 6 Jan 2025 16:21:02 +0900
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: kernel_team@skhynix.com, 42.hyeyoo@gmail.com, RCU <rcu@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [External Mail] [PATCH v2 0/5] Move kvfree_rcu() into SLAB (v2)
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "Paul E . McKenney" <paulmck@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>
References: <20241212180208.274813-1-urezki@gmail.com>
Content-Language: en-US
From: Hyeonggon Yoo <hyeonggon.yoo@sk.com>
In-Reply-To: <20241212180208.274813-1-urezki@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDIsWRmVeSWpSXmKPExsXC9ZZnoW58S3W6wYNbnBYTewws5qxfw2Zx
	/dsbRouV3c1sFpd3zWGzuLfmP6tFz/Iai09LvrFYtH3+x2pxdvY5Vou2JRuZLCauEbVYfZHF
	YnZjH6MDn8fOWXfZPRZsKvXYtKqTzWPTp0nsHl1vrzB5nJjxm8XjyZXpTB4LG6Yye7RP2Mns
	cWbBEXaPz5vkArijuGxSUnMyy1KL9O0SuDJu73zBWPCYs+L2h6IGxvvsXYwcHBICJhJPl+Z1
	MXKCmXPnnGMGsXkFLCW+fbjEBFLCIqAi8XEvI0RYUOLkzCcsILaogLzE/VszgKZwcTALvGKS
	WHJ1IxNIQljAR+Ll3xdgCRGBG4wSFzZfYgdJCAmYSXw8+Rism1lAXOLWk/lgC9gEtCR2dKaC
	hDkFzCVm3N/MDlFiJtG1tYsRwpaX2P52DjPITAmByewSB88+ZYc4WlLi4IobLBMYBWchOXAW
	khWzkMyahWTWAkaWVYwimXlluYmZOcZ6xdkZlXmZFXrJ+bmbGIFxuKz2T+QOxm8Xgg8xCnAw
	KvHwFsyrShdiTSwrrsw9xCjBwawkwpulUZkuxJuSWFmVWpQfX1Sak1p8iFGag0VJnNfoW3mK
	kEB6YklqdmpqQWoRTJaJg1OqgXHZow+XHXb57K8VyFPyvT3noKzw3RpP15ViIZJrXwruPsez
	VqGK9fj56Z1+Ty5ZOimuddstcuS7mJjgtExxhWvl1/trClZLb3avvLJsbuSRd9rbvddsDt29
	16P5Z7pTiMgpi81Mv2J2fQu6tqAuduOv0nNXdOatjm+wKJ9TekBSNLeFQzZ38UolluKMREMt
	5qLiRAA/7REUvwIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsXCNUOnRDeupTrd4MkmQ4uJPQYWc9avYbO4
	/u0No8XK7mY2i8NzT7JaXN41h83i3pr/rBY9y2ssPi35xmLR9vkfq8XZ2edYLdqWbGSymLhG
	1GL1RRaL2Y19jA78Hjtn3WX3WLCp1GPTqk42j02fJrF7dL29wuRxYsZvFo8nV6YzeSxsmMrs
	sfjFByaP9gk7mT3OLDjC7vF5k1wATxSXTUpqTmZZapG+XQJXxu2dLxgLHnNW3P5Q1MB4n72L
	kZNDQsBEYu6cc8wgNq+ApcS3D5eYuhg5OFgEVCQ+7mWECAtKnJz5hAXEFhWQl7h/awZQKxcH
	s8ArJoklVzcygSSEBXwkXv59AZYQEbjBKHFh8yWwBUICZhIfTz4G62YWEJe49WQ+2AI2AS2J
	HZ2pIGFOAXOJGfc3s0OUmEl0be1ihLDlJba/ncM8gZFvFpI7ZiGZNAtJyywkLQsYWVYximTm
	leUmZuaY6RVnZ1TmZVboJefnbmIExtSy2j+TdjB+u+x+iFGAg1GJh7dgXlW6EGtiWXFl7iFG
	CQ5mJRHeLI3KdCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8XuGpCUIC6YklqdmpqQWpRTBZJg5O
	qQZGyw1Zm+beVqgoV3ITnvY08OTvWMFuyyNBN1KmCc3afnx30yGvJ1UOvyZ87W59v78t9ffh
	NcnZf72zHBXy+KddN7nLbfAsJPVxpeOdp0vnT+HyUbK6U7pbZmHk5MoVizpiXPjMF26KK7tp
	esne6fjdr2+Ejy3XyPkSvqJnkfHe/y3m/p+X7j/PpsRSnJFoqMVcVJwIAECNKbKlAgAA
X-CFilter-Loop: Reflected



On 2024-12-13 3:02 AM, Uladzislau Rezki (Sony) wrote:
> Hello!
> 
> This is v2. It is based on the Linux 6.13-rc2. The first version is
> here:
> 
> https://lore.kernel.org/linux-mm/20241210164035.3391747-4-urezki@gmail.com/T/
> 
> The difference between v1 and v2 is that, the preparation process is
> done in original place instead and after that there is one final move.
> 
> Uladzislau Rezki (Sony) (5):
>    rcu/kvfree: Initialize kvfree_rcu() separately
>    rcu/kvfree: Move some functions under CONFIG_TINY_RCU
>    rcu/kvfree: Adjust names passed into trace functions
>    rcu/kvfree: Adjust a shrinker name
>    mm/slab: Move kvfree_rcu() into SLAB
> 
>   include/linux/slab.h |   1 +
>   init/main.c          |   1 +
>   kernel/rcu/tree.c    | 876 ------------------------------------------
>   mm/slab_common.c     | 880 +++++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 882 insertions(+), 876 deletions(-)

Sorry for the late reply, but better late than never...

FWIW,

Acked-by: Hyeonggon Yoo <hyeonggon.yoo@sk.com>
Tested-by: Hyeonggon Yoo <hyeonggon.yoo@sk.com>

Thanks for all the efforts!

By the way, any future plans how to take advantage of internal slab
state?

--
Hyeonggon
