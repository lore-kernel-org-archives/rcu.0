Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9435C433F5
	for <rcu@archiver.kernel.org>; Tue,  2 Nov 2021 16:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0C1560D42
	for <rcu@archiver.kernel.org>; Tue,  2 Nov 2021 16:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234765AbhKBQdh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 2 Nov 2021 12:33:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:36824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231361AbhKBQKR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 2 Nov 2021 12:10:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 993A661052;
        Tue,  2 Nov 2021 16:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635869216;
        bh=SobB5BdC3D2XeM1p4UGscDO/2qDjpZwU+6Zn5q4FyAE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ft4d6xw+wic+NimaD+VbhfAkjw3oq9hrFtSazsMPGxyORP9bwewOkJeW91oyYBvrb
         pPfJaGYYMJEV9nDc5VL9fDYiiNcZAxL+Idq7zHMxZX32LP8AqmIJML/sV/s71q6psS
         tCUBYpk9q4MXd8K0zaNIM/yL2s1rqNuDN2FdzvluCTDZopUiaUdJ4RBA0pc9TWbXqf
         YnZ7uZfe6H2erwBc4FjK1QjOm3qqhXoZnciQRIy3LXkp4dMlUKQxcNq+duVzNeuTtz
         wogpfTIfDFhkOFkyshCq6z720uzwSjEKeKsmJKtK1ViMj6GfvWaieQhjp54hznyYhx
         3wTIWKD7znToA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6298F5C0248; Tue,  2 Nov 2021 09:06:56 -0700 (PDT)
Date:   Tue, 2 Nov 2021 09:06:56 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Li Zhijian <zhijianx.li@intel.com>
Cc:     dave@stgolabs.net, joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, rostedt@goodmis.org,
        rcu@vger.kernel.org, philip.li@intel.com, lizhijian@cn.fujitsu.com,
        jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] scftorture: always log error message
Message-ID: <20211102160656.GI880162@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211029094029.22501-1-zhijianx.li@intel.com>
 <20211029094029.22501-5-zhijianx.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211029094029.22501-5-zhijianx.li@intel.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Oct 29, 2021 at 05:40:27PM +0800, Li Zhijian wrote:
> Generally, error message should be logged anyhow.
> 
> Signed-off-by: Li Zhijian <zhijianx.li@intel.com>

I have queued the patches up to this point for the v5.17 merge window
(not the current one, but the next one).

This one does not apply.  It looks like you created it against mainline
rather than -rcu.  You can learn about the -rcu tree and its habits here:

https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/rcutodo.html

Please port this patch to -rcu so that I can pull it in without
conflicting with patches in -rcu.

							Thanx, Paul

> ---
>  kernel/scftorture.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/scftorture.c b/kernel/scftorture.c
> index 5fb15492999b..8ef7888d78cc 100644
> --- a/kernel/scftorture.c
> +++ b/kernel/scftorture.c
> @@ -41,8 +41,7 @@
>  #define VERBOSE_SCFTORTOUT(s, x...) \
>  	do { if (verbose) pr_alert(SCFTORT_FLAG s "\n", ## x); } while (0)
>  
> -#define VERBOSE_SCFTORTOUT_ERRSTRING(s, x...) \
> -	do { if (verbose) pr_alert(SCFTORT_FLAG "!!! " s "\n", ## x); } while (0)
> +#define SCFTORTOUT_ERRSTRING(s, x...) pr_alert(SCFTORT_FLAG "!!! " s "\n", ## x)
>  
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Paul E. McKenney <paulmck@kernel.org>");
> @@ -583,14 +582,14 @@ static int __init scf_torture_init(void)
>  	if (weight_single1 == 0 && weight_single_rpc1 == 0 && weight_single_wait1 == 0 &&
>  	    weight_many1 == 0 && weight_many_wait1 == 0 &&
>  	    weight_all1 == 0 && weight_all_wait1 == 0) {
> -		VERBOSE_SCFTORTOUT_ERRSTRING("all zero weights makes no sense");
> +		SCFTORTOUT_ERRSTRING("all zero weights makes no sense");
>  		firsterr = -EINVAL;
>  		goto unwind;
>  	}
>  	if (IS_BUILTIN(CONFIG_SCF_TORTURE_TEST))
>  		scf_sel_add(weight_resched1, SCF_PRIM_RESCHED, false);
>  	else if (weight_resched1)
> -		VERBOSE_SCFTORTOUT_ERRSTRING("built as module, weight_resched ignored");
> +		SCFTORTOUT_ERRSTRING("built as module, weight_resched ignored");
>  	scf_sel_add(weight_single1, SCF_PRIM_SINGLE, false);
>  	scf_sel_add(weight_single_rpc1, SCF_PRIM_SINGLE_RPC, true);
>  	scf_sel_add(weight_single_wait1, SCF_PRIM_SINGLE, true);
> @@ -621,7 +620,7 @@ static int __init scf_torture_init(void)
>  		nthreads = num_online_cpus();
>  	scf_stats_p = kcalloc(nthreads, sizeof(scf_stats_p[0]), GFP_KERNEL);
>  	if (!scf_stats_p) {
> -		VERBOSE_SCFTORTOUT_ERRSTRING("out of memory");
> +		SCFTORTOUT_ERRSTRING("out of memory");
>  		firsterr = -ENOMEM;
>  		goto unwind;
>  	}
> -- 
> 2.32.0
> 
