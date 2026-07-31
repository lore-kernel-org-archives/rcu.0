Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84861377AA6;
	Fri, 31 Jul 2026 08:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785486160; cv=none; b=WsLI5UH0gxn12JSgHdLuhRgpnBS5I17pb6EN1YBTHI8Q70Dmv8zKvyGnuoTUzfHIXtTUBv45F6J10QizEKRlDPqIWi8G9luPwGtPVug9Uj4S4VIWOOtpP0RSsU/s1JEb8LCKT1Ecm/AuxwNS8crLLid9rSsW0Z13T8oAucJbVJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785486160; c=relaxed/simple;
	bh=ODdJ+M4Szk6UrlUu+FMU3ppLR0GIbWQbY6OiwJRgm/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hT1mlP1IWZxlJ8WFXX0U36BTsonS1b/FUUv9sLhY5YZD+a+ruxfcG9dOuizuCgKEJxW3/dW8FiHc/L+8fvzLjK2SY0oC9kiPROe9+RbMsXFeEu3GAnXJUZ07SsXJV0UajvtHloWjzcqWvmGspbbcHaRv3oKV+q2kLWuy78xRG0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=VApX/+TF; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="VApX/+TF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=59u2v6y3LIjZBkv8T/Re348N7s16ZR/HcZcJicJMmo0=; b=VApX/+TFBSkMiz4o8J/LjFL5E0
	nWQFGApUIbEYnrvxOwMxsG6lxvdSBfO7+ka0smTETkHgo5ylTwqZQI/siYPz4Q1TmXBAEQvu1XvF5
	ufS1sFUgaqSMU8DrMG+KhMPBD+Jlth/Eh+ErRzs39W6x2KJg3V/j7p1vt5DqB8tDVcXnLSok7JNST
	yX7xa4dbaE9fz7RHse+P0njvcwxO2AriUH4eSiYiqRmyb/jme3xLW513+uPsHCSey60UQYB/I6hAV
	ZOgTnFjQZEAOaCzvAh73fC/88GMSwXyM5AcybDCA+MyyWykPWqvWe0GYIMINgaKbu4e5ZAGyCWYtS
	6G+c+4pw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wpiVc-009sVZ-12;
	Fri, 31 Jul 2026 08:22:24 +0000
Date: Fri, 31 Jul 2026 01:22:19 -0700
From: Breno Leitao <leitao@debian.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, rostedt@goodmis.org, Puranjay Mohan <puranjay@kernel.org>, 
	Usama Arif <usama.arif@linux.dev>
Subject: Re: [PATCH v2 06/13] rcutorture: Add nwriters module parameter
Message-ID: <amxauiJZab9_3OKr@gmail.com>
References: <d1db6e52-06c2-401d-b6fe-85aa588196d8@paulmck-laptop>
 <20260731010719.3531912-6-paulmck@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731010719.3531912-6-paulmck@kernel.org>
X-Debian-User: leitao

On Thu, Jul 30, 2026 at 06:07:12PM -0700, Paul E. McKenney wrote:
> Believe it or not, there are people who would like to run rcutorture
> without actually torturing RCU.  For example, some people would like to
> induce various types of stall warnings without placing any unnecessary
> additional overhead on their systems running in production.  And
> rcutorture provides the stall_cpu, stall_cpu_holdoff, stall_no_softlockup,
> stall_cpu_irqsoff, stall_cpu_block, and stall_cpu_repeat module parameters
> in order to allow the user to force numerous types of stalls.  In addition,
> rcutorture provides a great number of other module parameters to allow the
> user to reduce other overhead.
> 
> But unfortunately, there is no way to turn of the rcu_torture_writer()
> portion of this torture test, which on my x86 laptop consumes somewhere
> between 40% and 45% of a CPU.  Although this is quite lightweight for a
> torture test, it is not welcome on systems running production workloads.
> This commit therefore adds an nwriters module parameter that defaults
> to 1 but can be set to 0 in order to disable the rcu_torture_writer()
> portion of the torture test, but that cannot be set to any other value
> (that is what the fakewriters module parameter is for!).  This reduces
> the overhead to well under 1% of a CPU, which is much more likely to be
> compatible with production workloads.
> 
> Reported-by: Breno Leitao <leitao@debian.org>
> Reported-by: Puranjay Mohan <puranjay@kernel.org>
> Reported-by: Usama Arif <usama.arif@linux.dev>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

Reviewed-by: Breno Leitao <leitao@debian.org>

> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
...
> +torture_param(bool, nwriters, 1, "Number of RCU writer threads (0 or 1)");

It looks like you used `int` for the same parameter in hazptrtorure.c
and bool here

	torture_param(int, nwriters, 1, "Number of hazard-pointer writer threads, 0 or 1");

Needeless to say that bool is more appropriate, and you don't need to
check it later.

	WARN_ON(IS_BUILTIN(CONFIG_HAZPTR_TORTURE_TEST) && nwriters != 1);

Thanks for implementing it,
--breno
