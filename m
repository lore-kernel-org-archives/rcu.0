Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795428003;
	b=UuPXXFNL7oaFH5O9g6HaxdyDiDd3WUhjxp4x5hcWLSJiWyMJ/RwXnZc8GS+je3VsBCTv
	 EwwqNfFeTgCrtnPZ8KswAwvSgcyTyb6G5lUZyV69GBDG3mAA9TQwLM96bA3ZLwBViCNC4
	 YodVI9eHD2hiiPzwPHn9j2609lX44+auZWMy6Mnakv+vUciurRRVnL2GpnMQFnpmr/XHZ
	 e3FcjGCv3Ms4r0GdBdsnghXGMmwpqXMjVPj/zReOdnMV75dRoQK8VHxOBJeZs8TOYTgYc
	 3xJDUNQDNxGkVLwpFpQeW6qyV73igcIFwgdw1h72OiiVsNP/R31NNhdjyejDSvOmF/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795428003;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=39LszgQ+Vutu5fHaIM6am63oa2TAWVo+AWYFNIzHedw=;
	b=rVfTKGahG+GhIcrMEQ+uiM4CwN7t9arnfR6fy1MXwrGrU203XVtD6ozKbu/Q+TqZs96r
	 4gy9PAVVRg44LlGOecPk2oHzFWIuQCQglK4HMLYnL+98mmKVtDXJCx67CkoYsDzCBUo1p
	 ATKyNG4U3D3E8rNawRTVLND23lv85Ffg2uXUUcBFUWj9l1mnV9U0W1Fk4eRb0ji/T0q18
	 Ptp4j6yLgMDb7ob8ujxBg2yIMKd8+FO55HMjNdq+HWcDc4KCEWYrxO5ytoLcVwuaw+iiI
	 iwFEi9A5QbD5Q8HGv/EKi+U52k4ENM9gSRaF3tYLn/a+gV0NSLGomtlhgXxQZDnjdEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=PuGXFBsW;
	arc=none smtp.remote-ip=115.124.30.133
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B93606A321;
	Mon, 23 Nov 2026 10:00:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4B93606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=PuGXFBsW
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795427999; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=39LszgQ+Vutu5fHaIM6am63oa2TAWVo+AWYFNIzHedw=;
	b=PuGXFBsW6fHwUVGc4moYEZaLaLwSNpwqEMM189oO7AEaybaG04i32ACpji+DAYtyZphnXzrq1+mZEHnD9dYJz5MGUU44uV962biB7/jFwlFRI9XgsgfIrFl9qaxN1evTsszTWPNBFRpoj6ZlLNqV6VjTjBqEd0s+Cin9Ob4lqjY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0XFHJ3WU_1795427995;
Received: from 30.74.144.153(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XFHJ3WU_1795427995 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 23 Nov 2026 17:59:57 +0800
Message-ID: <92bc11db-ef40-48e3-8768-9af36bfb5a7e@linux.alibaba.com>
Date: Mon, 23 Nov 2026 17:59:54 +0800
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] mm/mglru: cache the last memcg node, make tail
 insertion constant time
To: Max Kellermann <max.kellermann@ionos.com>, akpm@linux-foundation.org,
 kasong@tencent.com, qi.zheng@linux.dev, shakeel.butt@linux.dev,
 baohua@kernel.org, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, baoquan.he@linux.dev, david@kernel.org, ljs@kernel.org,
 liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, hannes@cmpxchg.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org
References: <20261116081403.216452-1-max.kellermann@ionos.com>
 <20261116081403.216452-4-max.kellermann@ionos.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20261116081403.216452-4-max.kellermann@ionos.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/16/26 4:14 PM, Max Kellermann wrote:
> Rotating or onlining a memcg currently uses hlist_nulls_add_tail_rcu()
> which walks the destination bin to find its tail while holding
> `memcg_lru.lock` with interrupts disabled.  With thousands of cgroups,
> this takes a long time and causes severe lock contention.
> 
> Cache a pointer to each bin's last node, making tail insertion O(1).
> This requires remembering the bin number (but the new struct field
> occupies a hole, so it does not grow).
> 
> In a micro benchmark that creates 1500 cgroups and repeatedly writes
> `1024M swappiness=0` to `memory.reclaim` in 8 threads, the request
> rate increases by a factor of 9.5 and the average duration of each
> write request is reduced by 89%.
> 
> All writes return EAGAIN in both runs; the benchmark measures the cost
> of reclaim attempts that cannot meet their requested target, not
> reclaimed throughput.
> 
> Fixes: e4dde56cd208 ("mm: multi-gen LRU: per-node lru_gen_folio lists")

I don't think this fixes anything, right?

> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---

Thanks. We hit the same issue in our stress tests and confirmed that 
this optimization works.

Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
