Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C7A1EF36B;
	Wed, 10 Sep 2025 13:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757511193; cv=none; b=UPRw1dbigyKrZd35V4Ad5+5MluqChdZshZevVAPEE4wmGNNLpZrRzNQwSpKyiGMAxvkwhdwORqB0W1Yvq4csNhVaZaOl5NkRYAAwZpPUSPeUEbEqseNPuRXmX5f7lMNCceKC30qwyFUsdGyNYXusHGh8WTyZOINT+FtSJnIa0GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757511193; c=relaxed/simple;
	bh=Tw0QTfnyqKrEkt7OfgUFYqL1O3TTE6wURjAAbyBOnds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZaqdRDRiSexKbY3gRReYfy4sO35jBQQh/z+nGPwC4EhfwkaZcztXycEZrRxlYQHWMCEKI3yMVvxTxqAb/h9dAxOLFpAuMAR6J0V2nNRDkf4dDm5U8DjPSoiY37KyWLs0iWCw49xz3Tymy7Xq80LreGHOekpGDMmRihqR6Cl69U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ruzTUkDs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ruzTUkDs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235FCC4CEF0;
	Wed, 10 Sep 2025 13:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757511193;
	bh=Tw0QTfnyqKrEkt7OfgUFYqL1O3TTE6wURjAAbyBOnds=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ruzTUkDssG9v+7bDCr1Dn78LqwMHtvwSp2Vn+/doFtdmR9gGZAlvMKnBJVMq6rZCq
	 Si7ATH4YCrXdiwPqE65WDJ5byScWAFaW0aEIR/c1aZF/nzjQGVHDKdmHskdPA4+YVx
	 ihsOKmXlQ1N9VAZ8JhbqDNs3/u/ehaDBeItipU6FFEF3v8pm9G4iiEtf9e1bWzEU13
	 /MqflFUMFruvthk1yicRdBuv9tV14Q011uq0Oj9EGX1R2VuNAqRVN3doLw82jsbuz4
	 syAOBgURGFQo+0wgOxMnfM40x6TNgkY6Z4Vwm+bMJmjdwoitxAq2q7yQM4KFHV7ARW
	 Qz/vDdwECHPVA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3384FCE0B24; Wed, 10 Sep 2025 06:33:12 -0700 (PDT)
Date: Wed, 10 Sep 2025 06:33:12 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Cc: dave@stgolabs.net, josh@joshtriplett.org, frederic@kernel.org,
	neeraj.upadhyay@kernel.org, rostedt@goodmis.org,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH v2] rcu/rcutorture: Improve error handling in
 rcu_torture_fwd_prog_init()
Message-ID: <41a572f2-b9d3-4985-a61e-bff0b3b0e4d3@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250910092820.3736526-1-kaushlendra.kumar@intel.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910092820.3736526-1-kaushlendra.kumar@intel.com>

On Wed, Sep 10, 2025 at 02:58:20PM +0530, Kaushlendra Kumar wrote:
> Restructure error handling in rcu_torture_fwd_prog_init() to provide
> cleaner allocation failure paths. The current code checks both
> allocations in a single condition, making error handling less
> efficient and clear.
> 
> The improved approach:
> - Check rfp allocation immediately and return early on failure
> - Separately handle fwd_prog_tasks allocation failure with proper
>   cleanup
> - Remove redundant kfree(fwd_prog_tasks) since it would be NULL on
>   failure

First, thank you for your interest in Linux-kernel RCU!

However, you lost me on this one.  Please see below.

> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> ---
> Changes in v2:
> - Fixed word wrapping in commit message to follow kernel guidelines
> ---
>  kernel/rcu/rcutorture.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 807fbf6123a7..6af0d207adba 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -2995,11 +2995,11 @@ static int __init rcu_torture_fwd_prog_init(void)
>  	if (fwd_progress_div <= 0)
>  		fwd_progress_div = 4;
>  	rfp = kcalloc(fwd_progress, sizeof(*rfp), GFP_KERNEL);
> +	if (!rfp)
> +		return -ENOMEM;

Don't we still need to set fwd_progress to zero?

>  	fwd_prog_tasks = kcalloc(fwd_progress, sizeof(*fwd_prog_tasks), GFP_KERNEL);

Although this change does avoid the doomed kcalloc() attempt, why are
we optimizing an infrequent failure case?

> -	if (!rfp || !fwd_prog_tasks) {
> +	if (!fwd_prog_tasks) {
>  		kfree(rfp);
> -		kfree(fwd_prog_tasks);

Invoking kfree() on a NULL pointer is a well-defined no-op.

> -		fwd_prog_tasks = NULL;
>  		fwd_progress = 0;
>  		return -ENOMEM;
>  	}

I don't see where this is helping the common-case success path, nor am
I seeing need need to optimize this initialization-time-only code path.
Adding the zeroing of fwd_progress will result in a net increase in the
number of lines of code.

So what am I missing here?

							Thanx, Paul
