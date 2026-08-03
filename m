Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F702D7398;
	Mon,  3 Aug 2026 07:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785741575; cv=none; b=WGrnVgax3v0aQF/67bKm2H3Bt2cGkavniMVmwF1pmy1N13kYZ9LJWK9Qji4PgnC7yznPcIxXlv1/CQoSdZWs/o9UrNUnJrxDAmrypxvjXPE2ixlJS8/pkozboW24kqzdyq+B/H3yre/XJhjbSMQZn6e8eWauk4qQDSTJl41B6l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785741575; c=relaxed/simple;
	bh=mVg1gkAE/IwYQ+cm6zbvqlDMO6ttXZbvtuQjV+aXoJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKaZhSHAgsRjk2w6hBAtivLXMXdQWKqOaqoIe0MSOR3al6E+NZ9u//ew9/02sXiUh9FadyI7cXi0asarF06X2HiG8RexB1wXue0dzI8U37NNGBJZvjbV9Al+ZNTviGHWbcFMlJMu7bMsCiEKe413mTRHxNKNYYrm/jHMsT73d+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lzaAoMly; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzaAoMly"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDEC11F000E9;
	Mon,  3 Aug 2026 07:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785741574;
	bh=ykiHD7DY9G7XaqnDrtXQxXTCaNG81ozB7o0StBvDD0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lzaAoMlymuF4kOmQnImnMrd2VoWNnAasbFn4o2tBj12KoFhxjSN8hLToPrUhEiPO3
	 oEu01foRUuD96Mip7GJ/acAD9l5u9VkO4iDzOrj9beBTGIyLAiEW/He4sdcfIWR3n7
	 RoN9b4qjdAuINP2QHcnwf5x1HZN43ZdyVyrsWPcMNbDbNFueIBK0loDZwVDtJPb2SE
	 rcklEDK89DM7Xmy1+ytTbF5YZCEtiis0hg+Kv8tXcbAnKEat5wDNORC+GyfsWBPVwO
	 T0B5vGq7AyGeM/xz3vlVg9E4xxxTYVvJpOLWt9rRX3QR2pByMJ/nbp0UJrLour9D6V
	 8QwW0AVgNn8CQ==
Date: Mon, 3 Aug 2026 07:19:32 +0000
From: Harry Yoo <harry@kernel.org>
To: hu.shengming@zte.com.cn
Cc: vbabka@kernel.org, akpm@linux-foundation.org, hao.li@linux.dev, 
	cl@gentwo.org, rientjes@google.com, roman.gushchin@linux.dev, ast@kernel.org, 
	andrii@kernel.org, puranjay@kernel.org, ameryhung@gmail.com, bigeasy@linutronix.de, 
	clrkwllms@kernel.org, rostedt@goodmis.org, paulmck@kernel.org, frederic@kernel.org, 
	neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com, josh@joshtriplett.org, boqun@kernel.org, 
	urezki@gmail.com, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, 
	qiang.zhang@linux.dev, pfalcato@suse.de, surenb@google.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, rcu@vger.kernel.org, 
	bpf@vger.kernel.org
Subject: Re: [PATCH v5 3/8] mm/slab: use call_rcu() in unknown context if
 irqs are enabled
Message-ID: <anBAiTl_16H7NqEr@dev>
References: <20260729-kfree_rcu_nolock-v5-3-a28cdcda9673@kernel.org>
 <20260730192119586UvhYMv4xrNqaZLKIJH9X0@zte.com.cn>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730192119586UvhYMv4xrNqaZLKIJH9X0@zte.com.cn>

On Thu, Jul 30, 2026 at 07:21:19PM +0800, hu.shengming@zte.com.cn wrote:
> Harry wrote:
> > call_rcu() disables IRQs with local_irq_save() to protect its per-cpu
> > data structures. Therefore, if IRQs are not disabled, they cannot be
> > corrupted by reentrance into call_rcu(). So fall back to the deferred
> > path only when !allow_spin && irqs_disabled().
> > 
> > The RCU subsystem does not guarantee this contractually, and this
> > optimization relies on RCU's implementation details. Ideally, it should
> > be removed once call_rcu_nolock() is supported by the RCU subsystem.
> > 
> > Link: https://lore.kernel.org/linux-mm/CAADnVQKRVD5ZSnEKbZZU7w86gHbGHUug2pvzpgZTngNS+fg4rw@mail.gmail.com
> > Suggested-by: Alexei Starovoitov <ast@kernel.org>
> > Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
> > ---
> >  mm/slub.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 2c5ba8c326e7..bb0f2975c95b 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -6157,8 +6157,12 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj, unsigned int free_flags)
> >      if (likely(rcu_sheaf->size < s->sheaf_capacity)) {
> >          rcu_sheaf = NULL;
> >      } else {
> > -        if (unlikely(!allow_spin)) {
> > -            /* call_rcu() cannot be called in an unknown context */
> > +        /*
> > +         * With !allow_spin, we might have interrupted call_rcu()'s
> > +         * IRQ-disabled critical section. If IRQs are not disabled,
> > +         * we know that's not the case.
> > +         */
> > +        if (unlikely(!allow_spin && irqs_disabled())) {
> 
> LGTM!
> Reviewed-by: Shengming Hu <hu.shengming@zte.com.cn>

Thanks a lot, Shengming!

> I initially wondered whether in_nmi() should also be checked here.
> However, irqs_disabled() already covers the relevant reentrancy case,
> since call_rcu() disables IRQs while modifying its per-CPU data.

Exactly, that was my reasoning ;)

As a side note there is an attempt to do this in call_rcu() instead of
slab:

https://lore.kernel.org/all/20260729162207.1567770-1-puranjay@kernel.org

Just FYI.

-- 
Cheers,
Harry / Hyeonggon
