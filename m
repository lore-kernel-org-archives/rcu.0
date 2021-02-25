Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532BEC433E0
	for <rcu@archiver.kernel.org>; Thu, 25 Feb 2021 00:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E135E64EC4
	for <rcu@archiver.kernel.org>; Thu, 25 Feb 2021 00:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234899AbhBYApN (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 24 Feb 2021 19:45:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:43768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234294AbhBYApL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 24 Feb 2021 19:45:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C09E64EC4;
        Thu, 25 Feb 2021 00:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614213871;
        bh=fyH4DGa7GSd0xYi4vBiKElcW2dOIEx2HBFx2q9HF7FE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=cLcE6/dc0DdXnUPc/KU+El7FJ3OGldfLawPvfPDBPzztYDiD5lUP0Is/cur8APns8
         uN15heotH5NpGqznmbscRM2DhVV09J7qv+fg3Hj5BEHmUHa7uNdahUED2/wGtv2YLd
         6EBCgXWj3VkAGA1PNrjcbjZH94QFjoNi5g9aJTD9fSSIP9hUTc91xsPNijk7l16Q83
         9mEG3Z2uDjKuJ0NG4KPAN9q6891yy/foDjVZ/C8jygkYB20apJFaXfj4BcJS57wZBe
         r2Q9sTP24K05URW3EE3Vc4s87nsJ+HWolCVT9siz+UtHG311rWb8BpxiZIKYOcwH4c
         Zp+eT1Sa3OQog==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id CBEEC3520D1E; Wed, 24 Feb 2021 16:44:30 -0800 (PST)
Date:   Wed, 24 Feb 2021 16:44:30 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: make nocb_nobypass_lim_per_jiffy static
Message-ID: <20210225004430.GA9420@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <1614155429-64546-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614155429-64546-1-git-send-email-jiapeng.chong@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Feb 24, 2021 at 04:30:29PM +0800, Jiapeng Chong wrote:
> Fix the following sparse warning:
> 
> kernel/rcu/tree_plugin.h:1497:5: warning: symbol
> 'nocb_nobypass_lim_per_jiffy' was not declared. Should it be static?
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Queued with Frederic's ack (given offlist), thank you both!

						Thanx, Paul

> ---
>  kernel/rcu/tree_plugin.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 2d60377..8ff8cf8 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -1494,7 +1494,7 @@ static int __init parse_rcu_nocb_poll(char *arg)
>   * After all, the main point of bypassing is to avoid lock contention
>   * on ->nocb_lock, which only can happen at high call_rcu() rates.
>   */
> -int nocb_nobypass_lim_per_jiffy = 16 * 1000 / HZ;
> +static int nocb_nobypass_lim_per_jiffy = 16 * 1000 / HZ;
>  module_param(nocb_nobypass_lim_per_jiffy, int, 0);
>  
>  /*
> -- 
> 1.8.3.1
> 
