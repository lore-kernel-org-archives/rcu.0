Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9FD43B6F2;
	Mon,  6 Jul 2026 18:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783363491; cv=none; b=fAAA3lTMedZJcrk3NRHMZINsEfNkSuEXnBK4FnJa/a4sRuXiM1LYwPWoakN3/3PhhOY4LE6H2TEyTaHDwAD0774sXkc6kqJbB+Ekn0OLOH0G2EVR5moWtdE68XeK43DQ77sQHUMsUSPw3kxT46KzNDyj3oliD2UnTEPuveH+3pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783363491; c=relaxed/simple;
	bh=tO3pSYLeEh7fuUVV9V3uMo6MPqqwNyZ32fVvV9taMVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9c8slqKrYsQ1WAROj19wnDBSri+gBurQFRGy0iGYh6VL8t/iHby3M/GvQPnpwOHs0yUmduCCL1yI5xRkw0h+4papjFPGFH2JgZD11pWUl/Ch0oRtNKOyLZYT7qE1+QfC5I9FMoLut2ea4K9w9Aa1yxfqLGJpnyCtkvRl1mC16I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXsflgzU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXsflgzU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 371591F00A3D;
	Mon,  6 Jul 2026 18:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783363488;
	bh=ZREOZdpsHPiSHmYUnFHZ9b6SRkXlIZRcahu/PfaJh5E=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=VXsflgzUwfix8W7Xj3SPnj95qT3wBQkczfP/7XPPCCHJTEtbBbO7L0cWI52mwQGZF
	 5gW99WxCWJC7pTauBVMh0jbnt1sbY0f+GSC4j8NhvltHzGy5kSUv/zG6qOE12jE1bF
	 4bZ4PRAVo9n9lip5FwiVVIBn0QIkxiqM7Qbh4QvkD/QqB25H9fvHf1p34PI0R8htNb
	 vTXwxLIsreq18kQPKLCn7PknxFaUGxuzRLn1xbwiOlCUj9ooyKXb5I3KetgZU70Vun
	 n4NpJAUkyFCKCN1KiX05nu76cmaszY54G1tR/jFlp1UYPny+COG1f4+PHJdTXCGHQS
	 AhxiyKT858pfQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id F0E4BCE08AF; Mon,  6 Jul 2026 11:44:47 -0700 (PDT)
Date: Mon, 6 Jul 2026 11:44:47 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zqiang <qiang.zhang@linux.dev>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
	urezki@gmail.com, boqun@kernel.org, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu-tasks: Remove unused struct
 rcu_tasks's->n_ipis_fails variables
Message-ID: <cb922347-ff9c-407e-a774-054e0117ac52@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260706100310.19735-1-qiang.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706100310.19735-1-qiang.zhang@linux.dev>

On Mon, Jul 06, 2026 at 06:03:09PM +0800, Zqiang wrote:
> The RCU tasks trace has been reimplemented by 'commit c27cea4416a3
> ("rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast")', the
> rcu_tasks structure's->n_ipis_fails is no longer used, this commit
> therefore remove it.
> 
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>

I have queued both for review and testing, thank you!

This patch produced the expected result in my initial tests.  However,
for the second patch, I used this command to force a stall:

tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 15 --configs "TASKS01 TASKS02 TASKS03 RUDE01" --bootargs "rcutorture.stall_cpu=660" --trust-make

Except I got vanilla RCU CPU stall warnings, but not RCU Tasks nor
RCU Tasks Rude stall warnings.  And not even the "grace period number"
pre-stall message.  Probably because I am forgetting something.  But what
did you do to test your change?

							Thanx, Paul

> ---
>  kernel/rcu/tasks.h | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index f4da5fad70f5..7f7d1e636217 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -67,7 +67,6 @@ struct rcu_tasks_percpu {
>   * @gp_start: Most recent grace-period start in jiffies.
>   * @tasks_gp_seq: Number of grace periods completed since boot in upper bits.
>   * @n_ipis: Number of IPIs sent to encourage grace periods to end.
> - * @n_ipis_fails: Number of IPI-send failures.
>   * @kthread_ptr: This flavor's grace-period/callback-invocation kthread.
>   * @lazy_jiffies: Number of jiffies to allow callbacks to be lazy.
>   * @pregp_func: This flavor's pre-grace-period function (optional).
> @@ -102,7 +101,6 @@ struct rcu_tasks {
>  	unsigned long gp_start;
>  	unsigned long tasks_gp_seq;
>  	unsigned long n_ipis;
> -	unsigned long n_ipis_fails;
>  	struct task_struct *kthread_ptr;
>  	unsigned long lazy_jiffies;
>  	rcu_tasks_gp_func_t gp_func;
> @@ -735,12 +733,12 @@ static void show_rcu_tasks_generic_gp_kthread(struct rcu_tasks *rtp, char *s)
>  		if (havecbs && haveurgent && haveurgentcbs)
>  			break;
>  	}
> -	pr_info("%s: %s(%d) since %lu g:%lu i:%lu/%lu %c%c%c%c l:%lu %s\n",
> +	pr_info("%s: %s(%d) since %lu g:%lu i:%lu %c%c%c%c l:%lu %s\n",
>  		rtp->kname,
>  		tasks_gp_state_getname(rtp), data_race(rtp->gp_state),
>  		jiffies - data_race(rtp->gp_jiffies),
>  		data_race(rcu_seq_current(&rtp->tasks_gp_seq)),
> -		data_race(rtp->n_ipis_fails), data_race(rtp->n_ipis),
> +		data_race(rtp->n_ipis),
>  		".k"[!!data_race(rtp->kthread_ptr)],
>  		".C"[havecbs],
>  		".u"[haveurgent],
> -- 
> 2.17.1
> 
