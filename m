Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FDEC433E9
	for <rcu@archiver.kernel.org>; Wed, 17 Mar 2021 17:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1DF864F33
	for <rcu@archiver.kernel.org>; Wed, 17 Mar 2021 17:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhCQRyk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 17 Mar 2021 13:54:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:38986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232841AbhCQRyV (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 17 Mar 2021 13:54:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 14B1A64F0C;
        Wed, 17 Mar 2021 17:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616003661;
        bh=41QZwWW5tYAibto8TpolceGNj3ZYs0gZ5zu3UKONesU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Pr/58qmDEfhS/GI1yME6E8DwLRv0enGz3hFwUa2xD4GjqprN5+CY7zWm4YKIl0m7n
         u76sZ+IxqilHevHjVNHWSn2FjzLh12GPQltAJn6hVDXnq6gd8YSHtkCP9kSz9elpJG
         MHDUpIISUe7W+KWGE8XPtnAgNgsIA5OTDjoNk11pMthvicjpucti09RYnPBgStE53P
         ZRM7QNX/No30YiwO8FpAufuA2iUOZXnHjv2zTf/mOmc/Oo+Mje++dk1NBiNc5zuSiV
         i5ojC3F7kxqc+KAnLdwTiZ9sUTe4kCj3Jpb3qqqVHeIn0LCF4noHnsXShxNIr1/N9O
         iwrhuwh1m8Fkw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 9674635237A3; Wed, 17 Mar 2021 10:54:20 -0700 (PDT)
Date:   Wed, 17 Mar 2021 10:54:20 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Rolf Eike Beer <eb@emlix.com>
Cc:     linux-kernel@vger.kernel.org, trivial@kernel.org,
        rcu@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] typo: kthead -> kthread
Message-ID: <20210317175420.GD2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <2268277.hsbtYad1Uq@devpool47>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2268277.hsbtYad1Uq@devpool47>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Mar 17, 2021 at 10:24:51AM +0100, Rolf Eike Beer wrote:
> Signed-off-by: Rolf Eike Beer <eb@emlix.com>
> ---
>  kernel/rcu/tree_plugin.h | 2 +-
>  mm/oom_kill.c            | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Good eyes, queued, thank you!

							Thanx, Paul

> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 2d603771c7dc..5f22869d7c66 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -1861,7 +1861,7 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>  }
>  
>  /*
> - * Awaken the no-CBs grace-period kthead if needed, either due to it
> + * Awaken the no-CBs grace-period kthread if needed, either due to it
>   * legitimately being asleep or due to overload conditions.
>   *
>   * If warranted, also wake up the kthread servicing this CPUs queues.
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 9efaf430cfd3..cd7f9ac48746 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -922,7 +922,7 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
>  			continue;
>  		}
>  		/*
> -		 * No kthead_use_mm() user needs to read from the userspace so
> +		 * No kthread_use_mm() user needs to read from the userspace so
>  		 * we are ok to reap it.
>  		 */
>  		if (unlikely(p->flags & PF_KTHREAD))
> -- 
> 2.30.2
> 
> -- 
> Rolf Eike Beer, emlix GmbH, http://www.emlix.com
> Fon +49 551 30664-0, Fax +49 551 30664-11
> Gothaer Platz 3, 37083 Göttingen, Germany
> Sitz der Gesellschaft: Göttingen, Amtsgericht Göttingen HR B 3160
> Geschäftsführung: Heike Jordan, Dr. Uwe Kracke – Ust-IdNr.: DE 205 198 055
> 
> emlix - smart embedded open source
> 
> 
> 
