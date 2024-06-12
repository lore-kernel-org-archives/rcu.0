Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CA916DECF;
	Wed, 12 Jun 2024 09:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718185338; cv=none; b=XZTG6pnqfRRUN2haVNkQVdZV7+oAfE0Fan8noYMkFHrnAecXk9P/HBK/0nfmCPsCycwRq5f96O0to1c94ehecgPpTfhvwslMU63LxTl7ci38y9cM1eo2nM+O9VTQ7/XUUPzv6iSK6hWyDs8gZ7YfE7V0Ccwev1ihT9DX81uB2Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718185338; c=relaxed/simple;
	bh=4e+EIVhbrt7oVMReblWRn01qu1QrqTBkE9krZ/pM+Yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lwXzIa57TGJynRLKDw9xk6dNzTHNdwCMg4rpo1DJ0P/5wBABXWpcUOicbFY2hEfZgZR2fyl8oiDoFdxW0tsbSYcUGoDIlBOiGCAAU7cJ9GT7GXpEvQZTMIwIIK2pihaO1A+X8A+T7UlklhRGyi3Gxtmf3oAxQudrS22pBfkkBeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nt+V0wl/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nt+V0wl/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0906C4AF1A;
	Wed, 12 Jun 2024 09:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718185338;
	bh=4e+EIVhbrt7oVMReblWRn01qu1QrqTBkE9krZ/pM+Yg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nt+V0wl/77MlpIcQhJQ7mCMj072ACyTYCC5zJhCDzb+sBxA/c6b0FQqah3jxNgpl6
	 9jv/9EZBmb2Hr7ki41tavui7nBt034mSBj1ZlJKm8zVvVMfUep41iVkwciqyi6Ihca
	 QcAkyhAL3H9V0v84GUfsmREOpUgXWK/r+fioQgAhB/hGu2UUsoxv4MZrPFj/sZC+MO
	 YXZstn+QUYhoXiKHeY8H12r1q9I7Pm386HpCaEnvSAejNDJd6iKiEdDQWnfaDNhelM
	 Zr7CFn6Ve8tujWBPUPg2ctioG2pejIWJ/9TbdorUoyrRSA9VJaTYuWZ+cU2QLToxs/
	 u0HTbJxkm4ubA==
Date: Wed, 12 Jun 2024 15:12:07 +0530
From: Neeraj Upadhyay <Neeraj.Upadhyay@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH rcu 0/6] Grace-period memory-barrier adjustments for v6.11
Message-ID: <20240612094207.GA418202@neeraj.linux>
References: <81f4e616-8125-4934-a8e2-fd5beae90995@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81f4e616-8125-4934-a8e2-fd5beae90995@paulmck-laptop>

On Tue, Jun 04, 2024 at 03:26:46PM -0700, Paul E. McKenney wrote:
> Hello!
> 
> This series removes redundant memory barriers from the grace-period
> code paths:
> 
> 1.	Remove full ordering on second EQS snapshot, courtesy of Frederic
> 	Weisbecker.
> 
> 2.	Remove superfluous full memory barrier upon first EQS snapshot,
> 	courtesy of Frederic Weisbecker.
> 
> 3.	rcu/exp: Remove superfluous full memory barrier upon first EQS
> 	snapshot, courtesy of Frederic Weisbecker.
> 
> 4.	Remove full memory barrier on boot time eqs sanity check,
> 	courtesy of Frederic Weisbecker.
> 
> 5.	Remove full memory barrier on RCU stall printout, courtesy of
> 	Frederic Weisbecker.
> 
> 6.	rcu/exp: Remove redundant full memory barrier at the end of GP,
> 	courtesy of Frederic Weisbecker.
> 

Reviewed-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>

> 						Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
>  b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst |    6 +--
>  b/kernel/rcu/tree.c                                                     |    2 -
>  b/kernel/rcu/tree_exp.h                                                 |    8 +++-
>  b/kernel/rcu/tree_stall.h                                               |    4 +-
>  kernel/rcu/tree.c                                                       |   19 +++-------
>  kernel/rcu/tree_exp.h                                                   |    8 +++-
>  6 files changed, 26 insertions(+), 21 deletions(-)
