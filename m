Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E441CEE9A
	for <rcu@vger.kernel.org>; Thu, 23 Jan 2025 20:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737664004; cv=none; b=idC+VtuK5m98+SW+/+f24hNwrq2zsAQkE5n47w8Va8jEcviyL/esqwaIf4nx05by0eDRTWZo6oic/UogpS5ydUzIfw/1sVinORHmK6AD+fRmstjDEn5IMUpqin18kAHwdI1+iAZ1+bxcphPeewCafFlQUIR94+DoZl70871bKPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737664004; c=relaxed/simple;
	bh=oL6NQEdTtjZ/hVogsbi/d3v+aVJuZPXEZ3JA2IGtK2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzENeCaZCN420cNfQFsSXxAbjgZk5vzYm9Axr/rDR8tgrHuGp0NipXfQZhbBne0carIbaSM7TWhbR4k5m7iLPKfoQ+rqr2ZhkZpi0ElJuJuKOSAJVRBmg6FSoCbMgutM6PT0Zn2LadaBIKdPrFGZQx6ixg4BTHM8DX0/eccTa+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BM8Ylsvk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BM8Ylsvk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D11C4CED3;
	Thu, 23 Jan 2025 20:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737664003;
	bh=oL6NQEdTtjZ/hVogsbi/d3v+aVJuZPXEZ3JA2IGtK2Q=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=BM8YlsvkAFY8VL7voqRF0HNeVo9V69AEiIMAWUBLSsnhKFaurUaZZwm6zOxDAZfNI
	 NKu0EVm2k72iaubF2R3OYCWlaBtx3yc6ErS5rPt5jgGYT6VcjUWJeNBPeQ4n7py1X2
	 0fDiY1RHdGLszuEZ3XdUzEuPQgd8EHSpzPkEMZGdov5qn7GTDshOXUsV6URd1dTiaG
	 V3jVODaj8/5FneHqGYWtX/7qi4BxHokuQzQ3QtLCJuRE3FU/dF8XLHbB61Vm4TxpBB
	 4zYnE337xa0w1nO8REOJkMePQT3Rnx2evMKXTcVy44wU2yVRnymllXiH/Fc8Mnl6n0
	 sT9XgqAnOwZXg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 93DDBCE0DC7; Thu, 23 Jan 2025 12:26:43 -0800 (PST)
Date: Thu, 23 Jan 2025 12:26:43 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH RFC 0/4] slab, rcu: move and consolidate TINY_RCU
 kvfree_rcu() to SLAB
Message-ID: <647c4404-283c-4a98-aaf4-d3f0b44dee7d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250123-slub-tiny-kfree_rcu-v1-0-0e386ef1541a@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123-slub-tiny-kfree_rcu-v1-0-0e386ef1541a@suse.cz>

On Thu, Jan 23, 2025 at 11:37:17AM +0100, Vlastimil Babka wrote:
> Following the move of the TREE_RCU batching kvfree_rcu() implementation
> to slab, we still have the simple non-batching implementation in tiny
> RCU, and RCU implementation specific ifdefs in slab code.
> 
> Finish the move and integration into slab. Allow using the simple
> call_rcu() based implementation also with tree RCU when SLUB_TINY is
> enabled, as its goal is also to limit memory footprint with less concern
> for top performance.
> 
> In order to avoid RCU having to recognize the fake callback function
> pointers (__is_kvfree_rcu_offset()) when handling call_rcu(), implement
> a callback that can calculate the object's address from the embedded
> rcu_head pointer without knowing the specific offset (previously SLOB
> would not have made it possible, but it's gone now).
> 
> After this series, AFAIK only the following kvfree_rcu specific code
> remains in RCU:
> 
> - a call to kfree_rcu_scheduler_running() from rcu_set_runtime_mode()
> 
>   - probably necessary and a generic registration interface would be
>     unnecessary bloat?
> 
> - declarations of kfree_rcu() API in include/linux/rcupdate.h
> 
>   - could be moved to slab.h after checking for/fixing up potential
>     missing includes
> 
> git tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=b4/slub-tiny-kfree_rcu
> 
> To: Christoph Lameter <cl@linux.com>
> To: David Rientjes <rientjes@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Cc: linux-mm@kvack.org
> To: "Paul E. McKenney" <paulmck@kernel.org>
> To: Joel Fernandes <joel@joelfernandes.org>
> To: Josh Triplett <josh@joshtriplett.org>
> To: Boqun Feng <boqun.feng@gmail.com>
> To: Uladzislau Rezki <urezki@gmail.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Zqiang <qiang.zhang1211@gmail.com>
> Cc: rcu@vger.kernel.org
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Tested-by: Paul E. McKenney <paulmck@kernel.org>

> ---
> Vlastimil Babka (4):
>       slab, rcu: move TINY_RCU variant of kvfree_rcu() to SLAB
>       rcu: remove trace_rcu_kvfree_callback
>       rcu, slab: use a regular callback function for kvfree_rcu
>       slab: don't batch kvfree_rcu() with SLUB_TINY
> 
>  include/linux/rcupdate.h   | 29 ++++++++++++++---------------
>  include/linux/rcutiny.h    | 36 ------------------------------------
>  include/linux/rcutree.h    |  3 ---
>  include/linux/slab.h       | 14 ++++++++++++++
>  include/trace/events/rcu.h | 34 ----------------------------------
>  kernel/rcu/tiny.c          | 24 ------------------------
>  kernel/rcu/tree.c          |  9 ++-------
>  mm/Kconfig                 |  4 ++++
>  mm/slab.h                  |  2 ++
>  mm/slab_common.c           | 32 +++++++++++++++++++++++++-------
>  mm/slub.c                  | 42 ++++++++++++++++++++++++++++++++++++++++++
>  11 files changed, 103 insertions(+), 126 deletions(-)
> ---
> base-commit: e492fac3657b60b8dd78a6e8ca26d1d14706c7b3
> change-id: 20250123-slub-tiny-kfree_rcu-bd65bfe222f2
> 
> Best regards,
> -- 
> Vlastimil Babka <vbabka@suse.cz>
> 
