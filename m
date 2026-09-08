Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE72D57D21C;
	Tue,  8 Sep 2026 16:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788885066; cv=none; b=Siin7r8t4gtmHKinQzFnVYZwbuuyo5bz8fiReO4fZ7iIbhPlAFRQzxyDGRKsaIuK/UFNyHGYqFwHKKFofnlF3ODrOXO643lK4ALnTNY3veTVSHzk8oxihKYuNP7Yie7CQlCzVY99PSxaP2KAvE90BQBnWHECJaoI/Sx+37TK+Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788885066; c=relaxed/simple;
	bh=bGn8i1OhR4NzVDBtOFVJ+lCCJ8UAyNqLkfbCH6OsOso=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=OF2ccCgi8J9uKa8Dy6A/N5uCIrDkUCnndoiIk0uL7DZQHa1aTxvfx9TjD+pldOn5vLAqoM/y9AKJG1cI67GjBlB5ZJX+gpp2xHEBJMT7NIwSRkAHskdzpvaQGY4KC7V7ASAIMi70lFqcn0aaeb6IwX3PUMTN63/tlnRfZyUgtxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=RadlQ+/+; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=eGU56dZX; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="RadlQ+/+";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="eGU56dZX"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788885061; bh=bB2A2CmRYj4yWv0J3yg4LxL
	tDCGTJFbmG06nLK9kbSU=; b=RadlQ+/+XWhScXCMfrLlmQaJufi/8O4A5s358XbOVhVtrM/GVG
	wQIfTNQiKM2HzTc9nKEBoE7N1qrhW4vgtFMTrY7VZxGolAK2FHGvxbP3r5ZX3WPGq9RRxqrsqfU
	farqOnfcOgoCXdEr2eDO1P0P1DpsLQ5swXR7JNcNc45IHznf3xUXtOT7zxqIpQjBx52ZttwbihY
	Imt/HiQuJr/j+ImUzjSZEOlwwXYjfRdXTRgvwr0NjGrDA2yWdcRwRxgN6IhFGA+BtqB8RwduKEW
	JoY1sjEV6EBdoxBALrfXshSqYTkZh45Wdl8Hve76UuDtqQ9aDRhlW2ck8qbeqAJ1ddg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788885061; bh=bB2A2CmRYj4yWv0J3yg4LxL
	tDCGTJFbmG06nLK9kbSU=; b=eGU56dZXBUv+uiOcm3nZtodw2wjSmijheRPZsm/m2aV8EhF99T
	o34MdK4Tdnfimw3EHfEovJRboMe7MV+KTpBg==;
Date: Tue, 08 Sep 2026 17:31:02 +0100
From: Bradley Morgan <brads@mainlining.org>
To: paulmck@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: linux-kernel@vger.kernel.org, kernel test robot <yi1.lai@intel.com>,
 Boqun Feng <boqun@kernel.org>, rcu@vger.kernel.org, lkmm@lists.linux.dev
Subject: Re: [PATCH] hazptr: handle NULL address in hazptr_detach
In-Reply-To: <da21c929-cd85-4ecb-8976-5948f080b6e7@paulmck-laptop>
References: <20260908152228.4154-1-mathieu.desnoyers@efficios.com> <E8BCA0DB-FB79-4348-BB0D-229E8B550D91@mainlining.org> <7e574430-c77e-4ba9-aab0-cdaed40f788f@efficios.com> <da21c929-cd85-4ecb-8976-5948f080b6e7@paulmck-laptop>
Message-ID: <2BC0384F-1DE7-4277-845A-7D567B77A653@mainlining.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 8 September 2026 17:22:09 BST, "Paul E. McKenney" <paulmck@kernel.org>
wrote:
>On Tue, Sep 08, 2026 at 11:29:31AM -0400, Mathieu Desnoyers wrote:
>> On 2026-09-08 11:24, Bradley Morgan wrote:
>> > On 8 September 2026 16:22:14 BST, Mathieu Desnoyers
>> > <mathieu.desnoyers@efficios.com> wrote:
>> > > When hazptr_acquire loads a NULL pointer, it sets:
>> > > 
>> > > - slot_item->slot.addr = NULL,
>> > > - slot_item->ctx.ctx = ctx
>> > > - ctx->slot = slot
>> > > 
>> > > And it returns NULL.
>> > > 
>> > > Then hazptr_detach is called on this ctx, it will act on the ctx as
>if
>> > > needed to be promoted to backup slot, even though it has a NULL
>addr.
>> > > 
>> > > Looking at what hazptr_note_context_switch() does before promoting
>> > > to backup slot, it checks for a NULL slot->addr, which is exactly
>> > > what is missing from hazptr_detach.
>> > > 
>> > > With this in place there would be no need to explicitly check the
>> > > hazptr_acquire() return value before calling hazptr_detach().
>> > > 
>> > > hazptr_release() has a early return check for NULL addr as well, so
>it
>> > > makes sense that detach does an early return (no-op) similarly.
>> > > 
>> > 
>> > You shall kill me for this!!
>> > 
>> > Could you perhaps do a splat in ze commit description pls?
>> 
>> The splat is available at the "Closes" URL below. I'm not sure whether
>> we should duplicate this verbose information ?
>> 
>> Paul ?
>
>I am fine either way, as long as the information is reasonably easily
>accessible.  Which is the case either way.  ;-)
>
>							Thanx, Paul
>

Hi, what do you reckon, do you wanna merge it?

I can co develop hazptr if u want, it's school season for me but oh well.
Commit to Linux anyway!

>> Thanks,
>> 
>> Mathieu
>> 
>> > 
>> > 
>> > > Fixes: 6357ec235c59 ("hazptrtorture: Fix hazptr ownership issue")
>> > > Reported-by: kernel test robot <yi1.lai@intel.com>
>> > > Closes:
>https://lore.kernel.org/oe-lkp/202608130915.62b53936-lkp@intel.com
>> > > Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> > > Reviewed-by: Bradley Morgan <brads@mainlining.org>
>> > > Cc: Paul E. McKenney <paulmck@kernel.org>
>> > > Cc: Boqun Feng <boqun@kernel.org>
>> > > Cc: Bradley Morgan <brads@mainlining.org>
>> > > Cc: <rcu@vger.kernel.org>
>> > > Cc: <lkmm@lists.linux.dev>
>> > > ---
>> > > include/linux/hazptr.h | 4 +++-
>> > > 1 file changed, 3 insertions(+), 1 deletion(-)
>> > > 
>> > > diff --git a/include/linux/hazptr.h b/include/linux/hazptr.h
>> > > index 43122c5673bd..d1670121947a 100644
>> > > --- a/include/linux/hazptr.h
>> > > +++ b/include/linux/hazptr.h
>> > > @@ -160,10 +160,12 @@ void hazptr_detach(struct hazptr_ctx *ctx)
>> > > 	struct hazptr_slot *slot;
>> > > 
>> > > 	guard(preempt)();
>> > > +	slot = ctx->slot;
>> > > +	if (!slot->addr)
>> > > +		return;
>> > > #ifdef CONFIG_HAZPTR_DEBUG
>> > > 	ctx->detach_task = ctx->detach_cpu = true;
>> > > #endif
>> > > -	slot = ctx->slot;
>> > > 	if (unlikely(hazptr_slot_is_backup(ctx, slot)))
>> > > 		return;
>> > > 	hazptr_promote_to_backup_slot(ctx, slot);
>> > > 
>> > 
>> > --- Thanks!
>> >
>https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
>> 
>> 
>> -- 
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> https://www.efficios.com

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
