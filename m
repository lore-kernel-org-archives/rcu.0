Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BE225762;
	Wed, 14 Aug 2024 12:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723639761; cv=none; b=i6nmVmryfMduX0SmltwbCfhnD3fP+QD+K/QHLfhaJRg9jZbVS1reTMq5XTLc6X74zPPCF2FzrHATzHYBicNetNIO9fhijt3oxVCQ4Z01L07x8MABPu+TO7Y5yByBTvPaCSRjYC5900KY8hVlnrDCgOS/O6fq7d/sG8jV6XsjEGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723639761; c=relaxed/simple;
	bh=wT4tPFHaUc06gnduj7f0EPAn+I5NgncsA6Mwfo5IE+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IESXlMuHHggwh50hHWAioLgo9PQ/hgaCjdwFfUYGdJH+m9HuQHKz0Zf+UmGsLfBUusbwtTLVVsN+RBkMsBDx/PIfiiDfByuKGFhp8VDdHCU+b1yke+VCdHtJdQTDmMDZUMaZQAb1fHVXeoTt8LKBhWLbfwLoiU5C3PkZr/0P3vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9zakBuw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9zakBuw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F056AC32786;
	Wed, 14 Aug 2024 12:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723639761;
	bh=wT4tPFHaUc06gnduj7f0EPAn+I5NgncsA6Mwfo5IE+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L9zakBuwl+yri2rTm0dlVRZGtPXbteslzFTUhE0q5jrThwP6r4foqUtg6eJ7lnt4l
	 /6DA4Hnr/BKnLeCgDhRE1t+gxm2wdFFQ5Lno/JvbG5HXvJ9t+Eg1HUdwVorbhDUMtq
	 ViBbj2VVujdGQMlozbdVYw88tQoazmStghDOSsB5an2/xRltLWvjZ9gcPIcUICUq7N
	 TxE17f/l568mo7oVzFv5kOWYYKetZZVjSEPIndoQBsfMNA+g4eCMZUVMdOzSnEqI39
	 OJJd0fJvNg8fdvSnT0u0XtRvlk0q546GD6nVDomDtVv+6vKoJ4dP3G2Ip53tPc8F/U
	 a0v+RgTPAfGSw==
Date: Wed, 14 Aug 2024 18:19:15 +0530
From: Neeraj Upadhyay <Neeraj.Upadhyay@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH rcu 06/11] rcuscale: Provide clear error when async
 specified without primitives
Message-ID: <20240814124915.GA1412840@neeraj.linux>
References: <917e8cc8-8688-428a-9122-25544c5cc101@paulmck-laptop>
 <20240802004308.4134731-6-paulmck@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802004308.4134731-6-paulmck@kernel.org>

On Thu, Aug 01, 2024 at 05:43:03PM -0700, Paul E. McKenney wrote:
> Currently, if the rcuscale module's async module parameter is specified
> for RCU implementations that do not have sync primitives such as
> call_rcu(), there will be a series of splats due to calls to a NULL
> pointer.  This commit therefore warns of this situation, but switches
> to non-async testing.
> 

I have changed this to below here [1]. Please let me know if I got it
wrong.

Currently, if the rcuscale module's async module parameter is specified
for RCU implementations that do not have async primitives such as
RCU Tasks Rude, there will be a series of splats due to calls to a NULL
pointer.  This commit therefore warns of this situation, but switches to
non-async testing.


[1] https://git.kernel.org/pub/scm/linux/kernel/git/neeraj.upadhyay/linux-rcu.git/commit/?h=next.14.08.24b&id=22d36840adbcab8fd826a7ca827fd60b708f03de

- Neeraj

> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  kernel/rcu/rcuscale.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
> index 933014b381ec0..315ced63ec105 100644
> --- a/kernel/rcu/rcuscale.c
> +++ b/kernel/rcu/rcuscale.c
> @@ -525,7 +525,7 @@ rcu_scale_writer(void *arg)
>  			schedule_timeout_idle(torture_random(&tr) % writer_holdoff_jiffies + 1);
>  		wdp = &wdpp[i];
>  		*wdp = ktime_get_mono_fast_ns();
> -		if (gp_async) {
> +		if (gp_async && !WARN_ON_ONCE(!cur_ops->async)) {
>  retry:
>  			if (!rhp)
>  				rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
> @@ -597,7 +597,7 @@ rcu_scale_writer(void *arg)
>  			i++;
>  		rcu_scale_wait_shutdown();
>  	} while (!torture_must_stop());
> -	if (gp_async) {
> +	if (gp_async && cur_ops->async) {
>  		cur_ops->gp_barrier();
>  	}
>  	writer_n_durations[me] = i_max + 1;
> -- 
> 2.40.1
> 
