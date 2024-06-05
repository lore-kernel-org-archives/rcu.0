Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAF64597F;
	Wed,  5 Jun 2024 16:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717605311; cv=none; b=q21o+Oz8sE4na/efb0fYXnFC/RRU+FTObCfz3pJowIo7NMlXtlh67ytoIt1SqCoQs3V6ldimRjeequDPsaqs7I4ptmYE8qwVP5np0yFKF7RlZGy566GkqhQ/yLSGvmIcIquiJ81E6WvW9N9qI7dFDebfJD4fDO+LVPKuZeA+CSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717605311; c=relaxed/simple;
	bh=2KuSsaKXTNHgkouNSkG4Qp+rofK0s/fRScz5+SCz+SI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9uLwARjF1iRp9g6lbI7sFQBKGTmzreA7vlH3otcx5oTy5eVTnwBAYhQ09GdKOqLC+80Z9KXZGdyQ8hoOnCyWgB/6QcU5ZhS72BVfMf12YklnjryvD3anhBDb5PyfU+CpbZhdnMJBG6qe8EHa++Jm/neOytEINEXIDVwrsE6M/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oe4Ahymt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oe4Ahymt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B11DEC2BD11;
	Wed,  5 Jun 2024 16:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717605311;
	bh=2KuSsaKXTNHgkouNSkG4Qp+rofK0s/fRScz5+SCz+SI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oe4AhymtSyoh4SP5trnuytnjt/ENoZKLqME99OVLimkK2c0lSnwrZ3MmChFpexT3L
	 jghK3JU5YxdC2QyQDQny0m6PqCjCZ7RUjbOErmrzJ382LF1zjqjfcKnfXP3U4xBaOa
	 KzN0keoabeNgPbg+3tqGIOCIKF/qNjiSzIK46RbZj7gh8nmKQDp0b6ePVQtntvbVq3
	 xceYqKeRWXlxgFUPIJc1osPa3r8GTDvcpu1JX/U4KsobuwmGNjTtCp8sKShFcghtmU
	 /7sT05SVFFrr1SdPbkMtF6ac5buYCBjHlFf86k33lQRxMaFRUnyUBsJENCknJgWgHZ
	 8ZDxq/sH/B8rA==
Date: Wed, 5 Jun 2024 18:35:08 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH rcu 3/9] rcu/tree: Reduce wake up for synchronize_rcu()
 common case
Message-ID: <ZmCTvMVlOMFv0-zd@localhost.localdomain>
References: <657595c8-e86c-4594-a5b1-3c64a8275607@paulmck-laptop>
 <20240604222355.2370768-3-paulmck@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240604222355.2370768-3-paulmck@kernel.org>

Le Tue, Jun 04, 2024 at 03:23:49PM -0700, Paul E. McKenney a écrit :
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> 
> In the synchronize_rcu() common case, we will have less than
> SR_MAX_USERS_WAKE_FROM_GP number of users per GP. Waking up the kworker
> is pointless just to free the last injected wait head since at that point,
> all the users have already been awakened.
> 
> Introduce a new counter to track this and prevent the wakeup in the
> common case.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  kernel/rcu/tree.c | 35 ++++++++++++++++++++++++++++++-----
>  kernel/rcu/tree.h |  1 +
>  2 files changed, 31 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 6ba36d9c09bde..2fe08e6186b4d 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -96,6 +96,7 @@ static struct rcu_state rcu_state = {
>  	.ofl_lock = __ARCH_SPIN_LOCK_UNLOCKED,
>  	.srs_cleanup_work = __WORK_INITIALIZER(rcu_state.srs_cleanup_work,
>  		rcu_sr_normal_gp_cleanup_work),
> +	.srs_cleanups_pending = ATOMIC_INIT(0),
>  };
>  
>  /* Dump rcu_node combining tree at boot to verify correct setup. */
> @@ -1633,8 +1634,11 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
>  	 * the done tail list manipulations are protected here.
>  	 */
>  	done = smp_load_acquire(&rcu_state.srs_done_tail);
> -	if (!done)
> +	if (!done) {
> +		/* See comments below. */
> +		atomic_dec_return_release(&rcu_state.srs_cleanups_pending);

This condition is not supposed to happen. If the work is scheduled,
there has to be a wait_queue in rcu_state.srs_done_tail. And decrementing
may make things worse.

So this should be:

if (WARN_ON_ONCE(!done))
   return;

Thanks.
