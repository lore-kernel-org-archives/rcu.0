Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.194
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793952041;
	b=uFv0y9QGlzwdNwxV+4xSugWqN/+IG2E6/Q8aelUE6FyYc4b0wK89AuaJjyUPESJPGNwa
	 iA+hLJ09NQv7U+QydPWkd7Suk4JxPtBu9me/EZaEaQqIe+16UO7Z7MRthm+0z7ujbUUZW
	 5txGxg/S2iM7cL97w5aOI6SLoVpVHTbVUb3H78NrWZAoygR3phmWQqWcpSauHvWFEzHNl
	 5pNa+by6OYwb90r+5CWKc9N9IuUihsJnLrSLkvgGcSIgbEDF2ZonajbPP/p9jXPX5v/RX
	 vR4zaZPo1C/MIwsVtyzj6i0VFcUAz/8nP4DR/hMV9QbQUphN9lHlPBurgDPzx98ZCbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793952041;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=CSAmRJxA26lVa9d8ef5jJKzg0pl+9P3AFrDuUmlmVQM=;
	b=fZ48IM4i618sApaA+fPB8AMwWJL3p8ZvEPW9fsPUwRar90MlbmhzcYdVaiCIHJyqG6fg
	 mfoasp6YTyijSlqlf/U2Sl5LAYFOXJPBddQYOet285ETYnz9EQ8AAXkwWBJSzSta/RRVt
	 +nigFDpxD5Cfq6+FM6aShAXuJ2CPBkahX35IL/8l7YxgLoYDZXyERw3QM6S4uKllzWpO6
	 GwHRh6ydCZJepWp2EeggVKl8rox21lkuVK+9c5gbI2cDRgp6LEyQbeooosmt8BHLmmKsd
	 SUaHR7W2jdJasTRpLTLSorwxmIyIDblUBJ9FlQbrtcIPAycIMnU/fgStWJpHALkz0og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LGvYi3hL;
	arc=none smtp.remote-ip=91.218.175.194
Received: from mta0.migadu.com (out-194.mta0.migadu.com [91.218.175.194])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F5B606D81B
	for <rcu@vger.kernel.org>; Fri,  6 Nov 2026 08:00:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57F5B606D81B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LGvYi3hL
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=VW9Si2+KVl36tjewGW8VX2mt2qPP953x9tJRVdyvaNg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793952038; v=1; x=1794556838;
 b=LGvYi3hLOxsmHxvPgvYUsw4MpiOqhAN+N52L4SG7wkmr+5vonjfqNsyf757Zzt/7RyTGp9ap
 zgkFgZhB13sP21GFEICGj9K7w6VlmrLbz7VHv17xxR+hSRoiN77C9IBgZCQxb3YoHX/yniq/enK
 st4tK9a3Et1Lr0EihTqVJq78=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9a35c9af166ee30d;
	Fri, 06 Nov 2026 08:00:38 +0000
X-Mizu-Trace-ID: 9a35c9af166ee30d
X-Migadu-Flow: FLOW_OUT
Date: Fri, 6 Nov 2026 16:00:31 +0800
From: Hao Li <hao.li@linux.dev>
To: Harry Yoo <harry@kernel.org>
Cc: Zhan Xusheng <zhanxusheng1024@gmail.com>, vbabka@kernel.org, 
	urezki@gmail.com, paulmck@kernel.org, qiang.zhang@linux.dev, 
	akpm@linux-foundation.org, cl@gentwo.org, rientjes@google.com, roman.gushchin@linux.dev, 
	linux-mm@kvack.org, rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhanxusheng@xiaomi.com
Subject: Re: [PATCH 2/2] mm/slab: don't queue the page cache work under
 krcp->lock
Message-ID: <au2JBV_Y0DJVwVVD@fedora>
References: <20261028134647.3176080-1-zhanxusheng1024@gmail.com>
 <20261028134647.3176080-2-zhanxusheng1024@gmail.com>
 <auifTNDwbBTJeu81@thinkstation>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auifTNDwbBTJeu81@thinkstation>

On Mon, Nov 02, 2026 at 02:35:40PM +0000, Harry Yoo wrote:
> Here I added bit more context and adjusted comment. End result:
> 
> mm/slab: don't queue the page cache work under krcp->lock
> 
> Commit 56292e8609e3 ("rcu/tree: Defer kvfree_rcu() allocation to a
> clean context") deferred page allocations to a workqueue. To avoid
> deadlocks with the scheduler, it used hrtimer to queue the work instead
> of queueing it directly.
> 
> Commit d0bfa8b3c411 ("kvfree_rcu: Release a page cache under memory
> pressure") later added a backoff mechanism under memory pressure, but
> did not consider that queue_delayed_work() with delay = 0 immediately
> queues the work and introduced the deadlock commit 56292e8609e3 tried to
> avoid.
> 
> run_page_cache_worker() runs under krcp->lock, from kvfree_call_rcu()
> callers that may hold more, such as set_cpus_allowed_force() under
> pi_lock, so it kicks the refill work from an hrtimer. Under memory
> pressure it instead queues the work with a delay of
> rcutree.rcu_delay_page_cache_fill_msec, which may be 0, and a zero delay
> queues it at once, taking pool->lock under krcp->lock.
> 
> With the delay set to 0, calling kvfree_rcu() on vmalloc memory under
> pi_lock after a drop_caches makes lockdep report:
> 
>   Chain exists of:
>     &pool->lock --> &p->pi_lock --> krc.lock
> 
> Use the hrtimer when the delay is 0.
> 
> Fixes: d0bfa8b3c411 ("kvfree_rcu: Release a page cache under memory pressure")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
> Link: https://patch.msgid.link/20261028134647.3176080-2-zhanxusheng1024@gmail.com
> [ harry@kernel.org: add more context to changelog and adjust comment ]
> Signed-off-by: Harry Yoo (Meta) <harry@kernel.org>
> ---
>  mm/slab_common.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Hao Li <hao.li@linux.dev>

-- 
Thanks,
Hao
