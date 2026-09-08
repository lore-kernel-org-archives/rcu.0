Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3411D55C318;
	Tue,  8 Sep 2026 15:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788881085; cv=none; b=NbVtp9tTiuK+HHKhldXply1L8LDuKpIqckoRGtQmpYhmT2zaD4K17wBQy6fTocQpbFjUi46D2DzVnr6r4NdZuL6ADBS0bsgr1Gwxfi6AtZQHhdJv0Byn9i17czwuWEGS+kaNJUhrexTxezFgIvUcfX6gp425OP8vHw/Jh4w63zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788881085; c=relaxed/simple;
	bh=9Jil9cj2q0a6jafoBFjbwCwN3gbTagEKDLCazm84N2s=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=j4YFIcIGkD0UkpW0gH9rEhaX9k8snxRqpodmvJrjaJT1YLWQNt/VlgvBUgJuIz7GMruGFwny/3xvYLp3S0QncgPWG+Rf7AwiQ+U8A7eKkGkPEncHGI31e+SsXKKIsZDbal1NVgNcPuC6hXhKQK9aNVO6xbio2ofFoBkyUqCkcSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=PefRed1H; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=eya0QxoV; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="PefRed1H";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="eya0QxoV"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788881057; bh=dkmvDmGDU7vWgjB37ccVeJI
	UoC1Jz0oVaAVRmnvfDEg=; b=PefRed1Hc/PaEHmY9qMyOXNV054WlzLTIm3G6RUB/8bNYd0Ry1
	mOcYVZw6A+4qQ2rpn0ZaY/ldUF6M5kYyrkq3pa+gOfQAsbee1/nH1fDR9RUiXZ7VSbJmDMEgsWW
	srq95+anFuNIxtBQI+W33jRxJP/G1kUmOAi7TjxPNyiLhFAMnkBX9r92rwe4g62E6GyqwCLw9rs
	uMe38ZOHYACOub/5hETwVYnvGOXqiBsTvptmwAF8e8VekNftmNIsjAhlEd73NTW1sW8fK6G4NJh
	gdPZRwZYpcMcDUUfJjJLM0zGEJ5OIorUehgp6V7wFaq25QGRpV2SeF6+0Y7XROUHogA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788881057; bh=dkmvDmGDU7vWgjB37ccVeJI
	UoC1Jz0oVaAVRmnvfDEg=; b=eya0QxoV1i6KwREJN92hWYQ1KDGj7keTEH41eo6/pEjrGUOYu+
	idiKCOBmijV9ua4c3mfi2yjsJ4phAtRXcuAg==;
Date: Tue, 08 Sep 2026 16:24:17 +0100
From: Bradley Morgan <brads@mainlining.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Paul E . McKenney" <paulmck@kernel.org>
CC: linux-kernel@vger.kernel.org, kernel test robot <yi1.lai@intel.com>,
 Boqun Feng <boqun@kernel.org>, rcu@vger.kernel.org, lkmm@lists.linux.dev
Subject: Re: [PATCH] hazptr: handle NULL address in hazptr_detach
In-Reply-To: <20260908152228.4154-1-mathieu.desnoyers@efficios.com>
References: <20260908152228.4154-1-mathieu.desnoyers@efficios.com>
Message-ID: <E8BCA0DB-FB79-4348-BB0D-229E8B550D91@mainlining.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 8 September 2026 16:22:14 BST, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>When hazptr_acquire loads a NULL pointer, it sets:
>
>- slot_item->slot.addr = NULL,
>- slot_item->ctx.ctx = ctx
>- ctx->slot = slot
>
>And it returns NULL.
>
>Then hazptr_detach is called on this ctx, it will act on the ctx as if
>needed to be promoted to backup slot, even though it has a NULL addr.
>
>Looking at what hazptr_note_context_switch() does before promoting
>to backup slot, it checks for a NULL slot->addr, which is exactly
>what is missing from hazptr_detach.
>
>With this in place there would be no need to explicitly check the
>hazptr_acquire() return value before calling hazptr_detach().
>
>hazptr_release() has a early return check for NULL addr as well, so it
>makes sense that detach does an early return (no-op) similarly.
>

You shall kill me for this!!

Could you perhaps do a splat in ze commit description pls?


>Fixes: 6357ec235c59 ("hazptrtorture: Fix hazptr ownership issue")
>Reported-by: kernel test robot <yi1.lai@intel.com>
>Closes: https://lore.kernel.org/oe-lkp/202608130915.62b53936-lkp@intel.com
>Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>Reviewed-by: Bradley Morgan <brads@mainlining.org>
>Cc: Paul E. McKenney <paulmck@kernel.org>
>Cc: Boqun Feng <boqun@kernel.org>
>Cc: Bradley Morgan <brads@mainlining.org>
>Cc: <rcu@vger.kernel.org>
>Cc: <lkmm@lists.linux.dev>
>---
> include/linux/hazptr.h | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/include/linux/hazptr.h b/include/linux/hazptr.h
>index 43122c5673bd..d1670121947a 100644
>--- a/include/linux/hazptr.h
>+++ b/include/linux/hazptr.h
>@@ -160,10 +160,12 @@ void hazptr_detach(struct hazptr_ctx *ctx)
> 	struct hazptr_slot *slot;
> 
> 	guard(preempt)();
>+	slot = ctx->slot;
>+	if (!slot->addr)
>+		return;
> #ifdef CONFIG_HAZPTR_DEBUG
> 	ctx->detach_task = ctx->detach_cpu = true;
> #endif
>-	slot = ctx->slot;
> 	if (unlikely(hazptr_slot_is_backup(ctx, slot)))
> 		return;
> 	hazptr_promote_to_backup_slot(ctx, slot);
>

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
