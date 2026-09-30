Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FAF44AB7A;
	Wed, 30 Sep 2026 20:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790798876; cv=none; b=e0Ges/T38dx1AXn0IZgPv00E0koX0ipeIiee/rPPQDyJhjefdFq3L9juwf58W41jYSSASRHF+vW6O8nyreOnwJ4yvxvfa42U094jK4xMNi0jCVmKkfIVgatyJx01zIlNYHy33KOWkeow3B6qKAz9bejQyWtl6tmXPo73bDdoUq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790798876; c=relaxed/simple;
	bh=YqXK6Rpcz2AWeHL1OvsEa+i4czIGLK9xGFYhupf8lDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cfZf1OkP/W0p3tRoiafDxW+oRYCgjpk18vI96vupH2zhQj3tLXcBOVzM5NxhsE9JOGx1/992cVh4J6Q3Y32GTa0uNA7LcL2iCi3/v29No+xwhZIApewdjFAzx6JIsGg2IcNDL6DvNL78sh1C0jhiFIV9gMKbqaZCq7i1uYOW3Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3gW2F7J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3gW2F7J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB551F000FF;
	Wed, 30 Sep 2026 20:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790798874;
	bh=w52W+oynoxsfO2u5xrVEGVREkMzq0Hd9q3rh+myUK/8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=G3gW2F7JBtWE+oTnI/920fdYp5DO+RlG2wfbhUqEvHohH5nowvzs2k5nHiznFUbP1
	 UfHCN3L+F1GuXDK6ZzgZgDBEaYtVBrM69TBH8MnqTb9hKxrGEjXWM6+9rJu7KbCVq2
	 tt62kv7Gn1Fy3gjZ5bWnEoYqzb82DCDniIDtmrKPJuwMVCxPEhhqwLHCjPgeTy+uFc
	 hplUYEM8Hf3gP6jcCBGTmSpNltNJi/ywFrtuWQ604/A+muOjO3OgeqTctG7ieBJBEv
	 5fh15F7oB2HaQbPjiUyO0p+WDG4fU53sJTa+zuAQLcpXnk+vOOsN9XDfrbhfKLcK17
	 HY1FudAu+/3yg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1EF52CE097C; Wed, 30 Sep 2026 13:07:54 -0700 (PDT)
Date: Wed, 30 Sep 2026 13:07:54 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Bradley Morgan <brads@mainlining.org>
Cc: arighi@nvidia.com, arnd@arndb.de, arnd@kernel.org, boqun@kernel.org,
	frederic@kernel.org, gustavold@gmail.com, jiangshanlai@gmail.com,
	joelagnelf@nvidia.com, josh@joshtriplett.org, kunwu.chan@gmail.com,
	linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	neeraj.upadhyay@kernel.org, qiang.zhang@linux.dev,
	rcu@vger.kernel.org, rostedt@goodmis.org, tglx@kernel.org,
	tj@kernel.org, urezki@gmail.com, yphbchou0911@gmail.com
Subject: Re: [PATCH] rcu: include rtmutex_common.h in tree_stall.h
Message-ID: <d6a7eadb-a742-40d0-8bd9-a9d5e6f08504@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <0fbaa5c5-3f75-4fd2-8537-0576eb11abbe@paulmck-laptop>
 <28A04B09-71B0-4BBA-825C-7F80E57BCF3A@mainlining.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <28A04B09-71B0-4BBA-825C-7F80E57BCF3A@mainlining.org>

On Wed, Sep 30, 2026 at 07:36:20PM +0100, Bradley Morgan wrote:
> On 29 September 2026 22:08:49 BST, "Paul E. McKenney" <paulmck@kernel.org>
> wrote:
> >On Mon, Sep 28, 2026 at 10:54:13AM +0800, KunWu Chan wrote:
> >> Thanks, Arnd.
> >> 
> >> Tested on top of 1eccf02fb8d5 with CONFIG_PREEMPT_RCU=y:
> >> 
> >> CONFIG_RT_MUTEXES=y: build passes
> >> CONFIG_RT_MUTEXES=n: fails without this patch, passes with it
> >> 
> >> The failure is in tree_stall.h, where rt_mutex_owner() is used
> >> before tree_plugin.h includes rtmutex_common.h. This matches the
> >> reported failure, and the added include fixes it.
> >> 
> >> Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
> >> Tested-by: Kunwu Chan <kunwu.chan@gmail.com>
> >
> >Bradley and Kunwu, are you OK with my applying your tags to the commit
> >that I am merging this into?
> >
> >1eccf02fb8d5 ("rcu: Add running and boosted indications to RCU task stall
> >dump")
> 
> I'm ok with it

Thank you, queued up for my next rebase.

							Thanx, Paul

> >> Thanks,
> >> Kunwu
> >> 
> >> On Fri, Sep 25, 2026 at 9:39 PM Arnd Bergmann <arnd@kernel.org> wrote:
> >> >
> >> > From: Arnd Bergmann <arnd@arndb.de>
> >> >
> >> > The added call to rt_mutex_owner() makes this fail to build in
> >> > some configurations:
> >> >
> >> > In file included from kernel/rcu/tree.c:5121:
> >> > kernel/rcu/tree_stall.h:333:8: error: call to undeclared function
> >'rt_mutex_owner'; ISO C99 and later do not support implicit function
> >declarations [-Wimplicit-function-declaration]
> >> >   333 |                         if
> >(rt_mutex_owner(&rnp->boost_mtx.rtmutex) == t)
> >> >       |                             ^
> >> > kernel/rcu/tree_stall.h:333:48: error: comparison between pointer and
> >integer ('int' and 'struct task_struct *')
> >[-Werror,-Wpointer-integer-compare]
> >> >   333 |                         if
> >(rt_mutex_owner(&rnp->boost_mtx.rtmutex) == t)
> >> >       |                            
> >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^  ~
> >> > In file included from kernel/rcu/tree.c:5124:
> >> > In file included from kernel/rcu/tree_plugin.h:14:
> >> > kernel/rcu/../locking/rtmutex_common.h:231:35: error: conflicting
> >types for 'rt_mutex_owner'
> >> >   231 | static inline struct task_struct *rt_mutex_owner(struct
> >rt_mutex_base *lock)
> >> >       |                                   ^
> >> > kernel/rcu/tree_stall.h:333:8: note: previous implicit declaration is
> >here
> >> >   333 |                         if
> >(rt_mutex_owner(&rnp->boost_mtx.rtmutex) == t)
> >> >       |                             ^
> >> >
> >> > There are already a couple of inclusions of
> >"../locking/rtmutex_common.h",
> >> > so assume this is safe to do here.
> >> >
> >> > Fixes: 1eccf02fb8d5 ("rcu: Add running and boosted indications to RCU
> >task stall dump")
> >> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >> > ---
> >> > I wonder if it would be better to either move the rt_mutex_owner()
> >> > definition into a global header like include/linux/rtmutex.h, or to
> >> > move the code out of tree_stall.h into a .c file, as this feels like a
> >> > layering violation.
> >> > ---
> >> >  kernel/rcu/tree_stall.h | 1 +
> >> >  1 file changed, 1 insertion(+)
> >> >
> >> > diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> >> > index 5dded1e89197..803a56af3259 100644
> >> > --- a/kernel/rcu/tree_stall.h
> >> > +++ b/kernel/rcu/tree_stall.h
> >> > @@ -12,6 +12,7 @@
> >> >  #include <linux/rcu_notifier.h>
> >> >  #include <linux/smp.h>
> >> >  #include <linux/rtmutex.h>
> >> > +#include "../locking/rtmutex_common.h"
> >> >
> >> > 
> >//////////////////////////////////////////////////////////////////////////////
> >> >  //
> >> > --
> >> > 2.53.0
> >> >
> >> 
> >
> >
> 
> --- Thanks!
> "I'm not a very positive person" - Linus torvalds
