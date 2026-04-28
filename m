Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C532475CB
	for <rcu@vger.kernel.org>; Tue, 28 Apr 2026 13:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777381933; cv=none; b=nkkdRcKUVGK9/kVy4y3mDgr8SU9hWxERI4RCTF8Nw/AhMy+oK//DlPGFXRg1p3650rraEUDgwDmKP1aaCuoXyn9lxgjq7/4ribcPN5oD6+Xb+i9ZaD/YvNt4uPWlEF29KpN0QUUzaSGYNlCA54SknmV9KFjQ8NiMCTFCQgEk19M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777381933; c=relaxed/simple;
	bh=uY0VmYi3Cia4jgbgasYSewRnyQIPG2VCw0HBtI3tMlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZlJi6zoR27jdKAhhJn85LrDHkI9GCDo2GQY5Th5UhBfcC/zbufnsfQjGoWqmqLr4gjnJbZ/x3OvFOdO4cyN42ox386oK/YN+SStqEKi5/eBaZvsjnt36Ij4nlPe+UMlFnStdqfZpaOYki3yKppHCwrDeZ25v0rxW3scMNXF4ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFp9yso8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFp9yso8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E11F7C2BCB7;
	Tue, 28 Apr 2026 13:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777381933;
	bh=uY0VmYi3Cia4jgbgasYSewRnyQIPG2VCw0HBtI3tMlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IFp9yso8BLkxrRD/pTw23VCq6WJRRGBFUs20CT5PW35GYCmnQlAm+da4pQNsWYMTu
	 wG60R6P8a/4NPr/5MWxl+7paFjSDOyLKwCWXpqNT7y39RcDji4OJILcnPzS5luCI8e
	 u35A013OVxxGgwCEJMPisAhSMjO44HY9JSXTw8yxKi7wtkx43l/Zq0lOHazX+iP++D
	 BdX8TL4WXby2ykUrZ5E485a4jd7f0dfU/Z0B3rQ/uU+PTLHg4wIrcgk7YnclpkULWQ
	 eBbovPR2Fx1aHgG072co7sp1RPmER9kYtDFDTYJgl2WeCzFI52/18WcrGWbIuhHsJk
	 kf1+Inf8EoRgg==
Date: Tue, 28 Apr 2026 22:12:06 +0900
From: "Harry Yoo (Oracle)" <harry@kernel.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hao Li <hao.li@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, Zqiang <qiang.zhang@linux.dev>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 4/8] mm/slab: introduce kfree_rcu_nolock()
Message-ID: <3s4jafam3la72a6y3dkfvhtzxk3fsngb2cka3bpfqrirl5m633@pz3vzizefoxb>
References: <20260416091022.36823-1-harry@kernel.org>
 <20260416091022.36823-5-harry@kernel.org>
 <aejeVK0J_jHSfVhD@milan>
 <aemevSofweaUSx0n@hyeyoo>
 <aeoD_Ts6hLsgNc9-@pc636>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeoD_Ts6hLsgNc9-@pc636>

Hi Ulad. Apologies for the delayed response.
I meant to reply sooner but sidetracked by other issues.

Your questions are fair, but let me try to clarify
the current situation.

And before diving into details, I would like to reiterate that
there are potentially two points to discuss here:

Point 1. Can we justify complicating subsystems by passing
	 `allow_spin` parameter all over the place?

Point 2. Can we avoid adding this complexity to kvfree_rcu() and
	 let slab handle it instead? (as mentioned in [4])

On Point 1: IMHO it could be justified, but at the same time I hope we
end up avoiding more complexity in the long term by working on Point 2.

This reply focuses only on Point 1 and explains why it could be
justified.

On Thu, Apr 23, 2026 at 01:35:25PM +0200, Uladzislau Rezki wrote:
> On Thu, Apr 23, 2026 at 01:23:25PM +0900, Harry Yoo (Oracle) wrote:
> > On Wed, Apr 22, 2026 at 04:42:28PM +0200, Uladzislau Rezki wrote:
> > How much performance do we sacrifice compared to
> > letting them go through the kvfree_rcu() fastpath?
>
> Freeing an object over RCU from
> NMI context is a corner case. It is __not_ generic.

First, I want to clarify that kfree_rcu_nolock() is not just for NMI
context. It is intended to be used when the context is unknown (because
it can be called in an arbitrary code locations).

There are two kinds of problematic situations where BPF programs
are attached to:

  - 1) a tracepoint or a function that can be invoked in a critical
       section (w/ a lock held), or

  - 2) a function that can be called in an NMI context, which might
       preempt an arbitrary context holding a lock.

While 1) and 2) are not (I think) dominant use cases, and although
most of users can legally call kvfree_rcu(), BPF can't use kvfree_rcu()
and must consider the most restrictive contexts.

> We even do not have(now
> in mainline) users because we never support it from NMI,
> just like call_rcu().

Unfortunately, we've had this use case (of allocating memory for BPF
programs) for a long time in the mainline. There are two current
approaches to mitigate the limitation:

  - 1) Pre-allocate all memory. e.g.) allocate all hash table elements
       when creating a BPF map, rather than allocating them on demand.
       This ensures correctness but sacrifices memory.

  - 2) Use the BPF-specific memory allocator [1] [2] to allocate memory
       on demand and avoid preallocation. While this wastes less memory
       than 1) and also maintains performance, it is re-inventing yet
       another memory allocator.

       Also, the allocator reinvented kfree_rcu batching as well.

Now, we're trying to avoid 1) and 2) as much as possible and use
kmalloc_nolock() instead [3].

> If BPF needs
> it, then the first question which comes to mind is not about performance.
> It is how to support this case in kfree_rcu() without adding noticeable
> complexity or overhead or hacks to the generic path without making it harder
> to maintain.

Since there will be only few subsystems that needs it, and because
they already use it on production systems, I don't see much value in
maintaining a simple implementation if that compromises performance
(and thus make the transition harder).

> Performance wise you noted, you mean:
> 
> a) call latency(this is probably the most important for NMI)?
> b) memory footprint?
> c) pointer-chasing overhead?

I think it's either

- The performance of kfree_rcu_nolock() itself (a), or
- Not distrubing workloads running on the machine (b and c)

depending on what people use BPF for.

[1] "A BPF-specific memory allocator", Jonathan Corbet, LWN.net, 2022.
    Link: https://lwn.net/Articles/899274 

[2] [LSF/MM/BPF TOPIC] Reentrant kmalloc usable from any context,
    Alexei Starovoitov, the linux-mm mailing list, 2025.
    Topic proposal: https://lore.kernel.org/linux-mm/CAADnVQ+=x31Rcjh6-qX1C+d2q0LBRCH=1gPqfKOaMXYx_fkQjw@mail.gmail.com
    Slides: https://github.com/4ast/docs/blob/main/Reentrant%20kmalloc.pdf 

[3] [GIT PULL] Introduce try_alloc_pages for 6.15, Alexei Starovoitov,
    the linux-mm mailing list, 2025.
    Link: https://lore.kernel.org/linux-mm/20250327145159.99799-1-alexei.starovoitov@gmail.com/

[4] https://lore.kernel.org/linux-mm/ael8R0vOeZ0Xbcoe@hyeyoo

After finishing this email, now I realize that I probably should have
elaborated the cover letter ;)

Hope this helps.

-- 
Cheers,
Harry / Hyeonggon
