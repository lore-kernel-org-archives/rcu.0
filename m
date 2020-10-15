Return-Path: <SRS0=9/AT=DW=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89F5C433DF
	for <rcu@archiver.kernel.org>; Thu, 15 Oct 2020 17:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 444772225E
	for <rcu@archiver.kernel.org>; Thu, 15 Oct 2020 17:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602783454;
	bh=tp/M0Ev1F5laBClbbe1dZK9CgXL3ObXZJGo6s1sDhgI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=D5bAkLqE2wQbtraTqYBIyogf0HjJXxGAWEUfPewXFINSpwTOgcAfoUaxpAl0gI8V3
	 OkfxTkTm5zEFaYWNx25ubKhhdt7i3zlNLc8cf0JMD9469PFUG1+0lozfhLResHnyBb
	 pYwPUToYzGAGeo/R9flpbNg5jtgpzjHjuONKgC90=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731240AbgJORhd (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 15 Oct 2020 13:37:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:43698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731233AbgJORhd (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 15 Oct 2020 13:37:33 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFDE322254;
        Thu, 15 Oct 2020 17:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602783453;
        bh=tp/M0Ev1F5laBClbbe1dZK9CgXL3ObXZJGo6s1sDhgI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=eceGFACzLR5ppMOtmoSmDfcMw5AHi9HxzB5Rwy7uWtnZkysizDh8BUjX/+XilXtc6
         bR6CHZGTUL5goQ26EM/SiHvxbdyLHdittYLOEDaFo4E6MCKpRJmBPvQMCOXiiamlB3
         2Z3O+IZV/lP301xfx619QYZUJ+rtYagcBjxHHQNk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 87502352078F; Thu, 15 Oct 2020 10:37:32 -0700 (PDT)
Date:   Thu, 15 Oct 2020 10:37:32 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RCU: fix a typo in comments of rcu_blocking_is_gp
Message-ID: <20201015173732.GY3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <1602733983-9803-1-git-send-email-zhouzhouyi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1602733983-9803-1-git-send-email-zhouzhouyi@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Oct 15, 2020 at 03:53:03AM +0000, Zhouyi Zhou wrote:
> There is a tiny typo in comment of function rcu_blocking_is_gp.
> 
> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>

Good catch, queued, thank you!

							Thanx, Paul

> ---
>  kernel/rcu/tree.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index f78ee75..4cca03f 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3512,7 +3512,7 @@ void __init kfree_rcu_scheduler_running(void)
>   * During early boot, any blocking grace-period wait automatically
>   * implies a grace period.  Later on, this is never the case for PREEMPTION.
>   *
> - * Howevr, because a context switch is a grace period for !PREEMPTION, any
> + * However, because a context switch is a grace period for !PREEMPTION, any
>   * blocking grace-period wait automatically implies a grace period if
>   * there is only one CPU online at any point time during execution of
>   * either synchronize_rcu() or synchronize_rcu_expedited().  It is OK to
> -- 
> 1.7.1
> 
