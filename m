Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FAE4C33E6;
	Wed, 30 Sep 2026 18:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790793399; cv=none; b=AnLVbo2lfbThIfSZz7aW+XHXjhBxq1NwUhQgWrEVJIGqRldnzEdXm9rZSmMVnpq5A+LUkz49DfhvPhTJYGjDfo/HSthOP8pSxiXd1s3n6pQtNToGzyqqbFRvw3Xg0Ythcxa01NeTiPmsCat8IxDMJ0KOvfACCbvHZJs2F793+80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790793399; c=relaxed/simple;
	bh=VUdi90djdUmelPiBH2g9vWrf6a2YP1CNrsGy/AkTM8M=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=rX5fdUqcRnE6CvtVfn4BLoqKmgEqTsAtDtV909vRMb1wnTAXn9ZTBtLEukyzki9RklErIwlX/dJHdIYe1MFyf6FPyomveWmSO9oAkVYO/l++Paut+4jqcw+VYw7NZTdgkEbcr2I09RXab0KDAYe6mEOos1K/JKPKFZKqtvY9Es8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=GKyL+ajY; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=CCn5p5YT; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="GKyL+ajY";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="CCn5p5YT"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790793380; bh=yabuR8AUgligfEBOy3I805L
	BqL6502nnbdZtxaciH8s=; b=GKyL+ajYNWBUQcUwd21Py42wyvn4N7vNnwanEybgfJ9pKZJEkt
	yDQVWcrrkVQn4PKB/FLP/mSIyfT7Y6X12IVKUH5G4weg+E14V9bcHYQsOYW52Lx8yqz29cnEaT/
	x9sJW9PfkpsxuPaydXnyqQWrz9R3XAbiTDEFfF0zOuG7ODBJxp1g8w1cZIzEziiF4ADplpE0YMM
	EUYdk/oWkoubsv2kxiFPoJzePKsBpeD9dvIIZJR3FPtuK4J2atgtmDZC/s3BZ7nvqDKilad3QAo
	j1fiV+ic0L4U9B7Zk1pFwORJwmDs0BFDgucC7kKLoCScPO8lyeHbDi/u0mKL1G0sZcA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790793380; bh=yabuR8AUgligfEBOy3I805L
	BqL6502nnbdZtxaciH8s=; b=CCn5p5YT0RxmKY4vXVmzULYrPal8lw3nxrThzdTqvZC554y/VY
	ZPaAT5nxiZYjgcdjoTHPRNX6gag1j8lKIwAw==;
Date: Wed, 30 Sep 2026 19:36:20 +0100
From: Bradley Morgan <brads@mainlining.org>
To: paulmck@kernel.org
CC: arighi@nvidia.com, arnd@arndb.de, arnd@kernel.org, boqun@kernel.org,
 frederic@kernel.org, gustavold@gmail.com, jiangshanlai@gmail.com,
 joelagnelf@nvidia.com, josh@joshtriplett.org, kunwu.chan@gmail.com,
 linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 neeraj.upadhyay@kernel.org, qiang.zhang@linux.dev, rcu@vger.kernel.org,
 rostedt@goodmis.org, tglx@kernel.org, tj@kernel.org, urezki@gmail.com,
 yphbchou0911@gmail.com
Subject: Re: [PATCH] rcu: include rtmutex_common.h in tree_stall.h
In-Reply-To: <0fbaa5c5-3f75-4fd2-8537-0576eb11abbe@paulmck-laptop>
Message-ID: <28A04B09-71B0-4BBA-825C-7F80E57BCF3A@mainlining.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 29 September 2026 22:08:49 BST, "Paul E. McKenney" <paulmck@kernel.org>
wrote:
>On Mon, Sep 28, 2026 at 10:54:13AM +0800, KunWu Chan wrote:
>> Thanks, Arnd.
>> 
>> Tested on top of 1eccf02fb8d5 with CONFIG_PREEMPT_RCU=y:
>> 
>> CONFIG_RT_MUTEXES=y: build passes
>> CONFIG_RT_MUTEXES=n: fails without this patch, passes with it
>> 
>> The failure is in tree_stall.h, where rt_mutex_owner() is used
>> before tree_plugin.h includes rtmutex_common.h. This matches the
>> reported failure, and the added include fixes it.
>> 
>> Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
>> Tested-by: Kunwu Chan <kunwu.chan@gmail.com>
>
>Bradley and Kunwu, are you OK with my applying your tags to the commit
>that I am merging this into?
>
>1eccf02fb8d5 ("rcu: Add running and boosted indications to RCU task stall
>dump")
>

I'm ok with it

>							Thanx, Paul
>
>> Thanks,
>> Kunwu
>> 
>> On Fri, Sep 25, 2026 at 9:39 PM Arnd Bergmann <arnd@kernel.org> wrote:
>> >
>> > From: Arnd Bergmann <arnd@arndb.de>
>> >
>> > The added call to rt_mutex_owner() makes this fail to build in
>> > some configurations:
>> >
>> > In file included from kernel/rcu/tree.c:5121:
>> > kernel/rcu/tree_stall.h:333:8: error: call to undeclared function
>'rt_mutex_owner'; ISO C99 and later do not support implicit function
>declarations [-Wimplicit-function-declaration]
>> >   333 |                         if
>(rt_mutex_owner(&rnp->boost_mtx.rtmutex) == t)
>> >       |                             ^
>> > kernel/rcu/tree_stall.h:333:48: error: comparison between pointer and
>integer ('int' and 'struct task_struct *')
>[-Werror,-Wpointer-integer-compare]
>> >   333 |                         if
>(rt_mutex_owner(&rnp->boost_mtx.rtmutex) == t)
>> >       |                            
>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^  ~
>> > In file included from kernel/rcu/tree.c:5124:
>> > In file included from kernel/rcu/tree_plugin.h:14:
>> > kernel/rcu/../locking/rtmutex_common.h:231:35: error: conflicting
>types for 'rt_mutex_owner'
>> >   231 | static inline struct task_struct *rt_mutex_owner(struct
>rt_mutex_base *lock)
>> >       |                                   ^
>> > kernel/rcu/tree_stall.h:333:8: note: previous implicit declaration is
>here
>> >   333 |                         if
>(rt_mutex_owner(&rnp->boost_mtx.rtmutex) == t)
>> >       |                             ^
>> >
>> > There are already a couple of inclusions of
>"../locking/rtmutex_common.h",
>> > so assume this is safe to do here.
>> >
>> > Fixes: 1eccf02fb8d5 ("rcu: Add running and boosted indications to RCU
>task stall dump")
>> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> > ---
>> > I wonder if it would be better to either move the rt_mutex_owner()
>> > definition into a global header like include/linux/rtmutex.h, or to
>> > move the code out of tree_stall.h into a .c file, as this feels like a
>> > layering violation.
>> > ---
>> >  kernel/rcu/tree_stall.h | 1 +
>> >  1 file changed, 1 insertion(+)
>> >
>> > diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
>> > index 5dded1e89197..803a56af3259 100644
>> > --- a/kernel/rcu/tree_stall.h
>> > +++ b/kernel/rcu/tree_stall.h
>> > @@ -12,6 +12,7 @@
>> >  #include <linux/rcu_notifier.h>
>> >  #include <linux/smp.h>
>> >  #include <linux/rtmutex.h>
>> > +#include "../locking/rtmutex_common.h"
>> >
>> > 
>//////////////////////////////////////////////////////////////////////////////
>> >  //
>> > --
>> > 2.53.0
>> >
>> 
>
>

--- Thanks!
"I'm not a very positive person" - Linus torvalds
