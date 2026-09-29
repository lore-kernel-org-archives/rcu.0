Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B093346ADB;
	Tue, 29 Sep 2026 21:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790716131; cv=none; b=DzO8+hFFL4LfNOBZWGYjSjVdHjnpR8jvUgaXy/kJEAPwniuYcXDagZ+GfHBq9AmzsvyGZGs7qu9QFrx0QkRP5AIpl694DwEffUFh4jKxYhvZgL/zQshzCk64Uao3P07VhaL4NLdEKGodlYdw+JVFFJvmg2m0m6OyF34vMeVah0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790716131; c=relaxed/simple;
	bh=Rcle1RfrXoUDDsEtZLmd3Xq59yJgYo591UbG5mYPoT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nz+60KpKvEmgR4b1wZYCqgMMoiA/8HJVKR7gxyOniolRTvzidWSHrDtcrWO7U7g+bHUGjFK81yzg1pQtr7c028A6hT9rRv6bXIJnwMTmaj37jMQJ80WKCnPZN23V1yfzCIqr3rSqnijWETCf6ddRurRz67KwFo839zpS3qB4948=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHxMPHuF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHxMPHuF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF3AA1F000FF;
	Tue, 29 Sep 2026 21:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790716129;
	bh=srXOeu/qQSWIsTqBxOcBsANQtUB3iwO67FbpUlNBj1E=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=bHxMPHuFvJYAaEwFVY2ah+9rC2ec1m5pkB2YI2AZirnKg6FNwKf1OVNeAZUjcEO3h
	 sSwCJeNtv4leK00YhUIZk3+Z2qaW2Nvh4ExTbwF3DSAb9kXSWeTkPNtnDc5WyTbrpd
	 F/cZMFdMmYbpkVxvJ+QkJjvtEWHocb0o8DDaaMoq5WJIi1nFl7XDIhiWMKailalWiF
	 sPD+1Or9uai/ihSWpO4sw9CJz4hlj6FKk1E/SGxkFUVv7hfPRsFlg7tEwud6BHyMUS
	 5raI89SJMy5MkGTru8VG9xX/q3C7EVMw++esKS2yujpQeaxxr6kxYB2Ug/l1w2xzht
	 nVToTVySg7M+A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A98DDCE3A57; Tue, 29 Sep 2026 14:08:49 -0700 (PDT)
Date: Tue, 29 Sep 2026 14:08:49 -0700
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
Message-ID: <0fbaa5c5-3f75-4fd2-8537-0576eb11abbe@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260925133922.1356404-1-arnd@kernel.org>
 <CAN_Opa8F+vKAAckVi0+qi_yXrav7Dop5brpS=zr7Hw-XaAUL2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN_Opa8F+vKAAckVi0+qi_yXrav7Dop5brpS=zr7Hw-XaAUL2w@mail.gmail.com>

On Mon, Sep 28, 2026 at 10:54:13AM +0800, KunWu Chan wrote:
> Thanks, Arnd.
> 
> Tested on top of 1eccf02fb8d5 with CONFIG_PREEMPT_RCU=y:
> 
> CONFIG_RT_MUTEXES=y: build passes
> CONFIG_RT_MUTEXES=n: fails without this patch, passes with it
> 
> The failure is in tree_stall.h, where rt_mutex_owner() is used
> before tree_plugin.h includes rtmutex_common.h. This matches the
> reported failure, and the added include fixes it.
> 
> Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
> Tested-by: Kunwu Chan <kunwu.chan@gmail.com>

Bradley and Kunwu, are you OK with my applying your tags to the commit
that I am merging this into?

1eccf02fb8d5 ("rcu: Add running and boosted indications to RCU task stall dump")

							Thanx, Paul

> Thanks,
> Kunwu
> 
> On Fri, Sep 25, 2026 at 9:39 PM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > The added call to rt_mutex_owner() makes this fail to build in
> > some configurations:
> >
> > In file included from kernel/rcu/tree.c:5121:
> > kernel/rcu/tree_stall.h:333:8: error: call to undeclared function 'rt_mutex_owner'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
> >   333 |                         if (rt_mutex_owner(&rnp->boost_mtx.rtmutex) == t)
> >       |                             ^
> > kernel/rcu/tree_stall.h:333:48: error: comparison between pointer and integer ('int' and 'struct task_struct *') [-Werror,-Wpointer-integer-compare]
> >   333 |                         if (rt_mutex_owner(&rnp->boost_mtx.rtmutex) == t)
> >       |                             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^  ~
> > In file included from kernel/rcu/tree.c:5124:
> > In file included from kernel/rcu/tree_plugin.h:14:
> > kernel/rcu/../locking/rtmutex_common.h:231:35: error: conflicting types for 'rt_mutex_owner'
> >   231 | static inline struct task_struct *rt_mutex_owner(struct rt_mutex_base *lock)
> >       |                                   ^
> > kernel/rcu/tree_stall.h:333:8: note: previous implicit declaration is here
> >   333 |                         if (rt_mutex_owner(&rnp->boost_mtx.rtmutex) == t)
> >       |                             ^
> >
> > There are already a couple of inclusions of "../locking/rtmutex_common.h",
> > so assume this is safe to do here.
> >
> > Fixes: 1eccf02fb8d5 ("rcu: Add running and boosted indications to RCU task stall dump")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > I wonder if it would be better to either move the rt_mutex_owner()
> > definition into a global header like include/linux/rtmutex.h, or to
> > move the code out of tree_stall.h into a .c file, as this feels like a
> > layering violation.
> > ---
> >  kernel/rcu/tree_stall.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> > index 5dded1e89197..803a56af3259 100644
> > --- a/kernel/rcu/tree_stall.h
> > +++ b/kernel/rcu/tree_stall.h
> > @@ -12,6 +12,7 @@
> >  #include <linux/rcu_notifier.h>
> >  #include <linux/smp.h>
> >  #include <linux/rtmutex.h>
> > +#include "../locking/rtmutex_common.h"
> >
> >  //////////////////////////////////////////////////////////////////////////////
> >  //
> > --
> > 2.53.0
> >
> 
