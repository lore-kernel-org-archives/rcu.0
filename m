Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB28347FE2;
	Wed,  4 Mar 2026 15:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772638345; cv=none; b=gbvMZz2L4jH/UW/5a/S+ASrGwUg61RtD97egKea5VEv9mRzCVo6+zaISc9Wtj2wNKBPrFfSD52KcOEumSLpAVW+a3FcSy5xtTap5xnOxqUqGRVHehNaGzWcI9YL5btvDKvqNrMYMrVWZe2bRUUft/+5xEsBsvMqMqvTC9Ws7seo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772638345; c=relaxed/simple;
	bh=wbApkclXeYtkf94Qp0PCYUvoWqL7GbHXCpYFOESeHRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lenyTxa8wtNTjou/MKQ4/EdURApo8SqYOSc+FbJctGygPA5MlIPkY5pBpZQVNG077B4s92Af4lSnx2tmMQG6KLVtPwF603JwfzD0Fob1SsFLfVdS+9+HskjtYKGzJvJeKOtIMixFKxhr+d4MmZs2EIX73aTBp5n9HgbvYLxVTSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1I3Jxwg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1I3Jxwg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88584C4CEF7;
	Wed,  4 Mar 2026 15:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772638345;
	bh=wbApkclXeYtkf94Qp0PCYUvoWqL7GbHXCpYFOESeHRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P1I3Jxwg1nVKFFHThcQzzNSVSYXmTqHmw/nLg6vYvnfyLr3arz2vIzq1SQWp9sKmK
	 CabT4eEFLGa+YM0+27KL5tWl7ybfNO00frfDNA0GvekIDMOwIv+HaYUcSksX9ydUaQ
	 bZ8nw4TAs06bPVMa0V2auvkU1lGWs+3rIm1Xf64Fmgeu/zteUUE3jbdW/fp1Ese6Dd
	 7t0J0UFG9qwgcItUd83ZzS2O891u76TcY2/spqNY/G05oa6+K+0PY91RUXd2awrS+r
	 Ja022Ey0ZWzh/mDbf/UUf3jfCIlhWRC67gcva6uaqD3F9Jh2DF8jf0w4V+xHQ3ctIe
	 yScuCc9FwB5fw==
Date: Wed, 4 Mar 2026 16:32:22 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v1 1/4] rcu/nocb: Consolidate
 rcu_nocb_cpu_offload/deoffload functions
Message-ID: <aahQhlPp3Qqm4Bwg@localhost.localdomain>
References: <20260224230435.3390963-1-joelagnelf@nvidia.com>
 <20260224230435.3390963-2-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260224230435.3390963-2-joelagnelf@nvidia.com>

Le Tue, Feb 24, 2026 at 06:04:32PM -0500, Joel Fernandes a écrit :
> The rcu_nocb_cpu_offload() and rcu_nocb_cpu_deoffload() functions are
> nearly duplicates.
> 
> Therefore, extract the common logic into rcu_nocb_cpu_toggle_offload()
> which takes an 'offload' boolean, and make both exported functions
> simple wrappers.
> 
> This eliminates a bunch of duplicate code at the call sites, namely
> mutex locking, CPU hotplug locking and CPU online checks.
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  kernel/rcu/tree_nocb.h | 89 ++++++++++++++++++++++--------------------
>  1 file changed, 46 insertions(+), 43 deletions(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index b3337c7231cc..5b041134d6bb 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -1081,30 +1081,6 @@ static int rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
>  	return 0;
>  }
>  
> -int rcu_nocb_cpu_deoffload(int cpu)
> -{
> -	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
> -	int ret = 0;
> -
> -	cpus_read_lock();
> -	mutex_lock(&rcu_state.nocb_mutex);
> -	if (rcu_rdp_is_offloaded(rdp)) {
> -		if (!cpu_online(cpu)) {
> -			ret = rcu_nocb_rdp_deoffload(rdp);
> -			if (!ret)
> -				cpumask_clear_cpu(cpu, rcu_nocb_mask);
> -		} else {
> -			pr_info("NOCB: Cannot CB-deoffload online CPU %d\n", rdp->cpu);
> -			ret = -EINVAL;
> -		}
> -	}
> -	mutex_unlock(&rcu_state.nocb_mutex);
> -	cpus_read_unlock();
> -
> -	return ret;
> -}
> -EXPORT_SYMBOL_GPL(rcu_nocb_cpu_deoffload);
> -
>  static bool rcu_nocb_rdp_offload_wait_cond(struct rcu_data *rdp)
>  {
>  	unsigned long flags;
> @@ -1149,27 +1125,54 @@ static int rcu_nocb_rdp_offload(struct rcu_data *rdp)
>  	return 0;
>  }
>  
> +/* Common helper for CPU offload/deoffload operations. */
> +static int rcu_nocb_cpu_toggle_offload(int cpu, bool offload)
> +{
> +	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
> +	bool currently_offloaded;
> +	int ret = 0;
> +
> +	cpus_read_lock();
> +	mutex_lock(&rcu_state.nocb_mutex);
> +
> +	currently_offloaded = rcu_rdp_is_offloaded(rdp);

Do we really need that extra variable?

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs
