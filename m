Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F7A282F3A;
	Thu, 10 Sep 2026 23:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789082172; cv=none; b=NFstIhRr2H5mWvkWyx/9QAkKesZRzbaiwHF3guvoa2UziZdO7LM9ihG1Rt7hWmpffIMFJ97p7W43fdbsZmXnArXG/9HN8yGJjjP1Q4x4JRJVrsJIIncfHgrtm2cuxtAk09E2OAX6NAvPq/hoRAwW3+1I11pZhofdUixj5x0+BCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789082172; c=relaxed/simple;
	bh=yn+BkuEAzOjvj2ukAzPjSQDDTPN4uk+wldpgVIueuEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JgNzA51JBJ6DUdBMM9C5+gpA7VhKysJdAfuUdSNEmpDHbhQ2dBCLcFb2UDdne62+djnY5VJ7MjyIp7TaeKdlQIB13HJADg/rqIkCuIEcLt9AVoWrTlcsXkqjAEaaeLdSKz0HjBnFixvcBNTltPO82GeMFkLRr+oQ5SH+6dexDdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCTuQ2ES; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCTuQ2ES"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADF0E1F000FF;
	Thu, 10 Sep 2026 23:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789082170;
	bh=Qv7nBWMaF2gJG/6niSxuczANmTUvwcCQehcgWFm9VRY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=ZCTuQ2ESsUwjyCBeAqT8KIMdEPPchKPrwAaiPIm0rLCWv8ZGvf3VQUQUU3RexCv0T
	 z8gTD4TrcrfTBnVG14CAI80FgiE7iFp1XoF2KSlEX1q+EJNP1FFrmqGv5iOFcEXixS
	 0oKh5Ty3amNGa/WkGHI8CkGaHzbINvVQfhk/ui+SKcfKHiZOTb6R+QkV9XcdA1JPv7
	 TNAUN4Sc+45d0YuaUKRmbBceJF/g1dRPAn08TpytHDbxXdRNqBcWyMeI5eht7NDM4l
	 Gg2B3yVNkFv5sSTOhzdtH9cldz3bOxCabkrDKyolcje1a82odST8Su/AT3tiQ6TY5C
	 kPr5+F2Rc3xQg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 74251CE19CD; Thu, 10 Sep 2026 16:16:10 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:16:10 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Bradley Morgan <brads@mainlining.org>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
	josh@joshtriplett.org, boqun@kernel.org, urezki@gmail.com,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com, qiang.zhang@linux.dev, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Drop the private tick-internal.h include from tree.c
Message-ID: <758b3437-799d-41b4-a210-0b29c7ea7002@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260910172537.6562-1-brads@mainlining.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910172537.6562-1-brads@mainlining.org>

On Thu, Sep 10, 2026 at 05:25:37PM +0000, Bradley Morgan wrote:
> Nothing in the tree.c translation unit uses anything from the
> private timekeeping header ../time/tick-internal.h, included
> since commit 48d07c04b4cc ("rcu: Enable elimination of
> Tree-RCU softirq processing"). The tick symbols RCU uses,
> tick_dep_set(), tick_dep_clear(), their _cpu and _task
> variants, tick_nohz_full_cpu() and TICK_DEP_BIT_RCU, are all
> declared in the public linux/tick.h, which tree.c already
> includes.
> 
> Drop the include.
> 
> Signed-off-by: Bradley Morgan <brads@mainlining.org>

Applied for testing and additional review, thank you!

							Thanx, Paul

> ---
>  kernel/rcu/tree.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 96848fc1f02b..338737b9781c 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -64,7 +64,6 @@
>  #include <linux/mm.h>
>  #include <linux/kasan.h>
>  #include <linux/context_tracking.h>
> -#include "../time/tick-internal.h"
>  
>  #include "tree.h"
>  #include "rcu.h"
> -- 
> 2.47.3
