Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CCC46D572;
	Tue, 29 Sep 2026 21:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790716050; cv=none; b=DbmgAC2pXr8/do4Tw6kR+WPXvplOiWmuS1gvqWqDtSWHdA958y75qactadULhwtIjSdPlfTMzwQSy+3vo2eTF1T2knqa3/Bh3MZyvgrn2n6/AAPW3W8+2oKG04tXVH2pUBTrdZk6UWOoXgcm5p9pmCXmQGU590gl+pf1jl8Q+Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790716050; c=relaxed/simple;
	bh=mQkyD0uRRPxvlpUvAn0NzuxTKFDk0eq5Tok2NBCJYqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HoMRyOVlM+pfPNuAIuxjwS0x5gq0SAX8/iiVO1csqFFa3WMMQT0WSAWnFKSw75PR3/XPJ0sFrv7GxKtIGEkVPMuTeSY4GeimlxRdEJWLq5ubK5NN8rbbpsxrqxVAGq8LgnjX4EAPLtS6dad//rTe2Wv6WPpDJMpP06x3IJJXKIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L24oDAjm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L24oDAjm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E75551F000FF;
	Tue, 29 Sep 2026 21:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790716042;
	bh=i9fJttK6+QMYUHs1bQ18A+MCmMfxPcettA2nwtR9QNQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=L24oDAjm0SaDT6aP9yKy/wL223maMyenlOq1iKvz6z/H6CGJmiKzWrl7lALDUlP0+
	 1BRc9PzMxJtxlH8ftQjPjX9XUiJo+6QMsx35nhC6kqcA1016Gu0F2eOEaAaCFTzGgK
	 Mzwtaxw8+MBaAEmZZiV0xqyoFA0XpNy7BAVN4CxoDFOeHKL1xEerKCHkWDGEiRY/Ti
	 xlwbxbDK7d4h4bhXv6A9yUgc8EcPCg5K3p807Kzv5OCefUoQyYwE3XvzYpkkGyPBGl
	 Mkl80uif5x2j9FtJPE8PrSV0hkyEetElBiLKlPiNpEa/px2mS7c9ZdCMrd43jdLSit
	 tw1PfUJEYkgEA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id AFFCACE3A57; Tue, 29 Sep 2026 14:07:21 -0700 (PDT)
Date: Tue, 29 Sep 2026 14:07:21 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
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
	Gustavo Luiz Duarte <gustavold@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: include rtmutex_common.h in tree_stall.h
Message-ID: <21dd141a-03d7-49e6-a83b-f4dda898cedf@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260925133922.1356404-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925133922.1356404-1-arnd@kernel.org>

On Fri, Sep 25, 2026 at 03:39:04PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The added call to rt_mutex_owner() makes this fail to build in
> some configurations:
> 
> In file included from kernel/rcu/tree.c:5121:
> kernel/rcu/tree_stall.h:333:8: error: call to undeclared function 'rt_mutex_owner'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>   333 |                         if (rt_mutex_owner(&rnp->boost_mtx.rtmutex) == t)
>       |                             ^
> kernel/rcu/tree_stall.h:333:48: error: comparison between pointer and integer ('int' and 'struct task_struct *') [-Werror,-Wpointer-integer-compare]
>   333 |                         if (rt_mutex_owner(&rnp->boost_mtx.rtmutex) == t)
>       |                             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^  ~
> In file included from kernel/rcu/tree.c:5124:
> In file included from kernel/rcu/tree_plugin.h:14:
> kernel/rcu/../locking/rtmutex_common.h:231:35: error: conflicting types for 'rt_mutex_owner'
>   231 | static inline struct task_struct *rt_mutex_owner(struct rt_mutex_base *lock)
>       |                                   ^
> kernel/rcu/tree_stall.h:333:8: note: previous implicit declaration is here
>   333 |                         if (rt_mutex_owner(&rnp->boost_mtx.rtmutex) == t)
>       |                             ^
> 
> There are already a couple of inclusions of "../locking/rtmutex_common.h",
> so assume this is safe to do here.
> 
> Fixes: 1eccf02fb8d5 ("rcu: Add running and boosted indications to RCU task stall dump")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I wonder if it would be better to either move the rt_mutex_owner()
> definition into a global header like include/linux/rtmutex.h, or to
> move the code out of tree_stall.h into a .c file, as this feels like a
> layering violation.

Good catch, and thank you!!!

What I am going to do in the name of bisectability is to merge this into
the commit that added that call to rt_mutex_owner(), which attribution:

1eccf02fb8d5 ("rcu: Add running and boosted indications to RCU task stall dump")

I am also removing the #include of that same file from it old place in
kernel/rcu/tree_plugin.h, where it has lived since 2014.

But you are right that this is the only #include of that file outside
of kernel/locking.

Fair enough?

							Thanx, Paul

> ---
>  kernel/rcu/tree_stall.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index 5dded1e89197..803a56af3259 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -12,6 +12,7 @@
>  #include <linux/rcu_notifier.h>
>  #include <linux/smp.h>
>  #include <linux/rtmutex.h>
> +#include "../locking/rtmutex_common.h"
>  
>  //////////////////////////////////////////////////////////////////////////////
>  //
> -- 
> 2.53.0
> 
