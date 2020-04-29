Return-Path: <SRS0=QSVt=6N=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950C2C83000
	for <rcu@archiver.kernel.org>; Wed, 29 Apr 2020 15:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7622621D79
	for <rcu@archiver.kernel.org>; Wed, 29 Apr 2020 15:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588175610;
	bh=lM+jf92e2hWloNhGNv0OCFyAzm6HTRAHqrzHcxhYL40=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=RiHdA8amiLJMkrCjQrpkB8yp6NJzmSALBDfkKS7zpK90tLC4XOajPOfUE69wItZ7q
	 iq9uF7xVx0SwMSXv6PfptLkgM51ViWfhadqBKGnor9uAtHrMILgt7SManW1BJydMr5
	 1lnPgHBGD5Y1Z82SR/rNVCo+2t7xJ2gFHu21AAQM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgD2Px1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 29 Apr 2020 11:53:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:41746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbgD2Px1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 29 Apr 2020 11:53:27 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8786221D91;
        Wed, 29 Apr 2020 15:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588175606;
        bh=lM+jf92e2hWloNhGNv0OCFyAzm6HTRAHqrzHcxhYL40=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=PAwfHGKpdCLYERO8SixsSL4SZwJ4f4MNKIMQQWlNZ1vaaa+PwQ8OeE784qTy3XzGg
         3Y8ZBcgbnZNTDZQdhyRs3AQsD5xf1DcgcvL7q9Rp4LhEO1kmh/OSKFeWECPN2rh1pL
         GTU+6jdibZn+ZBQbNCAGAP0RWpsnLXkQXtUEk+78=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 57DE335226DB; Wed, 29 Apr 2020 08:53:26 -0700 (PDT)
Date:   Wed, 29 Apr 2020 08:53:26 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] rcutorture: Fix error codes in
 rcu_torture_read_exit_init()
Message-ID: <20200429155326.GD7560@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200429132235.GA815283@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429132235.GA815283@mwanda>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Apr 29, 2020 at 04:22:35PM +0300, Dan Carpenter wrote:
> The rcu_torture_read_exit_init() function is supposed to return negative
> error codes which get propagated back down the call tree but the current
> code returns true on failure.
> 
> Fixes: e02882cd57e3 ("rcutorture: Add races with task-exit processing")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Good catch!  Talk about code sort of working by accident!!!

Thank you, and I folded this into the original commit with attribution.

						Thanx, Paul

> ---
>  kernel/rcu/rcutorture.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 269881e51dc6d..5270674128029 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -2434,10 +2434,10 @@ static int rcu_torture_read_exit(void *unused)
>  	return 0;
>  }
>  
> -static bool rcu_torture_read_exit_init(void)
> +static int rcu_torture_read_exit_init(void)
>  {
>  	if (read_exit <= 0)
> -		return true;
> +		return -EINVAL;
>  	init_waitqueue_head(&read_exit_wq);
>  	read_exit_child_stop = false;
>  	read_exit_child_stopped = false;
> -- 
> 2.26.2
> 
