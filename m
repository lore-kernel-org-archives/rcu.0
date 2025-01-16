Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BE822BAB7;
	Thu, 16 Jan 2025 16:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737043424; cv=none; b=RhXYa90GlVnCt42mqYTCqHu9DrLegaXM+9xYTT69cFcJ5u1G+yN/oK/o2N/GM9uuh0dkr4ol2ApdTyEt3HoReZXIOq6zM9Q2ortxGcU0q1P+ncPsFmaAqocHPmNhwlBOpULW5Y2AjXQRRSIcHMQTm5FxLJVZSjtXDG6AeLAy4v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737043424; c=relaxed/simple;
	bh=QcJl9SXQ6in13mauO1RfoQd6DWsHPd60WU6GdWuedCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qb+pRS0iuNC8MHtZeygN8Cr23G81jmRYi/YuqOhYdQRhubLo4UUL9Q/hqHenOCmMTQ4vyLD6c9GEdHNuwPfuOSwE3cvKKEZJoUR0Cztw4UsSrIWCDxVTrV6q+jWAZSqoNCmM+o5Kb5XJnPDLuXNRPBr6XNnh1Jy41UexvyEWsas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dUd1DrQk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dUd1DrQk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE5AC4CED6;
	Thu, 16 Jan 2025 16:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737043423;
	bh=QcJl9SXQ6in13mauO1RfoQd6DWsHPd60WU6GdWuedCg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=dUd1DrQkZZRMltIHzpAB/2/YNkZpdC1QBePNzOwQ5aPT0meTuSfN9KYEUnoVhL5b+
	 gpsU73rzwFUHNy37p2qMMaP16HkSTBQA/5DfZtYKD0xjHwn8oNx9CjE9AS2rmbqVQV
	 rilJoF5+6RQp5u27PUE0S35GQJ9bQpzSn5ZIeCMD4zVlwqD4juD+Q2OfSXXUWWSDgC
	 1A8Ep+w9a7ViKluU9mYLXnZU2LQOxk6/+udeBTyUXRi7KHje/rrxQ61fkAcyivjWER
	 IO8CW/P5RuaTTza7vq2gIyzrDdD6zByCq/5EAtvxRPxXR29NUzG0v+GvGKk4ghxmw4
	 EJNfH5S4ecwQg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4A315CE0C15; Thu, 16 Jan 2025 08:03:43 -0800 (PST)
Date: Thu, 16 Jan 2025 08:03:43 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] srcu: refactor __srcu_read_(un)lock_lite() declarations
Message-ID: <ce82b07d-84c5-4f9d-a3d4-87fdc3675307@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250114105215.4007622-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114105215.4007622-1-masahiroy@kernel.org>

On Tue, Jan 14, 2025 at 07:52:13PM +0900, Masahiro Yamada wrote:
> For CONFIG_TREE_SRCU, __srcu_read_(un)lock_lite() are defined as static
> inline functions in <linux/srcutree.h>. The later function declarations
> are redundant.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Hello, Masahiro, and thank you for the patch!

This part of the code has seen quite a bit of churn over the past month
or so.  So could you please rebase this patch on top of my -rcu tree's
"dev" branch?

git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git

							Thanx, Paul

> ---
> 
>  include/linux/srcu.h     | 9 ++-------
>  include/linux/srcutree.h | 4 ++--
>  2 files changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> index 08339eb8a01c..314f0bca6eb7 100644
> --- a/include/linux/srcu.h
> +++ b/include/linux/srcu.h
> @@ -45,6 +45,8 @@ int init_srcu_struct(struct srcu_struct *ssp);
>  
>  #ifdef CONFIG_TINY_SRCU
>  #include <linux/srcutiny.h>
> +#define __srcu_read_lock_lite __srcu_read_lock
> +#define __srcu_read_unlock_lite __srcu_read_unlock
>  #elif defined(CONFIG_TREE_SRCU)
>  #include <linux/srcutree.h>
>  #else
> @@ -56,13 +58,6 @@ void call_srcu(struct srcu_struct *ssp, struct rcu_head *head,
>  void cleanup_srcu_struct(struct srcu_struct *ssp);
>  int __srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp);
>  void __srcu_read_unlock(struct srcu_struct *ssp, int idx) __releases(ssp);
> -#ifdef CONFIG_TINY_SRCU
> -#define __srcu_read_lock_lite __srcu_read_lock
> -#define __srcu_read_unlock_lite __srcu_read_unlock
> -#else // #ifdef CONFIG_TINY_SRCU
> -int __srcu_read_lock_lite(struct srcu_struct *ssp) __acquires(ssp);
> -void __srcu_read_unlock_lite(struct srcu_struct *ssp, int idx) __releases(ssp);
> -#endif // #else // #ifdef CONFIG_TINY_SRCU
>  void synchronize_srcu(struct srcu_struct *ssp);
>  
>  #define SRCU_GET_STATE_COMPLETED 0x1
> diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> index 490aeecc6bb4..16a7d631c185 100644
> --- a/include/linux/srcutree.h
> +++ b/include/linux/srcutree.h
> @@ -219,7 +219,7 @@ void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf);
>   * or because it is a read-modify-write atomic operation, depending on
>   * the whims of the architecture.
>   */
> -static inline int __srcu_read_lock_lite(struct srcu_struct *ssp)
> +static inline int __srcu_read_lock_lite(struct srcu_struct *ssp) __acquires(ssp)
>  {
>  	int idx;
>  
> @@ -241,7 +241,7 @@ static inline int __srcu_read_lock_lite(struct srcu_struct *ssp)
>   * or because it is a read-modify-write atomic operation, depending on
>   * the whims of the architecture.
>   */
> -static inline void __srcu_read_unlock_lite(struct srcu_struct *ssp, int idx)
> +static inline void __srcu_read_unlock_lite(struct srcu_struct *ssp, int idx) __releases(ssp)
>  {
>  	barrier();  /* Avoid leaking the critical section. */
>  	this_cpu_inc(ssp->sda->srcu_unlock_count[idx].counter);  /* Z */
> -- 
> 2.43.0
> 
