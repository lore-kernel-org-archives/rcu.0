Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FB3420E9F;
	Fri, 31 Jul 2026 18:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785520886; cv=none; b=G1snPmW+mSeIMRcG5DrMRBWnO2W9TFDyRGPMyhBuPTsIyO9Bo8Zp/Kl4kaLPcfws3jU7i5x0e+ryhxdnriSERSWY6OWswHjHZ1+H8lqyJRTxfoXtS8hbEOT+lckXUORhgAVx0DU+kgjJqAhNpq9kGYY3YD+hG5+hcycL927PLAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785520886; c=relaxed/simple;
	bh=7JVSnnTR4SzkXlMH5eqzaL+pZ6rwY/ULXg6tcZlz8Ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYE6Jn4M4F/bvBLbMjpfG/I3UQ4vohA8lRDC9PtiLO/Ad+wWUMT6RkfVmC73CajR7+m5u91VaMptUuhXew7HV6MzwvzcYwqVbUHIHUJahB1r0ZzMjbjshY9JsmQiciwUaEzfabzjMVqrBwfefC5A2yuZyHDf3bS/jjkfA8Z+zwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7XKIsBY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7XKIsBY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78EC1F00AC4;
	Fri, 31 Jul 2026 18:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785520884;
	bh=MhrQuKcKot42xAdzWYtgn0nEP9ckiS+8jtKZt9/qrRg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=L7XKIsBYpV0kMlLXACZpQC3nHdLdem2VHpeXHWxdJWX7zPOsmwG8mvzgcUcjxKAO8
	 6jn76yTY+aOcNx0aXQrKPgpwxkyIOYrdAlpgw7QBhs+7bHNbH3R+8FYDTt/4SrIKAm
	 vwDTj9k/zrwa3jJP36G0C2tpbj6AVj8ri8XqqEWtSaJi0EnHO2CX8tNIJVyELZXwNo
	 /i85f7ffbuVwBbph7SoO1EERV2uZC8ioyPrOp3vxToryh8nnhm5a+ndrxaHZ+bfx0K
	 OUkMaO1VH+SaDqNnwpPv9vcjFirFPLv40Un7JoHQhzP6bn5HM70lwkdJYGbLVnkrRn
	 x615b4rX3GSig==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A3694CE11BE; Fri, 31 Jul 2026 11:01:24 -0700 (PDT)
Date: Fri, 31 Jul 2026 11:01:24 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Puranjay Mohan <puranjay@kernel.org>,
	Usama Arif <usama.arif@linux.dev>
Subject: Re: [PATCH v2 06/13] rcutorture: Add nwriters module parameter
Message-ID: <389782a8-9f51-4e92-83cc-3737d1bba65e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <d1db6e52-06c2-401d-b6fe-85aa588196d8@paulmck-laptop>
 <20260731010719.3531912-6-paulmck@kernel.org>
 <amxauiJZab9_3OKr@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amxauiJZab9_3OKr@gmail.com>

On Fri, Jul 31, 2026 at 01:22:19AM -0700, Breno Leitao wrote:
> On Thu, Jul 30, 2026 at 06:07:12PM -0700, Paul E. McKenney wrote:
> > Believe it or not, there are people who would like to run rcutorture
> > without actually torturing RCU.  For example, some people would like to
> > induce various types of stall warnings without placing any unnecessary
> > additional overhead on their systems running in production.  And
> > rcutorture provides the stall_cpu, stall_cpu_holdoff, stall_no_softlockup,
> > stall_cpu_irqsoff, stall_cpu_block, and stall_cpu_repeat module parameters
> > in order to allow the user to force numerous types of stalls.  In addition,
> > rcutorture provides a great number of other module parameters to allow the
> > user to reduce other overhead.
> > 
> > But unfortunately, there is no way to turn of the rcu_torture_writer()
> > portion of this torture test, which on my x86 laptop consumes somewhere
> > between 40% and 45% of a CPU.  Although this is quite lightweight for a
> > torture test, it is not welcome on systems running production workloads.
> > This commit therefore adds an nwriters module parameter that defaults
> > to 1 but can be set to 0 in order to disable the rcu_torture_writer()
> > portion of the torture test, but that cannot be set to any other value
> > (that is what the fakewriters module parameter is for!).  This reduces
> > the overhead to well under 1% of a CPU, which is much more likely to be
> > compatible with production workloads.
> > 
> > Reported-by: Breno Leitao <leitao@debian.org>
> > Reported-by: Puranjay Mohan <puranjay@kernel.org>
> > Reported-by: Usama Arif <usama.arif@linux.dev>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> Reviewed-by: Breno Leitao <leitao@debian.org>
> 
> > diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> ...
> > +torture_param(bool, nwriters, 1, "Number of RCU writer threads (0 or 1)");
> 
> It looks like you used `int` for the same parameter in hazptrtorure.c
> and bool here
> 
> 	torture_param(int, nwriters, 1, "Number of hazard-pointer writer threads, 0 or 1");
> 
> Needeless to say that bool is more appropriate, and you don't need to
> check it later.
> 
> 	WARN_ON(IS_BUILTIN(CONFIG_HAZPTR_TORTURE_TEST) && nwriters != 1);

Fair point!  Although the check is because I didn't think that it made
sense to do a built-in test without any writers.  Which sounds a bit
silly now.

I will change nwriters to "bool" and remove that WARN_ON(), thank you!

							Thanx, Paul
