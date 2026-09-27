Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AC833DEE9;
	Sun, 27 Sep 2026 16:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790526858; cv=none; b=hDJ4qGiPW/R6QgX2yYXGWa5XW4yKZUVObquAGHpcAiPfWkmVjYHL1QklQFe9Ze4S2S5kUGmVhZPYD9uVeAI9cNRPl9RiDw6CNYdCCZRk2bd78l7k9vgbgzHvGa3DcBKwsXxRU1y2v4SVIdBrnne+Pgm15chs7y7iWcBVe/vKqn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790526858; c=relaxed/simple;
	bh=pVhV0s5xSaqfi7ZpJcnxlNbFvnolA3fpIcpgj1k/dVA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=LpIT0NoXN1fGLnkIXRvZRRmLQaGXu9DiAMuNoqKDYoKVH6SCpSFfMZAluBsS156ZAlZOPa/gMVVWme5SFDcW4MeldsbP+GVXyu2wt4NWB19NzFDMHHgNepGiPt9hZQVcqM2w8b0XenNeGxDJ6IIOoE1FKmaPg6VpkpsPBs+kyUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=ZtjRGBAl; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=m/8ZWVZs; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="ZtjRGBAl";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="m/8ZWVZs"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790526840; bh=KcI1YG6y7h4/QlDbPjAqJIr
	5IQhsXAKX8fFu5YaAnC4=; b=ZtjRGBAl1N+5g5Y/brPE0eKl/4pLRE23RfFqabLEiNJa+ia23+
	j50r8soN+ZJQKjHLaKumw42DilZ5cvJuAgJMk20V63oUEtUGz9/8RjFbcXrAupcAs3e1S5j+U1g
	8DssHab49sRlLLD7uJyln3EYQkEpo++39qvaR+lSfC5GhKT8yigoQpSbrjPEOw+p2nrfvbzPWNs
	+0QIk5oO6V6/mlLVQWipxDC/hBZlerhT93QOqUattXRPHS8SwI055fsI3tJMa+7vPRE4m28m+JD
	TeKTM1r1j5JMmGgYhk6GW+BQqAFUobZX2Ef1W/JxGI19aTwp3NNwjK4/MW/u7cW8XQg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790526840; bh=KcI1YG6y7h4/QlDbPjAqJIr
	5IQhsXAKX8fFu5YaAnC4=; b=m/8ZWVZsVicYufl1mdaHDFgo/jOn6WalbnDj748R7Vj5u14OaC
	0YL+pzGAKmuHSrvqiotL4/moKX/L7Y6WnFDA==;
Date: Sun, 27 Sep 2026 17:33:59 +0100
From: Bradley Morgan <brads@mainlining.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Paul E . McKenney" <paulmck@kernel.org>
CC: linux-kernel@vger.kernel.org, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, rcu@vger.kernel.org, lkmm@lists.linux.dev
Subject: Re: [PATCH hazptr 0/4] Hazard pointer updates
In-Reply-To: <89cecc9c-f29b-46d1-804d-c87171a445f0@efficios.com>
References: <20260927155134.4740-1-mathieu.desnoyers@efficios.com> <EAE9B584-7CEC-46AA-AC8F-A06F11073763@mainlining.org> <89cecc9c-f29b-46d1-804d-c87171a445f0@efficios.com>
Message-ID: <1357947A-5850-4F73-B22E-2AE8B5CAABE2@mainlining.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 27 September 2026 17:27:33 BST, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>On 2026-09-27 12:07, Bradley Morgan wrote:
>> On 27 September 2026 16:51:27 BST, Mathieu Desnoyers
>> <mathieu.desnoyers@efficios.com> wrote:
>>> Hi Paul,
>>> 
>>> This series applies on top of "hazptr: handle NULL address in
>>> hazptr_detach" you have in your rcu dev tree.
>>> 
>>> This first patch addresses a race identified by Boqun Feng in the
>>> two-phase wildcard scheme.
>>> 
>>> Patches 2-3 are prerequisites for using ptr_eq() in the 4th patch.
>>> Those were discussed at length in a prior version of hazard pointer
>>> patches.
>>> 
>>> Patch 4 introduces a "try acquire" helper to allow the fast path
>>> to not rely on wildcards, while keeping the wildcard forward
>>> progress guarantees in the acquire slow path, used on fast path
>>> failure.
>> 
>> Hi, here is a hazptr perf test on powerpc
>> 
>> REAL kill_fasync(), ns per call, best of 3, 100k calls:
>> (stock = rwlock walk, conv = hazptr walk, same v3 tree ± the conversion)
>> 
>>    shape          stock    conv     delta
>>    1 node,  1 walker     59      59     +0.0%   (singleton: identical)
>>    16 nodes, 1 walker   539     539     +0.0%   (uncontended: identical)
>>    16 nodes, 4 walkers  509     134    -73.7%   ← rwlock readers contend
>>    16 nodes, 8 walkers  313     113    -63.9%   ← same list, 8 cpus
>>    64 nodes, 1 walker  1979    2039     +3.0%   (pure walk: hazptr tax)
>>    64 nodes, 4 walkers 1914     509    -73.4%
>>    64 nodes, 8 walkers 1015     382    -62.4%
>> 
>> Its SLOWER than rcu, but beats rwlock
>
>Two feedback points:
>
>1) The comparison I think Boqun cares mostly about is with expedited
>   RCU grace periods, this is where we suspect there is a significant
>   benefit to using hazptr rather than RCU to eliminate those IPIs
>   on synchronize.
>
>   It's good to know that it performs better than rwlock (albeit it's
>   not surprising).
>
>2) I'm concerned about what looks like a use of hazptr to protect linked
>   lists elements in your benchmark (did I miss anything ?).
>
>   RCU read-side critical sections protect all elements of a linked list
>   naturally, but hazptr requires more care. See this comment above
>   hazptr_acquire:
>
> * This protection is unconditional, and has limitations similar to
> * that of unconditional reference-counter acquisition.  In particular,
> * although holding a hazard pointer prevents a hazard-pointer-protected
> * object from being freed, it does not prevent that object from being
> * removed from a linked data structure, and does not prevent other
> * hazard-pointer-protected objects referenced by this object from being
> * both removed and freed.  At which point, invoking hazptr_acquire()
> * on these dangling pointers would be a bug.  On the other hand, use of
> * hazptr_acquire() is safe for immortal pointers to objects that do not
> * themselves contain pointers to hazard-pointer-protected objects.
> * Other (more complex) use cases are also possible.
>
>Does the pointer you protect qualify as an "immortal" pointer, or it's
>a linked list "next" pointer ?
>

Hmm. Do you have a idea on what you could metaphorically convert, with a
core subsystem? 

I'll give anything you want me to do a try

>Thanks,
>
>Mathieu
>
>> 
>> SIGIO delivery, plain mode, 8 ptys 1 listener each (identical harness):
>> 
>>    BASELINE (rwlock)     472/s
>>    CONVERTED v4 (hazptr) 452/s   ← singleton fast path: gap 12% → 4%
>> 
>> With a few changes, it was 12% slower than rcu before.
>> 
>> Do you want those changes?
>> 
>> My idea is, we find something that would put use to hazptr, here is what
>I
>> tried
>> 
>> 
>> diff --git a/fs/fcntl.c b/fs/fcntl.c
>> index c158f082f1da..bb04076ff6d9 100644
>> --- a/fs/fcntl.c
>> +++ b/fs/fcntl.c
>> @@ -17,6 +17,7 @@
>>   #include <linux/slab.h>
>>   #include <linux/module.h>
>>   #include <linux/pipe_fs_i.h>
>> +#include <linux/hazptr.h>
>>   #include <linux/security.h>
>>   #include <linux/ptrace.h>
>>   #include <linux/signal.h>
>> @@ -1009,15 +1010,20 @@ int fasync_remove_entry(struct file *filp,
>struct fasync_struct **fapp)
>>   		if (fa->fa_file != filp)
>>   			continue;
>>   -		write_lock_irq(&fa->fa_lock);
>> +		/*
>> +		 * Make the file invisible to the walk before unlinking,
>> +		 * then wait for any in-flight send_sigio() to be done with
>> +		 * the node before freeing it.  The walk holds a hazard
>> +		 * pointer to this node, so it cannot already be freed.
>> +		 */
>>   		fa->fa_file = NULL;
>> -		write_unlock_irq(&fa->fa_lock);
>> -
>>   		*fp = fa->fa_next;
>> -		kfree_rcu(fa, fa_rcu);
>> +		spin_unlock(&fasync_lock);
>> +		spin_unlock(&filp->f_lock);
>> +		hazptr_synchronize(fa);
>> +		fasync_free(fa);
>>   		filp->f_flags &= ~FASYNC;
>> -		result = 1;
>> -		break;
>> +		return 1;
>>   	}
>>   	spin_unlock(&fasync_lock);
>>   	spin_unlock(&filp->f_lock);
>> @@ -1056,13 +1062,10 @@ struct fasync_struct *fasync_insert_entry(int
>fd, struct file *filp, struct fasy
>>   		if (fa->fa_file != filp)
>>   			continue;
>>   -		write_lock_irq(&fa->fa_lock);
>> -		fa->fa_fd = fd;
>> -		write_unlock_irq(&fa->fa_lock);
>> +		WRITE_ONCE(fa->fa_fd, fd);
>>   		goto out;
>>   	}
>>   -	rwlock_init(&new->fa_lock);
>>   	new->magic = FASYNC_MAGIC;
>>   	new->fa_file = filp;
>>   	new->fa_fd = fd;
>> @@ -1121,44 +1124,51 @@ EXPORT_SYMBOL(fasync_helper);
>>   /*
>>    * rcu_read_lock() is held
>>    */
>> -static void kill_fasync_rcu(struct fasync_struct *fa, int sig, int
>band)
>> +void kill_fasync(struct fasync_struct **fp, int sig, int band)
>>   {
>> +	struct hazptr_ctx cur, nxt;
>> +	struct fasync_struct *fa;
>> +
>> +	/* First a quick test without locking: usually
>> +	 * the list is empty.
>> +	 */
>> +	fa = READ_ONCE(*fp);
>> +	if (!fa)
>> +		return;
>> +
>> +	/*
>> +	 * Hand-over-hand with two ping-ponged contexts: the next node
>> +	 * must be acquired before the current one is released, but a
>> +	 * hazptr_ctx may only front one live slot at a time.
>> +	 */
>> +	cur = (struct hazptr_ctx){ };
>> +	nxt = (struct hazptr_ctx){ };
>> +	fa = hazptr_acquire(&cur, (void * const *)fp);
>>   	while (fa) {
>> -		struct fown_struct *fown;
>> -		unsigned long flags;
>> +		struct fasync_struct *next;
>>     		if (fa->magic != FASYNC_MAGIC) {
>>   			printk(KERN_ERR "kill_fasync: bad magic number in "
>>   			       "fasync_struct!\n");
>> -			return;
>> +			break;
>>   		}
>> -		read_lock_irqsave(&fa->fa_lock, flags);
>> +
>>   		if (fa->fa_file) {
>> -			fown = file_f_owner(fa->fa_file);
>> -			if (!fown)
>> -				goto next;
>> -			/* Don't send SIGURG to processes which have not set a
>> -			   queued signum: SIGURG has its own default signalling
>> -			   mechanism. */
>> -			if (!(sig == SIGURG && fown->signum == 0))
>> +			struct fown_struct *fown = file_f_owner(fa->fa_file);
>> +
>> +			if (fown &&
>> +			    /* Don't send SIGURG to processes which have not set a
>> +			       queued signum: SIGURG has its own default signalling
>> +			       mechanism. */
>> +			    !(sig == SIGURG && fown->signum == 0))
>>   				send_sigio(fown, fa->fa_fd, band);
>>   		}
>> -next:
>> -		read_unlock_irqrestore(&fa->fa_lock, flags);
>> -		fa = rcu_dereference(fa->fa_next);
>> -	}
>> -}
>> -
>> -void kill_fasync(struct fasync_struct **fp, int sig, int band)
>> -{
>> -	/* First a quick test without locking: usually
>> -	 * the list is empty.
>> -	 */
>> -	if (*fp) {
>> -		rcu_read_lock();
>> -		kill_fasync_rcu(rcu_dereference(*fp), sig, band);
>> -		rcu_read_unlock();
>> +		next = hazptr_acquire(&nxt, (void * const *)&fa->fa_next);
>> +		hazptr_release(&cur, fa);
>> +		swap(cur, nxt);
>> +		fa = next;
>>   	}
>> +	hazptr_release(&cur, fa);
>>   }
>>   EXPORT_SYMBOL(kill_fasync);
>>   diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index f9d1e05e8ae6..852f1b8c00af 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -1365,7 +1365,6 @@ static inline struct dentry *file_dentry(const
>struct file *file)
>>   }
>>     struct fasync_struct {
>> -	rwlock_t		fa_lock;
>>   	int			magic;
>>   	int			fa_fd;
>>   	struct fasync_struct	*fa_next; /* singly linked list */
>> 
>> 
>> Anything I did wrong? No?
>> 
>> 
>>> 
>>> Thanks,
>>> 
>>> Mathieu
>>> 
>>> Mathieu Desnoyers (4):
>>>   hazptr: Fix two-phase hazptr_synchronize race with detach
>>>   compiler.h: Introduce ptr_eq() to preserve address dependency
>>>   Documentation: RCU: Refer to ptr_eq()
>>>   hazptr: Introduce "try acquire" fast path, fallback to overflow list
>>> 
>>> Cc: Paul E. McKenney <paulmck@kernel.org>
>>> Cc: Boqun Feng <boqun@kernel.org>
>>> Cc: Bradley Morgan <brads@mainlining.org>
>>> Cc: Gary Guo <gary@garyguo.net>
>>> Cc: <rcu@vger.kernel.org>
>>> Cc: <lkmm@lists.linux.dev>
>>> 
>>> Documentation/RCU/rcu_dereference.rst |  38 +++++++-
>>> include/linux/compiler.h              |  63 ++++++++++++
>>> include/linux/hazptr.h                |  47 +++++----
>>> kernel/hazptr.c                       | 135 +++++++++++++++-----------
>>> 4 files changed, 203 insertions(+), 80 deletions(-)
>>> 
>>> 
>> 
>> --- Thanks!
>> "I'm not a very positive person" - Linus torvalds
>
>
>

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
