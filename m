Return-Path: <SRS0=q59W=DL=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1FFC4363C
	for <rcu@archiver.kernel.org>; Sun,  4 Oct 2020 15:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AA89206DD
	for <rcu@archiver.kernel.org>; Sun,  4 Oct 2020 15:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601826858;
	bh=qqhdLUTXgAVoaAfyn+BmSZJnVu9Mi3KQBvz3uiaqipY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=jzG23am8J8SfKGQ+pT1iimpONgLY+uK0dCzGn09IwA4rkaBguYrB7+UnT3arQgN4F
	 rjlLd0r+CtBYa0GFQi2xoUIX/ZROg2hsaNbutDj9mt67KOF7AC9lK448Sz8XLvnPdt
	 Ktfjw9uYipYj2bx6fhXGI/CcKQJK5P+oV8HE8jK0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725826AbgJDPyR (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 4 Oct 2020 11:54:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:33406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbgJDPyR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 4 Oct 2020 11:54:17 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6FB7206C1;
        Sun,  4 Oct 2020 15:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601826856;
        bh=qqhdLUTXgAVoaAfyn+BmSZJnVu9Mi3KQBvz3uiaqipY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=KV+UplelkgCNKz5+wWcFrjF6/8OROEQM/cyQQbHew9+6D+MfUeD/aDb6LV2cjiTWA
         BuNoNONEJdZTcFGYrnbUzIksmWM/IeFMuPjwhkj2a1QNWflMmVQtzBUIzlNVtDH+8j
         3xtnAd8MlxT4F9IfvdNm2pa44qvyN7hLvwHmOR0c=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 964E43522841; Sun,  4 Oct 2020 08:54:16 -0700 (PDT)
Date:   Sun, 4 Oct 2020 08:54:16 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Byungchul Park <byungchul.park@lge.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] rcu/tree: Make struct kernel_param_ops definitions
 const
Message-ID: <20201004155416.GM29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <cover.1601770305.git.joe@perches.com>
 <c5e4bf0622e261f474b213c9eb0b646f7cca2a72.1601770305.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5e4bf0622e261f474b213c9eb0b646f7cca2a72.1601770305.git.joe@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Oct 03, 2020 at 05:18:08PM -0700, Joe Perches wrote:
> These should be const, so make it so.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Queued for testing and review, thank you!

						Thanx, Paul

> ---
>  kernel/rcu/tree.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index f78ee759af9c..c4732bb80818 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -552,12 +552,12 @@ static int param_set_next_fqs_jiffies(const char *val, const struct kernel_param
>  	return ret;
>  }
>  
> -static struct kernel_param_ops first_fqs_jiffies_ops = {
> +static const struct kernel_param_ops first_fqs_jiffies_ops = {
>  	.set = param_set_first_fqs_jiffies,
>  	.get = param_get_ulong,
>  };
>  
> -static struct kernel_param_ops next_fqs_jiffies_ops = {
> +static const struct kernel_param_ops next_fqs_jiffies_ops = {
>  	.set = param_set_next_fqs_jiffies,
>  	.get = param_get_ulong,
>  };
> -- 
> 2.26.0
> 
