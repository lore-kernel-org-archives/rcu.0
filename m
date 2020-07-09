Return-Path: <SRS0=ITGo=AU=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B7DC433E0
	for <rcu@archiver.kernel.org>; Thu,  9 Jul 2020 17:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 017D8207D0
	for <rcu@archiver.kernel.org>; Thu,  9 Jul 2020 17:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594314201;
	bh=igFSNKKS5NdCGv2fBB42fd6cCcs16m6B1pUpzlwK4lI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=2QeTdBc0mD07XnNJBMD4Vrld1p9R5qgSChvm6SYkxJZ+vuuZJBs/I/pPpNQGubfTZ
	 5cgBBRiRnU885anq2iUWKgWzq2Rm3oOzjOg86lriV41GNIy/hu7El4LpGCTMmTyoCZ
	 4C6RCcYkB6vRic4ugG0GXuJXgAOBVkTWwXHwkFH4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgGIRDU (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 9 Jul 2020 13:03:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:46026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbgGIRDU (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 9 Jul 2020 13:03:20 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 227B62078B;
        Thu,  9 Jul 2020 17:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594314200;
        bh=igFSNKKS5NdCGv2fBB42fd6cCcs16m6B1pUpzlwK4lI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=nPS+cqokYjJpchpGcq54RkBwv+MX+F02y849fUWp3f3BaHI1RLVGrGC/Eqp8VZfeq
         km56U3EHQzmFbKrjLvFI2ls6wi2lIF3lrPt1U6lDB0i0TqvykTdu/ByZUiVKbeF4qF
         hBM8gzg8489pVjpeA/1JPWJL4a3pjWw9Gv7h2fA0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 0AB153522CE7; Thu,  9 Jul 2020 10:03:20 -0700 (PDT)
Date:   Thu, 9 Jul 2020 10:03:20 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Tobias Klauser <tklauser@distanz.ch>
Cc:     Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org
Subject: Re: [PATCH v2] rcu: fix kerneldoc comments in rcuupdate.h
Message-ID: <20200709170320.GE9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200709130559.25588-1-tklauser@distanz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709130559.25588-1-tklauser@distanz.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jul 09, 2020 at 03:05:59PM +0200, Tobias Klauser wrote:
> Fix the kerneldoc comments for rcu_read_unlock_bh(),
> rcu_read_unlock_sched() and rcu_head_after_call_rcu() so they e.g. get
> properly linked in the API documentation. Also add parenthesis after
> function names to match the notation used in other kerneldoc comments in
> the same file.
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Queued, thank you!

							Thanx, Paul

> ---
> v2: extend commit message to explain added "()" after functio  names
> 
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
