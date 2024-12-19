Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B831990B7;
	Thu, 19 Dec 2024 17:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734630169; cv=none; b=qmkamANZF6KQm2SGjWz8pGNvOZdhwEF4C/BpGneCX69ku8COLkfAbHEmX7QH5HNeNFy35Ltzw8W1zc6/JQQPgKHFtJgHUYJlpq2SJx3nxwACxWkw+dMQ4gbSzaBDYO5CpWrWYZ1V6s14ya6AGomPpN8NdF176PdQ+ut6lnPd8Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734630169; c=relaxed/simple;
	bh=HK7JNwXL/xB9g/FsOmIS2A3THkBfyW0J3XVnNDgBtyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0z6oFnuxBzfaCw11awwOEFFrIWektviatYPixILV0R3jT0L1aqVGVNK+hzNJckiC3U7rt9HFUCK+Xxme8Q+ngwpiE8lXFBSoso3zN68owelCd52+2uhmyjPoXFQAn781ldqUSknjdeEG6lpdgdpV8lLM9nj5CElLfzXOQjzV08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R137QEhl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R137QEhl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B50B3C4CED0;
	Thu, 19 Dec 2024 17:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734630168;
	bh=HK7JNwXL/xB9g/FsOmIS2A3THkBfyW0J3XVnNDgBtyk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=R137QEhlE7JHZUV8Gi52jMqhAAjgkTSLdF2ewqH0kgNx+cTqd2tdngbd+Hmo9UuFU
	 TFjpyASy1e3x5VUbvNHsiY4/ri1gWsawf6QCYgioh13iZx9lKpOuezd5JEXYj83HqR
	 C7Kuxw1qGCI1wwvqZvlT4np2IA0qnsQpCytXyzANq2hEa/Hav7K9qej0Fhuk+S3QUi
	 4Uhh7o2St2m6p7aGAu6hAsEvdmOToWQmJsOOnySkpRcX+vw7D7bIJgN8hwvpUk7wsV
	 wynTkcg7KrO9rPCQDL9G5zpcgXnZeXZloAbVb4UoY6707EAXNj5LcWzUW7idHi+XcQ
	 LxMt7RLh3VoaQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6151FCE089D; Thu, 19 Dec 2024 09:42:48 -0800 (PST)
Date: Thu, 19 Dec 2024 09:42:48 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>, vlad.wing@gmail.com,
	rcu@vger.kernel.org, boqun.feng@gmail.com, joel@joelfernandes.org,
	neeraj.upadhyay@amd.com, urezki@gmail.com,
	qiang.zhang1211@gmail.com, Cheng-Jui.Wang@mediatek.com,
	leitao@debian.org, kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [PATCH 0/3] hrtimer: Fix timers queued locally from offline CPUs
Message-ID: <7d19b58a-2cd2-4c29-8596-f0cda605112f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20241218165008.37820-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241218165008.37820-1-frederic@kernel.org>

On Wed, Dec 18, 2024 at 05:50:05PM +0100, Frederic Weisbecker wrote:
> 5c0930ccaad5 ("hrtimers: Push pending hrtimers away from outgoing CPU earlier")
> was introduced to fix stalls with scheduler bandwidth timers getting
> migrated while some kthreads handling CPU hotplug rely on bandwidth.
> 
> However this has introduced several other issues which used to be
> confined to RCU. But not anymore as it is spreading to hotplug code
> itself (https://lore.kernel.org/all/20241213203739.1519801-1-usamaarif642@gmail.com/)
> 
> Instead of introducing yet another new hackery, fix the problem in
> hrtimers for everyone.

The good news is that this passes 12 hours of 400*TREE03.  (Yay!!!)

The so-so news is that this gives only about 70% confidence that these
patches help, but on the other hand, it also gives much higher confidence
that these patches are not hurting anything.

At least for TREE03.

The not-so-good news is that this series causes build failures for
rcutorture scenarios (such as SRCU-T) that build with CONFIG_SMP=n:

------------------------------------------------------------------------
kernel/time/hrtimer.c: In function ‘enqueue_hrtimer_offline’:
kernel/time/hrtimer.c:1229:42: error: ‘migration_base’ undeclared (first use in this function); did you mean ‘is_migration_base’?
------------------------------------------------------------------------

When built with KCSAN enabled (--kcsan to kvm.sh), there is this
additional build failure on that same line of code:

------------------------------------------------------------------------
kernel/time/hrtimer.c:1229:3: error: incompatible pointer types assigning to 'volatile typeof (timer->base)' (aka 'struct hrtimer_clock_base *volatile') from 'bool (*)(struct hrtimer_clock_base *)' (aka '_Bool (*)(struct hrtimer_clock_base *)') [-Werror,-Wincompatible-pointer-types]

 1229 |                 WRITE_ONCE(timer->base, &migration_base);
------------------------------------------------------------------------

Me, I am a bit surprised that enqueue_hrtimer_offline() is even built
in a CONFIG_SMP=n kernel.

But there might be some reason why #ifdef-ing out that function's body
would be a bad idea, so over to you!  ;-)

							Thanx, Paul

> Frederic Weisbecker (3):
>   hrtimers: Force migrate away hrtimers queued after
>     CPUHP_AP_HRTIMERS_DYING
>   rcu: Remove swake_up_one_online() bandaid
>   Revert "rcu/nocb: Fix rcuog wake-up from offline softirq"
> 
>  include/linux/hrtimer_defs.h |  1 +
>  kernel/rcu/tree.c            | 34 +-------------------
>  kernel/rcu/tree_exp.h        |  2 +-
>  kernel/rcu/tree_nocb.h       | 10 ++----
>  kernel/time/hrtimer.c        | 60 +++++++++++++++++++++++++++++++-----
>  5 files changed, 58 insertions(+), 49 deletions(-)
> 
> -- 
> 2.46.0
> 
