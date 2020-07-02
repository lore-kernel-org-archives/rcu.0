Return-Path: <SRS0=c9Wv=AN=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B2BC433E0
	for <rcu@archiver.kernel.org>; Thu,  2 Jul 2020 17:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC8A120760
	for <rcu@archiver.kernel.org>; Thu,  2 Jul 2020 17:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593709565;
	bh=or8Qpv+19yw15VzooHf8b1gkihnCUCJqFvQER+QDAzc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=SzpbKTBcvfqbAl91dktmtY/oO7HNk5n2JP7JAkGzFNPcri2UTTmxnxvDRL0qWid2g
	 ONP5zgwDPfmh/pbMNj+wDM4seA5nTYQO0i4OMK9iAA7T0r/96QnqGnQ3R7uqc8vF1N
	 DSuZ3dV+f3LsDkYNw7+kTx1ASqZSmMPq18pfAcC0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgGBRGF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 2 Jul 2020 13:06:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:34176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbgGBRGF (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 2 Jul 2020 13:06:05 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E774220720;
        Thu,  2 Jul 2020 17:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593709564;
        bh=or8Qpv+19yw15VzooHf8b1gkihnCUCJqFvQER+QDAzc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ASiaWKOifENrKL6OMa9IRWWNSQ0ofxbwm3ZKGZTA5PjBMrXyF86Wm7ggWvYwxlW9x
         Y8Hqs/8CF8CvnwgEOp9QwEeNLNYn5RUfYcSbk0jsPG55pIYmxWr6aUy36VbQazFkyd
         snpsHpfxR+DT7TPaIw+p/vOMdBzV8NtaHwz08Xlg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id CB0D13523164; Thu,  2 Jul 2020 10:06:04 -0700 (PDT)
Date:   Thu, 2 Jul 2020 10:06:04 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Tobias Klauser <tklauser@distanz.ch>
Cc:     Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org
Subject: Re: [PATCH] rcu: fix kerneldoc comments in rcuupdate.h
Message-ID: <20200702170604.GT9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200702162557.30734-1-tklauser@distanz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702162557.30734-1-tklauser@distanz.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jul 02, 2020 at 06:25:57PM +0200, Tobias Klauser wrote:
> Fix the kerneldoc comments for rcu_read_unlock_bh(),
> rcu_read_unlock_sched() and rcu_head_after_call_rcu() so they e.g. get
> properly linked in the API documentation.
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

The addition of the second "*" is clearly needed, good eyes and thank you!
But where do these entries link to?  As in does adding the "()" link
somewhere else, and if so, where?  If it instead links to the entry
created by the corresponding docbook comment, is that really helpful?

What am I missing here?

							Thanx, Paul

> ---
>  include/linux/rcupdate.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index d15d46db61f7..b47d6b66665e 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -709,8 +709,8 @@ static inline void rcu_read_lock_bh(void)
>  			 "rcu_read_lock_bh() used illegally while idle");
>  }
>  
> -/*
> - * rcu_read_unlock_bh - marks the end of a softirq-only RCU critical section
> +/**
> + * rcu_read_unlock_bh() - marks the end of a softirq-only RCU critical section
>   *
>   * See rcu_read_lock_bh() for more information.
>   */
> @@ -751,10 +751,10 @@ static inline notrace void rcu_read_lock_sched_notrace(void)
>  	__acquire(RCU_SCHED);
>  }
>  
> -/*
> - * rcu_read_unlock_sched - marks the end of a RCU-classic critical section
> +/**
> + * rcu_read_unlock_sched() - marks the end of a RCU-classic critical section
>   *
> - * See rcu_read_lock_sched for more information.
> + * See rcu_read_lock_sched() for more information.
>   */
>  static inline void rcu_read_unlock_sched(void)
>  {
> @@ -945,7 +945,7 @@ static inline void rcu_head_init(struct rcu_head *rhp)
>  }
>  
>  /**
> - * rcu_head_after_call_rcu - Has this rcu_head been passed to call_rcu()?
> + * rcu_head_after_call_rcu() - Has this rcu_head been passed to call_rcu()?
>   * @rhp: The rcu_head structure to test.
>   * @f: The function passed to call_rcu() along with @rhp.
>   *
> -- 
> 2.27.0
> 
