Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0404C550DC5
	for <rcu@vger.kernel.org>; Tue,  8 Sep 2026 14:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788878721; cv=none; b=AxzptYJ4EEGkzFgXFzHP357/pNQkjM8Mf5mAfunwgFw8Kdk7qzuOZuovpaOaY3htm6BKHuKjPlTZBx8iKJn66+7CLlr2KtHP9Icd2xB6yF/fnYCALUPW0na8Q3XwgvPPbvboACcp9bIs503zpPLzjo7ZlTrWmgxPJMfrGmYWIW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788878721; c=relaxed/simple;
	bh=rldVH3ry+wstdVntsV7yAqgv+9k+aeZl5V/PmM8IAHc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=hkJMgq8VaDlFlGo0aj7cJLd0UDcjUBD0eI+UUgWN6ARK3tNmvVaggftJ0K3eD+TB89+FYvwAqVqn2mKc2MBZD3OKsuZ0rAzFonXGvoYSYqeHqfkvg9WHAk0YbwbwMHsWJacgFagMDrtguGBBpRtM9cKefMJK/4tM55Zk7TzM5KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=JW7FGVt9; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=WH3EXT4A; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="JW7FGVt9";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="WH3EXT4A"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788878707; bh=ZP2etLrFyuR7m6EWGHGM7Ok
	T3C2GL1b0noGONaiH3y8=; b=JW7FGVt9vy06iYmJ2t1F6ojefXaxcnFX+J7Zh4Gp1SHI6tMWAR
	bwjT2m50ERHXsl/37LC3dru17obkR96atyoHcC5E4XQ9CN5aKHMYsBD3PJa7KUNwO1dgGq8oe69
	LrQbAv+AgfIpOmOVzHvv199sNGZt0ihbRqOJOQNbGp+QKhLxWNyYwTJKa+QiicUMhVmy4L15BmT
	InOH3eXSYU/fskFw0Bm5mBdTLqCA1zyZQtdF/t25W1er9P1LEJ6hvMlQHqvySACYm5PnmhiO1cM
	L0RYFeSIfAnnNQp3EuuLkaYk2OB2F6DMHHRCxkNwXDSaxakx5q8I1W/KT6HxlIn3bXA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788878707; bh=ZP2etLrFyuR7m6EWGHGM7Ok
	T3C2GL1b0noGONaiH3y8=; b=WH3EXT4Akz9y0qqKT0LIOzUNmb1f4QCV+PiaoCvKVgVzLLPEg+
	ijO8GvxeYMlMeNuAchXuVcfcn0PX7DoX3vDQ==;
Date: Tue, 08 Sep 2026 15:45:08 +0100
From: Bradley Morgan <brads@mainlining.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, yi1.lai@intel.com
CC: boqun@kernel.org, lkp@intel.com, oe-lkp@lists.linux.dev, paulmck@kernel.org,
 rcu@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5Bpaulmckrcu=3Anon-rcu/n?=
 =?US-ASCII?Q?ext=5D_=5Bhazptrtorture=5D_9b08?=
 =?US-ASCII?Q?a09f6d=3A_BUG=3Akernel=5FNULL=5Fp?=
 =?US-ASCII?Q?ointer=5Fdereference=2Caddress?=
In-Reply-To: <5cde694f-afc7-4c96-b67d-bafdb7e88746@efficios.com>
References: <9D3C10DF-2BA2-4F97-AAB1-C36AF227F6B3@mainlining.org> <5cde694f-afc7-4c96-b67d-bafdb7e88746@efficios.com>
Message-ID: <5F4843E4-8D42-4AAE-8125-8E4194F83D76@mainlining.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 8 September 2026 14:50:37 BST, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>On 2026-09-07 16:42, Bradley Morgan wrote:
>[...]
>>> 
>> Hi, could anybody test if this fixes it?
>
>Although this fix to the hazptr torture test addresses the issue at the
>call site, I think we should make hazptr_detach more robust instead.
>
>How about the following:
>
>When hazptr_acquire loads a NULL pointer, it sets:
>
>- slot_item->slot.addr = NULL,
>- slot_item->ctx.ctx = ctx
>- ctx->slot = slot
>
>And it returns NULL.
>
>Then if we mistakenly call hazptr_detach on this ctx, it will act on
>the ctx as if needed to be promoted to backup slot, even though it
>has a NULL addr.
>
>If we look at what hazptr_note_context_switch() does before promoting
>to backup slot, it checks for a NULL slot->addr, which is exactly
>what is missing from hazptr_detach.
>
>Something like this patch (compile-tested only) ?
>
>--- a/include/linux/hazptr.h
>+++ b/include/linux/hazptr.h
>@@ -160,10 +160,12 @@ void hazptr_detach(struct hazptr_ctx *ctx)
>        struct hazptr_slot *slot;
>
>        guard(preempt)();
>+       slot = ctx->slot;
>+       if (!slot->addr)
>+               return;
> #ifdef CONFIG_HAZPTR_DEBUG
>        ctx->detach_task = ctx->detach_cpu = true;
> #endif
>-       slot = ctx->slot;
>        if (unlikely(hazptr_slot_is_backup(ctx, slot)))
>                return;
>        hazptr_promote_to_backup_slot(ctx, slot);
>
>With this in place we would not need to explicitly check the
>hazptr_acquire return value before calling "detach". You will
>note that "hazptr_release" has a early return check for NULL
>addr as well, so it makes sense that detach does an early
>return (no-op) similarly.
>
>Thanks,
>
>Mathieu
>
>> 
>> 
>>  From 3e92b8153c31106d6a080e1c9bbe9bf1e86e1f63 Mon Sep 17 00:00:00 2001
>> From: Bradley Morgan <brads@mainlining.org>
>> Date: Mon, 7 Sep 2026 18:00:08 +0000
>> Subject: [PATCH] hazptrtorture: Only detach acquired hazard pointers
>> 
>> hazptr_torture_acquire() detaches unconditionally, even when the
>> readlock fails. A failed acquire leaves nothing to detach, but the
>> detach still promotes the context to its backup slot and chains that
>> slot into the running CPU's overflow list. The reader then retries on
>> its own CPU, the fast path hands out a per-CPU slot and overwrites
>> ctx->slot, and the chained backup node is orphaned, still linked,
>> with nobody left to unchain it.
>> 
>> The next detach of the same context chains the same node a second
>> time, into another CPU's list, and the node ends up reachable from
>> both. The eventual release unchains it once, hlist_del() poisons
>> node->next, and the first list is left pointing at the poisoned node.
>> The writer's next hazptr_synchronize() walks that list, steps onto
>> LIST_POISON1 (0x100 on i386, where POISON_POINTER_DELTA is 0), and
>> reads slot.addr at offset 8 of the backup slot, address 0x108, which
>> is the crash the robot hit.
>> 
>>    cpuA (IPI acquire)     cpuR (reader)          cpuD (do_pending)
>>    ---------------------  ---------------------  -------------------
>>    readlock() returns
>>      NULL
>>    detach chains the
>>      backup node into
>>      cpuA list
>>                           hpp_htp is NULL,
>>                             continue
>>                           reacquire, ctx->slot
>>                             is now a cpuR
>>                             per-CPU slot
>>                           acquire succeeds,
>>                             defer, detach chains
>>                             the SAME node into
>>                             cpuR list
>>                                                  release, unchain
>>                                                    once, node->next
>>                                                    is POISON1
>>                                                  kfree(hppp)
>>    synchronize walks cpuA
>>      list, node->next is
>>      0x100, reads 0x108,
>>      Oops
>> 
>> Skip the detach when the acquire failed. The slot holds NULL in that
>> case, note_context_switch() and the synchronize scanners skip NULL
>> slots, and the next acquire overwrites ctx->slot, so leaving the
>> context attached is safe.
>> 
>> The robot's original report was against the defer path before detach
>> existed, which 4bd7f458229a fixed. This is the same crash surviving
>> through the IPI acquire path that 6357ec235c59 added.
>> 
>> Fixes: 6357ec235c59 ("hazptrtorture: Fix hazptr ownership issue")
>> Reported-by: kernel test robot <yi1.lai@intel.com>
>> Closes:
>https://lore.kernel.org/oe-lkp/202608130915.62b53936-lkp@intel.com
>> Signed-off-by: Bradley Morgan <brads@mainlining.org>
>> ---
>>   kernel/rcu/hazptrtorture.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>> 
>> diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
>> index 7c8b589..267f262 100644
>> --- a/kernel/rcu/hazptrtorture.c
>> +++ b/kernel/rcu/hazptrtorture.c
>> @@ -373,8 +373,11 @@ static void hazptr_torture_acquire(void *hppp_in)
>>   	/*
>>   	 * Acquiring a hazard pointer from a remote CPU.
>>   	 * Detach hazptr from its task so it can be released by another task.
>> +	 * A failed acquire has nothing to detach, and detaching one anyway
>> +	 * orphans the chained backup slot on this CPU's overflow list.
>>   	 */
>> -	hazptr_detach(&hppp->hpp_hc);
>> +	if (hppp->hpp_htp)
>> +		hazptr_detach(&hppp->hpp_hc);
>>   	atomic_long_inc(per_cpu_ptr(&hazptr_torture_acquires_irq, raw_smp_processor_id()));
>>   }
>>   
>
>
>
LGTM, thanks

If you submit as patch:

Reviewed-by: Bradley Morgan <brads@mainlining.org>

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
