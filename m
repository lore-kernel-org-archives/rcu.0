Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E932119E98C;
	Thu, 19 Dec 2024 23:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734649403; cv=none; b=axlWTRYT9RNJfNHs3lgQY4LCUtMrAizwhLUs4yPVH2aPKLsu4PuSA2bzQWQtsE6O/vEp9+LvacWnGMCohd5PsuWFr9fSrWCKjlpKvMjbf3wJAj3SgoI3RTqZ25iNzhgKdezAiydfzBIYopp+R9KQeolQFdLkT/KJyXGBfdwpuxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734649403; c=relaxed/simple;
	bh=qQJeTJungqbBFqBmcalCwfdu2IXQvOGGHhcdkUA5G48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0SxsFJlOxKc33ygJ7xMeALpCi/7JJ3YXbyF9FCMZpVfaXOTyWGPCzp3kGoEo9JSwsA9C5OuV0rjJxej2gEhV8Q54lW+xqSCwCAH8+YyBiR+ZFzx54wuFt++Lc6YxWLHS5FtI3gAL7MWvgl4n6r2FY3GcL84r3zgMqtp7I7ePvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPLMg27o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPLMg27o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A50C4CECE;
	Thu, 19 Dec 2024 23:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734649402;
	bh=qQJeTJungqbBFqBmcalCwfdu2IXQvOGGHhcdkUA5G48=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=FPLMg27ot7O/Ynq9gfhqMS09LC+LM9EXMZkUfI2DkFI1w7617tkKwyLJnRVDTrNmh
	 +JNLENRCG5nzOCTsqqsICRNgVj2O1lj8mHHyK4HLgoz8gQ8i1jDmIyuDIkUDnqgvtO
	 +ulX0Aby+gDHvXPrImTA7BDMeBrbYrp8weDGWRYKWFyQtAazjKvcgPVtGkus+aDMZP
	 hmfsT7eF35ATzT6q3MaVtapryuqCR14TrwxqVVnmSUMJ2u5VcKPNKPzq2ErmVJKaVR
	 RpDg/9ZrxQI8tjpyN0CqZVrsxJx65IOTaIgS4lANxOhTvIiz9dU3VeeMRouh2Jax3F
	 etcqa8qhsk66w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0641ECE09DB; Thu, 19 Dec 2024 15:03:22 -0800 (PST)
Date: Thu, 19 Dec 2024 15:03:22 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Magnus Lindholm <linmag7@gmail.com>
Cc: Michael Cree <mcree@orcon.net.nz>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	rcu@vger.kernel.org, linux-alpha@vger.kernel.org,
	"Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
Message-ID: <b3cd5af3-4b8f-43bd-b3f3-c9f4644c95d4@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CA+=Fv5R+8y2hCq7p-xo5qZ0CyinR_0aAndUkoEAweCVs_95SMw@mail.gmail.com>
 <Z1YpKFQGtMWF3yy3@creeky>
 <CA+=Fv5Q=f-6y=EhZhG2XfZB0O=m+yOiv+gmtmMABVQZieKdwbQ@mail.gmail.com>
 <Z2ClSlwznfuk8Uwr@creeky>
 <CA+=Fv5RaqHL6MJjvhF-mn3CVY10e=2QqFBSVO6YXLUJ7WV9zGQ@mail.gmail.com>
 <CA+=Fv5RP=NoWo4VeTX7hx103=jP2d-NC-jFo+ePXLBRubCxc_w@mail.gmail.com>
 <ef49a479-2000-42ee-9b10-9f3b6a68ec35@paulmck-laptop>
 <CA+=Fv5REK+xbA49zD3aYBgG2J1Xw1FWP02qjyyOTrwbzMRXu3w@mail.gmail.com>
 <be4fe590-b41c-4033-91c1-94f10c4f3d40@paulmck-laptop>
 <CA+=Fv5Tk-vbAK72ZOK-bPwvnx9w_1ATH=S9t-LW8gBEgQPYa3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+=Fv5Tk-vbAK72ZOK-bPwvnx9w_1ATH=S9t-LW8gBEgQPYa3A@mail.gmail.com>

On Thu, Dec 19, 2024 at 11:38:09PM +0100, Magnus Lindholm wrote:
> > In the past, there have been compiler optimizations that would use a large
> > store to update a smaller variable, and then do small stores to fix up the
> > clobbered areas.  These were all supposed to have been removed for C11.
> > Might some linger in Alpha's compilers?
> 
> 
> Hi again,
> 
> Making just these (see below) one-liner changes to tree_exp.h and
> smp.c respectively, lets me boot kernel 6.12.5 on alpha without
> passing any special rcu parameters to the kernel and it also lets me
> load/unload my scsi kernel module. Is the alignment of structs just
> giving gcc more room to clobber the stack without actually hitting
> anything important or is it relevant for how kernel threads access
> structs on weak memory-model architectures?

This looks like the aforementioned bug in Alpha's compilers, namely
failing to comply with C11's restrictions against compiler-induced
data races.  I can't say that I am at all excited about accepting these
changes because they increase stack size.

The best thing would of course be to fix the compiler.  If that cannot
be done, why not just carry these patches?

							Thanx, Paul

> /Magnus
> 
> +++ kernel/rcu/tree_exp.h 2024-12-19 18:55:59.091893649 +0100
> @@ -940,10 +939,10 @@
>  void synchronize_rcu_expedited(void)
>  {
>   unsigned long flags;
> - struct rcu_exp_work rew;
> + struct ____cacheline_aligned_in_smp rcu_exp_work rew;
>   struct rcu_node *rnp;
>   unsigned long s;
> 
> 
> +++ kernel/smp.c        2024-12-19 19:01:20.592819628 +0100
> @@ -631,7 +631,7 @@
> int smp_call_function_single(int cpu, smp_call_func_t func, void *info,
>                              int wait)
>  {
>         call_single_data_t *csd;
> -       call_single_data_t csd_stack = {
> +       struct ____cacheline_aligned_in_smp __call_single_data csd_stack = {
>                 .node = { .u_flags = CSD_FLAG_LOCK | CSD_TYPE_SYNC, },
>         };
>         int this_cpu;
