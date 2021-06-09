Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDACC48BCD
	for <rcu@archiver.kernel.org>; Wed,  9 Jun 2021 20:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA0AF613E7
	for <rcu@archiver.kernel.org>; Wed,  9 Jun 2021 20:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhFIUjH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 9 Jun 2021 16:39:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:35740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229527AbhFIUjG (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 9 Jun 2021 16:39:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E567F613C7;
        Wed,  9 Jun 2021 20:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623271031;
        bh=ffSZlhzhbcUaE+U7uXQnWatQL71KPPN6+vezT0av1dA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=B0z+MJbqu2bKrGPpRsSks/CXq0ZpNLHTBjxL3r8jWhDGTI7Ck8KEv4aFs5rvSFKCw
         yGA88ZpwarmvEg+v+DRh2GaCQ+t5IDN3i4RpOfh9Zm1Y2BI2/rtPsQgiSeJfBqdnm1
         O4Nr095OtiFF+/T5UmNt7I0X1fYkaG12W9oQGLFmguMRzcylYo721wmUw1ZOADmUp6
         SNG0Dp7LC3C1+aP5S8gSEsKU9N7vMVZoyZO70wDeaihteLaY5O0jd0frvjORFnQ0eX
         Cbo3Pzo6LS7lHqGr/l4G80ORFatOUrNGrZq+bgDqLgfCZObZi8iMgWg3AMKsPXkjgL
         FSFzzu+7SnQ5A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B8BAB5C039E; Wed,  9 Jun 2021 13:37:11 -0700 (PDT)
Date:   Wed, 9 Jun 2021 13:37:11 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Jiangong.Han" <jiangong.han@windriver.com>
Cc:     dave@stgolabs.net, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org
Subject: Re: [PATCH] rcu-scale: change rcu-scale report.
Message-ID: <20210609203711.GL4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210605070019.30377-1-jiangong.han@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210605070019.30377-1-jiangong.han@windriver.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Jun 05, 2021 at 03:00:19PM +0800, Jiangong.Han wrote:
> The report on rcu-scale shows there are N grace periods, and gps
> are listed from 0 to N-1.
> This commit make writer_n_durations stores the counts of gps,
> change the listed gps index begin from 1 to N.
> 
> From
>     [ 8306.087880] rcu-scale: writer 0 gps: 133
>     ......
>     [ 8307.864630] rcu-scale:    0 writer-duration:     0 44003961
>     [ 8307.935711] rcu-scale:    0 writer-duration:     1 32003582
>     ......
>     [ 8316.472860] rcu-scale:    0 writer-duration:   131 28004391
>     [ 8316.538498] rcu-scale:    0 writer-duration:   132 27996410
> 
> to
>     [ 8306.087880] rcu-scale: writer 0 gps: 133
>     ......
>     [ 8307.864630] rcu-scale:    0 writer-duration:     1 44003961
>     [ 8307.935711] rcu-scale:    0 writer-duration:     2 32003582
>     ......
>     [ 8316.472860] rcu-scale:    0 writer-duration:   132 28004391
>     [ 8316.538498] rcu-scale:    0 writer-duration:   133 27996410
> 
> Signed-off-by: Jiangong.Han <jiangong.han@windriver.com>

You lost me on this one.  Why is this helpful?  And how does the change
shown below actually result in the output shown above, given that
rcu_scale_cleanup() still starts j at zero?

							Thanx, Paul

> ---
>  kernel/rcu/rcuscale.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
> index dca51fe9c73f..2cc34a22a506 100644
> --- a/kernel/rcu/rcuscale.c
> +++ b/kernel/rcu/rcuscale.c
> @@ -487,7 +487,7 @@ rcu_scale_writer(void *arg)
>  	if (gp_async) {
>  		cur_ops->gp_barrier();
>  	}
> -	writer_n_durations[me] = i_max;
> +	writer_n_durations[me] = i_max + 1;
>  	torture_kthread_stopping("rcu_scale_writer");
>  	return 0;
>  }
> @@ -561,7 +561,7 @@ rcu_scale_cleanup(void)
>  			wdpp = writer_durations[i];
>  			if (!wdpp)
>  				continue;
> -			for (j = 0; j <= writer_n_durations[i]; j++) {
> +			for (j = 0; j < writer_n_durations[i]; j++) {
>  				wdp = &wdpp[j];
>  				pr_alert("%s%s %4d writer-duration: %5d %llu\n",
>  					scale_type, SCALE_FLAG,
> -- 
> 2.17.1
> 
