Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EFA364;
	Sun, 19 May 2024 00:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716079524; cv=none; b=D/TS+hzx3HTBYz6XYM/zXUTSQdLDdvx9XqfUv22oCEfEa611Th3/Ronjbvx80JXaOU4hhBd2OBlL4gI7nZC1SmUjAbsUNWQNH4HZmAfZqWiL2XhpfQCy8YUxKdkwIf8KWwq9ZXPekHFJvmMGCfYT4KHQk6D67B112iC92kB9qwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716079524; c=relaxed/simple;
	bh=CDiwX7uYM/03fsSkqWnBADpK5A0y5jAmb5ErXmdDe98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kmbK3wNADKLcxMjBcMSQ4c6Tjy5iymWEH2lGmQ+Jx365sUUDUjTXhP/Tg8Yx80D47F9LV7itz69lTLdLNaU1t5C+4uIdjpmpo6juIhedyyzDkCvWXqvoO++kUoG07/ZZ8GpyngXVfsSxsWr3GRSSpW3RauEPdOywHZ6SP5W10O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHIgveOB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHIgveOB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0215EC113CC;
	Sun, 19 May 2024 00:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716079524;
	bh=CDiwX7uYM/03fsSkqWnBADpK5A0y5jAmb5ErXmdDe98=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=CHIgveOB2cg/CdOrZ7myK1jYV99avnHtx5hSRIPmjkTS+Oc/TM1Mwe6qPXw0MZ/x9
	 f/vltBZN1iwqdm5OQDQe9H+cz9mYKae9B+Hr26U/TU5wyQbTfpNMDQKSW4cs3zkPFf
	 v9lVZPqdx9FqU0VgNZDzuL7nTO1L0sLKfYk7cBqSrI6hnsppXy4GXZZfbM6GasEQ9c
	 E6ahPFTPymHy9ln4G5sasqiCIniw8z7sb7q0ic4RlFSzdX5FLv64ljLe/tKvD78kzg
	 9x6xG08dhJIhxlF3rtEjh6pEyTWxslIl2nXn6sge2qoAFZ2PbLeaaOuaou80FQ6zl1
	 Y0FhBAidcK5Gg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8DD03CE0C3C; Sat, 18 May 2024 17:45:23 -0700 (PDT)
Date: Sat, 18 May 2024 17:45:23 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] rcu: add missing MODULE_DESCRIPTION() macros
Message-ID: <59e0cbee-16b8-4251-af9e-a9b47c029155@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240518-rcu-v1-1-086a30b96877@quicinc.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240518-rcu-v1-1-086a30b96877@quicinc.com>

On Sat, May 18, 2024 at 04:28:08PM -0700, Jeff Johnson wrote:
> Fix the following 'make W=1' warnings:
> 
> WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/rcu/rcutorture.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/rcu/rcuscale.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/rcu/refscale.o
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

I applied and pushed both patches, thank you!

							Thanx, Paul

> ---
>  kernel/rcu/rcuscale.c   | 1 +
>  kernel/rcu/rcutorture.c | 1 +
>  kernel/rcu/refscale.c   | 1 +
>  3 files changed, 3 insertions(+)
> 
> diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
> index 8db4fedaaa1e..b53a9e8f5904 100644
> --- a/kernel/rcu/rcuscale.c
> +++ b/kernel/rcu/rcuscale.c
> @@ -42,6 +42,7 @@
>  
>  #include "rcu.h"
>  
> +MODULE_DESCRIPTION("Read-Copy Update module-based scalability-test facility");
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.ibm.com>");
>  
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 807fbf6123a7..b0d8d06ab7a8 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -51,6 +51,7 @@
>  
>  #include "rcu.h"
>  
> +MODULE_DESCRIPTION("Read-Copy Update module-based torture test facility");
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.ibm.com> and Josh Triplett <josh@joshtriplett.org>");
>  
> diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
> index 2c2648a3ad30..f4ea5b1ec068 100644
> --- a/kernel/rcu/refscale.c
> +++ b/kernel/rcu/refscale.c
> @@ -63,6 +63,7 @@ do {											\
>  
>  #define SCALEOUT_ERRSTRING(s, x...) pr_alert("%s" SCALE_FLAG "!!! " s "\n", scale_type, ## x)
>  
> +MODULE_DESCRIPTION("Scalability test for object reference mechanisms");
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Joel Fernandes (Google) <joel@joelfernandes.org>");
>  
> 
> ---
> base-commit: 674143feb6a8c02d899e64e2ba0f992896afd532
> change-id: 20240518-rcu-7d1939bd9205
> 
