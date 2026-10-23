Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792783394;
	b=yEDtvnOVt69G7nZbjBd1WHpn4KtZ+SETLt42mG5PzPtViZ692trt7cL6d1jmJSWhaWk0
	 uj3Gbn79ZFCakHwA/D3141Q0HThPCmj5k7BtD0u3kZG3e4VnBNUjyEkLzQesFYZxyuNtS
	 rZOMkLUl05y1W6suu6ve7HHxc8v3WbZ8QM2XAXirnnSEOjdSFEdG8vDgozpMtylETBl7z
	 o4KAZseE3kzqnMxmALXSotW7ads2Rr+sla3bEMKxqLO9tBEuwt0ng1JIVMOKRjXwi95BN
	 vkE1VD2c4DKijDvm22KKZYeTueejUPOG9UAxGNC23wd0vo9qVQ1PKDpVYwLqMisDr/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792783394;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=K4phAtbqJvDEUeL3XNrRdi4DSZI1CWHLSNHnV35OQ1g=;
	b=UDjnSCgr3PSrL6W0Ddsm0qZaTMPwxpcYV50iFnkBXgJN7+EG2WqBZqkLNiiSUTN3wc1Y
	 cyezzvt3SKVOIe4q87GW2Br/5yY6+5m99QLH2PwFjxwOHx9RBRUqWbq+g81HXZAUAfNgr
	 bbDwYzqhtz0GXqxNcLmirDJsxB4Wu4YhbnqesFajf+A1S5Z4fBcR+6a/OVC8FruU6VpdW
	 Hklk70GCooevhj4w53KI3eGrXP9jreucqKQa7WjswP/T4TuKiUqMieklkEQIpc4ruak1i
	 UdeSIOpWzDuhc61X4GymVrYMkJx7LQCaJDpkFUaXa6XPMIASgPr1GPGWpbzIQDS0GYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TdcmMsoc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFA0606A31B;
	Fri, 23 Oct 2026 19:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TdcmMsoc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6545C1F01825;
	Fri, 23 Oct 2026 19:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792783393;
	bh=K4phAtbqJvDEUeL3XNrRdi4DSZI1CWHLSNHnV35OQ1g=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=TdcmMsoc8lCuiSLRaK36Qy6MhQM4jE0M0hnuxF85iViaj4Cxv3zrC60bk+rfRhdGP
	 3OPyU36URP3ex6M+Ztcb1CsZvZQtHNASCrp/aKQkcwQmRIDrJD6vcEr8+tL5rSpBzl
	 nW55VjLwFKkQojrRMKnWfKrYXAsO8JaafWx59vo2scNguVpD00vXggVnRrQ71DBR6c
	 4UM1H7J/MBsXecA1ha2MRdtm2l7E240AGUqHWeamFGQdLp/SYHMswizjHVNNqeeZwK
	 xiXIJNrkxSCdOVCfKUyYEAh2olugz8wcqhLMsr8HWymMsRBvCad6TorGrEKoC/6YJy
	 YvNSwXIkgJctg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1524BCE0540; Fri, 23 Oct 2026 12:23:13 -0700 (PDT)
Date: Fri, 23 Oct 2026 12:23:13 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zqiang <qiang.zhang@linux.dev>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
	urezki@gmail.com, boqun@kernel.org, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rcutorture: Avoid create fwd_prog_tasks for
 tasks-rude and srcu-atomic
Message-ID: <5cb8b0cb-c7ea-4f2c-a9f9-3ccbab1bddc3@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261023093716.25717-1-qiang.zhang@linux.dev>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023093716.25717-1-qiang.zhang@linux.dev>

On Fri, Oct 23, 2026 at 05:37:16PM +0800, Zqiang wrote:
> When running the tasks-rude and srcu-atomic tests, the fwd_prog_tasks
> kthread is created because the default value of fwd_progress is 1.
> however, the two RCU flavors not support ->call():
> 
> 1. tasks-rude: commit b428a9de9bba ("rcutorture: Stop testing RCU Tasks
>    Rude asynchronous APIs") removed .call and .cb_barrier from tasks-rude,
>    but left the .cbflood_max = 50000.
> 
> 2. srcu-atomic: srcu_torture_init_forbidden_apis() sets ->call to NULL
>    for SRCU_READ_FLAVOR_ATOMIC runs, but leaves ->cbflood_max untouched.
> 
> In both cases, the non-zero ->cbflood_max fools the check above into
> creating the fwd_prog_tasks kthreads, even though those kthreads cannot
> possibly carry out any forward-progress test:
> 
> 1. The rcu_torture_fwd_prog_cr() returns immediately due to cur_ops->call
>    is NULL:
> 
> [   68.022674] rcu_torture_fwd_prog_cr: No ->call(), so no forward-progress test 0
> [  129.462046] rcu_torture_fwd_prog_cr: No ->call(), so no forward-progress test 0
> [  190.902123] rcu_torture_fwd_prog_cr: No ->call(), so no forward-progress test 0
> [  252.343809] rcu_torture_fwd_prog_cr: No ->call(), so no forward-progress test 0
> 
> 2. The rcu_torture_fwd_prog_nr() is never even invoked, because its caller
>    requires cur_ops->stall_dur, and neither tasks-rude nor srcu-atomic
>    provide ->stall_dur (only rcu_ops does).
> 
> Therefore, creating fwd_prog_tasks kthreads is pointless, this commit adds
> ->call and ->cb_barrier to the forward-progress check, rejecting flavors
> that lack the cbflood_max set and a positive ->stall_dur.
> 
> simple verification output:
> 
> [    3.062959][    T1] srcu-torture: rcu_torture_fwd_prog_init: Disabled, unsupported by RCU flavor under test
> [    2.922323][    T1] tasks-rude-torture: rcu_torture_fwd_prog_init: Disabled, unsupported by RCU flavor under test
> 
> Suggested-by: Joel Fernandes <joelagnelf@nvidia.com> 
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

It would nevertheless be good to run tests demonstrating that
forward-progress testing happens and does not happen on the same
rcu_torture_ops structures as before.  Just in case I lost my
way through that boolean expression.  ;-)

> ---
>  kernel/rcu/rcutorture.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 968343be4e0d..92ff197f4789 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -4007,9 +4007,8 @@ static int __init rcu_torture_fwd_prog_init(void)
>  	} else if (fwd_progress < 0) {
>  		fwd_progress = nr_cpu_ids;
>  	}
> -	if ((!cur_ops->sync && !cur_ops->call) ||
> -	    (!cur_ops->cbflood_max && (!cur_ops->stall_dur || cur_ops->stall_dur() <= 0)) ||
> -	    cur_ops == &rcu_busted_ops) {
> +	if (!cur_ops->sync || ((!cur_ops->call || !cur_ops->cb_barrier || !cur_ops->cbflood_max) &&
> +	    (!cur_ops->stall_dur || cur_ops->stall_dur() <= 0))) {
>  		VERBOSE_TOROUT_STRING("rcu_torture_fwd_prog_init: Disabled, unsupported by RCU flavor under test");
>  		fwd_progress = 0;
>  		return 0;
> -- 
> 2.17.1
> 
