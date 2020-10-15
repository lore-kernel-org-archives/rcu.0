Return-Path: <SRS0=9/AT=DW=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED0BC433E7
	for <rcu@archiver.kernel.org>; Thu, 15 Oct 2020 17:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE0A02225F
	for <rcu@archiver.kernel.org>; Thu, 15 Oct 2020 17:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602783497;
	bh=RmQH3oTA22KdAY64/nPzF6yHbVa2dvgS3GsObLLdovY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=bvAnDbp/462QOoN7JsB8wLWXlDq9BlhDGxSKcNVwzmqinArDdz9Igu2JZisryC4+E
	 f3JL06k3pGjoZEsxHELx1OizSR4n6e/CNxzgHU69yrR8clKjuf9q8eS0/xuLbeoPgr
	 VugTOCnP9KqVhrVYSY2kIWmOloJ2Ug4VRkNpDA+M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731271AbgJORiR (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 15 Oct 2020 13:38:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:43870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731233AbgJORiR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 15 Oct 2020 13:38:17 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DD6122254;
        Thu, 15 Oct 2020 17:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602783496;
        bh=RmQH3oTA22KdAY64/nPzF6yHbVa2dvgS3GsObLLdovY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=YB+OOaaQldZG4gG6USbGpvMOZ6FolCgdCGlID/hhmWwQEWytSSvYxHBnXY6aH6L/t
         vEzfKGGJRVaevEe+/nbok42jYLK/YeRpsEJGuvTFpdj0sM7rjJ5aMg0afTN12R0+jB
         18AzzuLnWfCyFbkTH3/Yd9IoSWUi151Utveml3nU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1AAF3352078F; Thu, 15 Oct 2020 10:38:16 -0700 (PDT)
Date:   Thu, 15 Oct 2020 10:38:16 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Hui Su <sh_def@163.com>
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, corbet@lwn.net, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs/rcu: update the api of call_rcu()
Message-ID: <20201015173816.GZ3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201015141334.GA20723@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015141334.GA20723@rlk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Oct 15, 2020 at 10:13:34PM +0800, Hui Su wrote:
> update the api of call_rcu()
> 
> Signed-off-by: Hui Su <sh_def@163.com>

Good point, the typedef is more compact.  Queued, thank you!

							Thanx, Paul

> ---
>  Documentation/RCU/whatisRCU.rst | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
> index c7f147b8034f..aa7d5ed20da5 100644
> --- a/Documentation/RCU/whatisRCU.rst
> +++ b/Documentation/RCU/whatisRCU.rst
> @@ -497,8 +497,7 @@ long -- there might be other high-priority work to be done.
>  In such cases, one uses call_rcu() rather than synchronize_rcu().
>  The call_rcu() API is as follows::
>  
> -	void call_rcu(struct rcu_head * head,
> -		      void (*func)(struct rcu_head *head));
> +	void call_rcu(struct rcu_head *head, rcu_callback_t func);
>  
>  This function invokes func(head) after a grace period has elapsed.
>  This invocation might happen from either softirq or process context,
> -- 
> 2.25.1
> 
> 
