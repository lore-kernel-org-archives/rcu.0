Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF2131E84B;
	Fri,  2 Oct 2026 15:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790956090; cv=none; b=TyQz3/X+oohhrnVXPkQkTVcf/Iw1BpaKeoR4QGOdM2RTHN/DY0l5mWH/s1xUxYB1QOI380KLPTpztuSBFDXhcDKW0K28qEuJuUCP47DEBHKPQa3WN6bfsA2DL7YnAlpRThBlkD4YxZqFVk3J6CMMWjPewXx2Epx+aFMeEqLs9TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790956090; c=relaxed/simple;
	bh=dwjHhdEKctdoDHuGMx5cnYjVxfRNxVKO6+JjXJcp1c8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4zl/e+CZdpLHGV/KL5uclgBEQU37KKvyOi0Khsb7YUo9/mc/0oPirSijvnhu1WdLt1Xu3LmrzSL5z+4pD/QeBAQBIGHuAJwiLqePAON6Rm7e+8KoL/+Ge6awLor9o7eQZuEmZPLS83f+LaUU/QxQuHrYgkwL/wZ9a2KVYn8QU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gcTyAC0z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gcTyAC0z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C607A1F000FF;
	Fri,  2 Oct 2026 15:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790956088;
	bh=jAmZLxuL9ir3PEtj3rA1r4owUMOfT1l0y0uNhmkuhl8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=gcTyAC0zm7Nk9fjh4H0sR70amlpKYko/ntM0BGwcFp5wNEmRnA6WDu2U0cb7ttyzD
	 UjuGN5tGCC3Q1uFYBKT+FVVU3oOYzXf1qsKhbdx7MnL/5l6OPct9mZ5Kd+PnsA/M9G
	 a7tfAnx8YV6sBf0YXA+mD9H9OI4MoorQoMQQn9v91HXjydU00zZflw5JHhFtVZ2wun
	 6QwucuCAQjkp8Z2aPMmLkobi78rON68sv9Zh9L2SWZJLN3N1UddwXmp/XUxWBSLsE6
	 OI8LGARAw6wvbBH3VIb8r1q06EF9UloxrwpMvyeIPK0sMuasMAgcoODagohL74gR7n
	 MhjkTmV05EYOg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8AC91CE09FC; Fri,  2 Oct 2026 08:48:08 -0700 (PDT)
Date: Fri, 2 Oct 2026 08:48:08 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: KunWu Chan <kunwu.chan@gmail.com>
Cc: Arnd Bergmann <arnd@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Thomas Gleixner <tglx@kernel.org>,
	Tejun Heo <tj@kernel.org>, Andrea Righi <arighi@nvidia.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Gustavo Luiz Duarte <gustavold@gmail.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: include rtmutex_common.h in tree_stall.h
Message-ID: <3cd5f02f-e799-4681-8d2c-1f4f12d9740a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260925133922.1356404-1-arnd@kernel.org>
 <CAN_Opa8F+vKAAckVi0+qi_yXrav7Dop5brpS=zr7Hw-XaAUL2w@mail.gmail.com>
 <0fbaa5c5-3f75-4fd2-8537-0576eb11abbe@paulmck-laptop>
 <CAN_Opa9XhfVcvjCOa_Ay+zw+HpQMKEqsnBcTpNS6p5MVa5u5Jw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN_Opa9XhfVcvjCOa_Ay+zw+HpQMKEqsnBcTpNS6p5MVa5u5Jw@mail.gmail.com>

On Fri, Oct 02, 2026 at 02:36:18PM +0800, KunWu Chan wrote:
> On Wed, Sep 30, 2026 at 5:08 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Mon, Sep 28, 2026 at 10:54:13AM +0800, KunWu Chan wrote:
> > > Thanks, Arnd.
> > >
> > > Tested on top of 1eccf02fb8d5 with CONFIG_PREEMPT_RCU=y:
> > >
> > > CONFIG_RT_MUTEXES=y: build passes
> > > CONFIG_RT_MUTEXES=n: fails without this patch, passes with it
> > >
> > > The failure is in tree_stall.h, where rt_mutex_owner() is used
> > > before tree_plugin.h includes rtmutex_common.h. This matches the
> > > reported failure, and the added include fixes it.
> > >
> > > Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
> > > Tested-by: Kunwu Chan <kunwu.chan@gmail.com>
> >
> > Bradley and Kunwu, are you OK with my applying your tags to the commit
> > that I am merging this into?
> >
> > 1eccf02fb8d5 ("rcu: Add running and boosted indications to RCU task stall dump")
> 
> Sure. Thanks, Paul.

Thank you, and I will apply them on my next rebase.

							Thanx, Paul

> Kunwu
> 
> > > Thanks,
> > > Kunwu
> > >
> > > On Fri, Sep 25, 2026 at 9:39 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > > >
> > > > From: Arnd Bergmann <arnd@arndb.de>
> > > >
> > > > The added call to rt_mutex_owner() makes this fail to build in
> > > > some configurations:
> > > >
> > > > In file included from kernel/rcu/tree.c:5121:
> > > > kernel/rcu/tree_stall.h:333:8: error: call to undeclared function 'rt_mutex_owner'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
> > > >   333 |                         if (rt_mutex_owner(&rnp->boost_mtx.rtmutex) == t)
> > > >       |                             ^
> > > > kernel/rcu/tree_stall.h:333:48: error: comparison between pointer and integer ('int' and 'struct task_struct *') [-Werror,-Wpointer-integer-compare]
> > > >   333 |                         if (rt_mutex_owner(&rnp->boost_mtx.rtmutex) == t)
> > > >       |                             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^  ~
> > > > In file included from kernel/rcu/tree.c:5124:
> > > > In file included from kernel/rcu/tree_plugin.h:14:
> > > > kernel/rcu/../locking/rtmutex_common.h:231:35: error: conflicting types for 'rt_mutex_owner'
> > > >   231 | static inline struct task_struct *rt_mutex_owner(struct rt_mutex_base *lock)
> > > >       |                                   ^
> > > > kernel/rcu/tree_stall.h:333:8: note: previous implicit declaration is here
> > > >   333 |                         if (rt_mutex_owner(&rnp->boost_mtx.rtmutex) == t)
> > > >       |                             ^
> > > >
> > > > There are already a couple of inclusions of "../locking/rtmutex_common.h",
> > > > so assume this is safe to do here.
> > > >
> > > > Fixes: 1eccf02fb8d5 ("rcu: Add running and boosted indications to RCU task stall dump")
> > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > > ---
> > > > I wonder if it would be better to either move the rt_mutex_owner()
> > > > definition into a global header like include/linux/rtmutex.h, or to
> > > > move the code out of tree_stall.h into a .c file, as this feels like a
> > > > layering violation.
> > > > ---
> > > >  kernel/rcu/tree_stall.h | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> > > > index 5dded1e89197..803a56af3259 100644
> > > > --- a/kernel/rcu/tree_stall.h
> > > > +++ b/kernel/rcu/tree_stall.h
> > > > @@ -12,6 +12,7 @@
> > > >  #include <linux/rcu_notifier.h>
> > > >  #include <linux/smp.h>
> > > >  #include <linux/rtmutex.h>
> > > > +#include "../locking/rtmutex_common.h"
> > > >
> > > >  //////////////////////////////////////////////////////////////////////////////
> > > >  //
> > > > --
> > > > 2.53.0
> > > >
> > >
