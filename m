Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C1BD260
	for <rcu@vger.kernel.org>; Tue,  5 Dec 2023 04:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXlXmQpE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81833C433C8;
	Tue,  5 Dec 2023 04:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701750181;
	bh=w/Bk/WJxSr5QEyyq9W+SD+SihawEDWaEohg5h1i0Keo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=QXlXmQpEo+Ca6kqEdj0E119zOei8gUzaGcyvM/woNAACeAgMFx1j8YPfzA88c+b8g
	 vq8ChUgWgOWJgC4k3fH+i6G9Mhsllxtmv2d9KV38726HJgsgm0SfIu4PjbgKOpltLR
	 cjlD+3/FD0oXuq/756f1M2DWWkm+uzUu1NGQaJjZYC13FURwHC8Lp6Ev/x6QqbmzyP
	 nihuFqb+9BTzns40owbm2R6fAYgmWVmITsujhlm6Nuiar4JlOrY6QpoSnmItuKZlCF
	 prZdQpz/dUtXD0bs3SZ+0r22y9m0Ise5qsLcmcq0gbQXMZrswjcxCwE/gQrcY3oxa8
	 tArufEqBFyKfQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 14277CE1147; Mon,  4 Dec 2023 20:23:01 -0800 (PST)
Date: Mon, 4 Dec 2023 20:23:01 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	John Ogness <john.ogness@linutronix.de>,
	Josh Triplett <josh@joshtriplett.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH v2] srcu: Use try-lock lockdep annotation for NMI-safe
 access.
Message-ID: <ff0b1784-f793-408f-b41c-e9521e9cb925@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231121123315.egrgopGN@linutronix.de>
 <ZV5Dhjcb9Jd_lk0O@boqun-archlinux>
 <20231130132729.niM5FJPc@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130132729.niM5FJPc@linutronix.de>

On Thu, Nov 30, 2023 at 02:27:29PM +0100, Sebastian Andrzej Siewior wrote:
> It is claimed that srcu_read_lock_nmisafe() NMI-safe. However it
> triggers a lockdep if used from NMI because lockdep expects a deadlock
> since nothing disables NMIs while the lock is acquired.
> 
> This is because commit f0f44752f5f61 ("rcu: Annotate SRCU's update-side
> lockdep dependencies") annotates synchronize_srcu() as a write lock
> usage. This helps to detect a deadlocks such as
> 	srcu_read_lock();
> 	synchronize_srcu();
> 	srcu_read_unlock();
> 
> The side effect is that the lock srcu_struct now has a USED usage in normal
> contexts, so it conflicts with a USED_READ usage in NMI. But this shouldn't
> cause a real deadlock because the write lock usage from synchronize_srcu() is a
> fake one and only used for read/write deadlock detection.
> 
> Use a try-lock annotation for srcu_read_lock_nmisafe() to avoid lockdep
> complains if used from NMI.
> 
> Fixes: f0f44752f5f61 ("rcu: Annotate SRCU's update-side lockdep dependencies")
> Link: https://lore.kernel.org/r/20230927160231.XRCDDSK4@linutronix.de
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Queued for v6.9 along with further review and testing, thank you both!

							Thanx, Paul

> ---
>  include/linux/rcupdate.h | 6 ++++++
>  include/linux/srcu.h     | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index f7206b2623c98..31d523c4e0893 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -301,6 +301,11 @@ static inline void rcu_lock_acquire(struct lockdep_map *map)
>  	lock_acquire(map, 0, 0, 2, 0, NULL, _THIS_IP_);
>  }
>  
> +static inline void rcu_try_lock_acquire(struct lockdep_map *map)
> +{
> +	lock_acquire(map, 0, 1, 2, 0, NULL, _THIS_IP_);
> +}
> +
>  static inline void rcu_lock_release(struct lockdep_map *map)
>  {
>  	lock_release(map, _THIS_IP_);
> @@ -315,6 +320,7 @@ int rcu_read_lock_any_held(void);
>  #else /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
>  
>  # define rcu_lock_acquire(a)		do { } while (0)
> +# define rcu_try_lock_acquire(a)	do { } while (0)
>  # define rcu_lock_release(a)		do { } while (0)
>  
>  static inline int rcu_read_lock_held(void)
> diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> index 127ef3b2e6073..236610e4a8fa5 100644
> --- a/include/linux/srcu.h
> +++ b/include/linux/srcu.h
> @@ -229,7 +229,7 @@ static inline int srcu_read_lock_nmisafe(struct srcu_struct *ssp) __acquires(ssp
>  
>  	srcu_check_nmi_safety(ssp, true);
>  	retval = __srcu_read_lock_nmisafe(ssp);
> -	rcu_lock_acquire(&ssp->dep_map);
> +	rcu_try_lock_acquire(&ssp->dep_map);
>  	return retval;
>  }
>  
> -- 
> 2.43.0
