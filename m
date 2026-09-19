Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439013F329E;
	Sat, 19 Sep 2026 11:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789818174; cv=none; b=PnhRGys6lKEGYmni/rEC2UQuVZedzhim654Iv2EkF5ruWOofPBFjeVPUkccxngwl1TqpQkxa6fPyBZewToEf6kt8BSLJSTI4Gq3+TTyTJQbubzcEeJydRaXP1A/IIt+Z6O17Nlg4qLlTgbVVQAJtgiIoKYcc/apNlyWza/3szec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789818174; c=relaxed/simple;
	bh=TbJgtL5/olH9VmtiEh2YQ+l2218B8ZLS+vkDuoMcV/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gh0RpDALJI7ZzFC6rHllm24Mf7WrF39VKvbVWljXQiZ2ge+4T8BJe/eRzSPM7GTf/A+0cjgeXC60SR32jmgMrxs8I+SGcwVQOLRkSuR4R22yII5hJ3gemQSQIE2bL+AVP8hXMcgwP+aPNtXi/IxF0w4R+oyR8HbKFMtf+pkSRKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZgJfpJGd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZgJfpJGd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB7A1F000FF;
	Sat, 19 Sep 2026 11:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789818172;
	bh=45SzqYtoSQF6mtZSsxJAVtpiAQ3di9qtlyXPs1hzkZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZgJfpJGdKOxiELK9mt37/P4+25j9CVUY9sW1kFxu4eKIbcTERPj5LW7Gaul9slSP+
	 CkLgJ2UWPVSE7VSLWQYutv+1FTu2iZdN0qZSBurk7221sD0/nZFwwSGhUFvwLAsW8C
	 q7LWYvISxISSA+xFc5+3mnJh7bX8HitKDN03LeGFRxlGXSZGEUUI/1C6j+gJL/JzWg
	 RMU4FKetkQWMtY3srnT5xNuDOnWSMml62NWelyIAyICWchZDOEqQbCNkkMIsVrCkAA
	 MJkwOmSZ8TeL7jRtqMExl8S2cP/ySvzJhB6FMHq4qaRtF5DD0clfSgAwVSdl4mWJir
	 5T66FLu25EPVg==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 97D6BF40066;
	Sat, 19 Sep 2026 07:42:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sat, 19 Sep 2026 07:42:51 -0400
X-ME-Sender: <xms:O3WuajYybJjcqNpjCVFaKFQb72HtTrgk8EXGZrwnYEAB7u4pYd9jqg>
    <xme:O3Wuaqi29GMNIxuDGfsdqE2Rrfp_2523oA0Cr_BU6u2EVSuucB1YvOS49VtpH3DH5
    yNtRkHCPFcwrcBOIhVmfbpE9lhDPaCXnYpOPqoUNGOmVfw3qip07Q>
X-ME-Received: <xmr:O3WualfDxUc4gu0rlqW-ty0Bd5SRybpOAtsmUlDtjI7om8gOCt6KVTXjsyg0>
X-ME-Proxy-Cause: dmFkZTF3x1CvYRRybs9POrTbuRdoeE0Zs2PORdbMgfxFraCj4a8fzEBNs4WSFh7TIUq5Jm
    3jBllg2NjT2uhRGdpfZBj+wQjS75e1/aioaQyfW8on5qC/CtVJQI6eHfXjzShSVoOwTFEx
    G9AhV1PHy/5qC4XF9h0qoSNQYYjK8EkK6OUd4wJ4fF6H1sdIqaAEKEX+m/S5Dqqwq9Z/N1
    7WgyK+/skR4iT2UTDpKCAb17KGvcfH3jMdb+jPpkd4FW2tA/S3S8A5Cddnf9mXG6lMtii0
    XaT/CygVaGuqzqhDrrAn8uhjy+h3gURKglRIp1966jYznCOp4bCk4wN2B/rNUz9ZQqD2Fv
    nVA9if3scOqNMd4LeotHf+mgVKH8hiR3qy+5dKM8wgdfCiePd+Oe68I0lLy3i+mqmhAPoj
    ONEBM9TnKBnXQorh5HBujG8isi+pDIanmeADwEOYV0ba639pnQqyUFKeykasUVZF4sGXpw
    56Dobk0qsOkrQXPqSQYlRBw6UDH3nLpfFqu8Eaja81OAYtMx9/J1Xboa3ABVROgr8JoEIv
    x7Nt/iyIAizP1dEpxqwN+gUqFd/xW0KFvGGJihTeJV/3+jUimIXY5S+jJ4zybdiP6EiWfB
    AkgVUKfHQTpMKSk96ProFHgxkgSKEvTx3L2NlpS5Ts9kXmr49TVBpbtYiw0Q
X-ME-Proxy: <xmx:O3WuapnUUhXvHddkIO_ttnUv0AH91ibbZwdngbJ4oGcq6TMBo96IAQ>
    <xmx:O3WuaqwcQqfXsi5ukcJzEs5XFZpbqVxyLIq_EMiXerSMEl0XJstVrQ>
    <xmx:O3Wuasxc5pht6rgdE5G1CG9wpoKpS3Y0xRkZI3jnlvYIDVl2aQ3ScA>
    <xmx:O3WuaqXVbh6Xnk6q3zPb4fUcAAl__LbBvLmKwadr_r3gzdXzl2SURQ>
    <xmx:O3WuajSB6aBsSw4biflSr3dV2dbbJUUSmQV52wbc4n-_rqZAn2txa2zi>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Sep 2026 07:42:50 -0400 (EDT)
Date: Sat, 19 Sep 2026 12:42:48 +0100
From: Boqun Feng <boqun@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>, lkmm@lists.linux.dev,
	Zqiang <qiang.zhang@linux.dev>, Wang Lian <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Bradley Morgan <brads@mainlining.org>
Subject: Re: [PATCH 19/28] hazptr: Permit detaching hazard pointers from
 contexts
Message-ID: <aq51OA4zu-p-nWyy@MacBook-0RXW5>
References: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop>
 <20260919000056.3132131-19-paulmck@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260919000056.3132131-19-paulmck@kernel.org>

On Fri, Sep 18, 2026 at 05:00:47PM -0700, Paul E. McKenney wrote:
> From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> 
> Provide a new hazptr_detach() function that detaches a given hazard
> pointer from its acquisition context.  This context might be a task or
> an interrupt handler.
> 
> [ paulmck: s/hazptr_detach_from_task/hazptr_detach/ per Mathieu. ]
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Boqun Feng <boqun@kernel.org>
> Cc: <rcu@vger.kernel.org>
> Cc: <lkmm@lists.linux.dev>
> ---
>  include/linux/hazptr.h | 55 ++++++++++++++++++++++++++++--------------
>  1 file changed, 37 insertions(+), 18 deletions(-)
> 
> diff --git a/include/linux/hazptr.h b/include/linux/hazptr.h
> index b121f7779cda..8197a51b9f7a 100644
> --- a/include/linux/hazptr.h
> +++ b/include/linux/hazptr.h
> @@ -98,6 +98,41 @@ bool hazptr_slot_is_backup(struct hazptr_ctx *ctx, struct hazptr_slot *slot)
>  	return slot == &ctx->backup_slot.slot;
>  }
>  
> +/* Internal helper. */
> +static inline
> +void hazptr_promote_to_backup_slot(struct hazptr_ctx *ctx, struct hazptr_slot *slot)
> +{
> +	struct hazptr_slot *backup_slot;
> +
> +	backup_slot = hazptr_chain_backup_slot(ctx);
> +	/*
> +	 * Move hazard pointer from the per-CPU slot to the
> +	 * backup slot. This requires hazard pointer
> +	 * synchronize to iterate on per-CPU slots with
> +	 * load-acquire before iterating on the overflow list.
> +	 */
> +	WRITE_ONCE(backup_slot->addr, slot->addr);
> +	/*
> +	 * store-release orders store to backup slot addr before
> +	 * store to per-CPU slot addr.
> +	 */
> +	smp_store_release(&slot->addr, NULL);
> +	/* Use the backup slot for context. */
> +	ctx->slot = backup_slot;
> +}
> +

Probably needs a function doc for hazptr_detach(), how about the
following?

/*
 * hazptr_detach: Detach the hazptr from its acquisition context.
 *
 * By default hazptr_acquire() expects to be released from its
 * acquisition context. However there are cases where the acquisition
 * context sends (in other words, transfers the ownership of) the hazptr
 * to another context, e.g.
 * 
 * 	hazptr_acquire(ctx, gp);
 * 	hazptr_detach(ctx);
 * 	defer_work->hp = ctx;
 * 	queue_work(..., defer_work);
 * 	<in defer_work->func()>
 * 	hazptr_release(ctx);
 *
 * Use hazptr_detach() before sending the hazptr across contexts.
 *
 * It's safe to detach an "already-detatched" hazptr.
 */

Thoughts?

Regards,
Boqun

> +static inline
> +void hazptr_detach(struct hazptr_ctx *ctx)
> +{
> +	struct hazptr_slot *slot;
> +
> +	guard(preempt)();
> +	slot = ctx->slot;
> +	if (unlikely(hazptr_slot_is_backup(ctx, slot)))
> +		return;
> +	hazptr_promote_to_backup_slot(ctx, slot);
> +}
> +
>  static inline
>  void hazptr_note_context_switch(void)
>  {
> @@ -106,27 +141,11 @@ void hazptr_note_context_switch(void)
>  
>  	for (idx = 0; idx < NR_HAZPTR_PERCPU_SLOTS; idx++) {
>  		struct hazptr_slot_item *item = &percpu_slots->items[idx];
> -		struct hazptr_slot *slot = &item->slot, *backup_slot;
> -		struct hazptr_ctx *ctx;
> +		struct hazptr_slot *slot = &item->slot;
>  
>  		if (!slot->addr)
>  			continue;
> -		ctx = item->ctx.ctx;
> -		backup_slot = hazptr_chain_backup_slot(ctx);
> -		/*
> -		 * Move hazard pointer from the per-CPU slot to the
> -		 * backup slot. This requires hazard pointer
> -		 * synchronize to iterate on per-CPU slots with
> -		 * load-acquire before iterating on the overflow list.
> -		 */
> -		WRITE_ONCE(backup_slot->addr, slot->addr);
> -		/*
> -		 * store-release orders store to backup slot addr before
> -		 * store to per-CPU slot addr.
> -		 */
> -		smp_store_release(&slot->addr, NULL);
> -		/* Use the backup slot for context. */
> -		ctx->slot = backup_slot;
> +		hazptr_promote_to_backup_slot(item->ctx.ctx, slot);
>  	}
>  }
>  
> -- 
> 2.40.1
> 
