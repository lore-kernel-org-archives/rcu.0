Return-Path: <SRS0=SldO=A6=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA57BC433E1
	for <rcu@archiver.kernel.org>; Sun, 19 Jul 2020 16:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B477A21741
	for <rcu@archiver.kernel.org>; Sun, 19 Jul 2020 16:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595174868;
	bh=2BfF/nA6ErAFY5oFLxZej205Ou61k5E8QwnjkOKRk+0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=1wYeyuerTCLMfkJAhRCAFb+/bFx8mikdrUwto7u0i+mCD4na55FKNkAot1wov16lp
	 EFEN6qMPG/OjVyph6zg4cFCcgj4mWqNqqwqBvMV4IPmYrLIVOMDJIMZJPt5xC38N5I
	 2Nm+FeqDlve9b2aTr/FOoR7yUbNZYd0bW9UscBNQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgGSQHs (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 19 Jul 2020 12:07:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:37488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726135AbgGSQHs (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 19 Jul 2020 12:07:48 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB42920B1F;
        Sun, 19 Jul 2020 16:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595174867;
        bh=2BfF/nA6ErAFY5oFLxZej205Ou61k5E8QwnjkOKRk+0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=GmqHxtkWB4ds/QN/SoElqW7DkCtXZvxM/FlSlXH2lEzzBioNABMrbzVq6YcRDfT8U
         e8lfW9CsDVg0onGmBK4sVlyfbE0koxvYjRkepb4/3XrocRM3w0337rrOKsQRYdBBUV
         NGpfUUgDdCdtlCg1UlB/pK0bF0WzSZvdEDwcs2t4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id BB3A53522960; Sun, 19 Jul 2020 09:07:47 -0700 (PDT)
Date:   Sun, 19 Jul 2020 09:07:47 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Suraj Upadhyay <usuraj35@gmail.com>
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, madhuparnabhowmik10@gmail.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rculist: Silence unused-value warning.
Message-ID: <20200719160747.GE9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200719105037.GA21010@blackclown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200719105037.GA21010@blackclown>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Jul 19, 2020 at 04:20:37PM +0530, Suraj Upadhyay wrote:
> The macro __list_check_srcu is used as a statement inside a for loop.
> 
> __list_check_srcu becomes "true" when CONFIG_PROVE_RCU_LIST is not defined.
> This results in compiler warning about an unused value ("true").
> 
> Silence the compiler warning about the unused value "true"
> by replacing it with an empty expression.
> 
> Signed-off-by: Suraj Upadhyay <usuraj35@gmail.com>

Like this, you mean, give or take whitespace?  ;-)

https://lore.kernel.org/lkml/20200718001259.GY9247@paulmck-ThinkPad-P72/

May I add your Tested-by?

							Thanx, Paul

> ---
>  include/linux/rculist.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/rculist.h b/include/linux/rculist.h
> index de9385b9158e..8b8e0584c473 100644
> --- a/include/linux/rculist.h
> +++ b/include/linux/rculist.h
> @@ -73,7 +73,7 @@ static inline void INIT_LIST_HEAD_RCU(struct list_head *list)
>  #define __list_check_rcu(dummy, cond, extra...)				\
>  	({ check_arg_count_one(extra); })
>  
> -#define __list_check_srcu(cond) true
> +#define __list_check_srcu(cond) ({})
>  #endif
>  
>  /*
> -- 
> 2.17.1
> 


