Return-Path: <SRS0=yaJD=AC=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EFFC433DF
	for <rcu@archiver.kernel.org>; Sun, 21 Jun 2020 19:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE771208D5
	for <rcu@archiver.kernel.org>; Sun, 21 Jun 2020 19:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592769053;
	bh=sQvbvZtNC41Uuf34UfNxe7YlKtNvaxn2Hj0hrJb16ic=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=SfXmtuPDgecI9eMZOxoaTUHQ7QfYj3IW+CkjL98+vYosejaZ9Mnyvr8pujft4gdhe
	 u6haB3pV7NZbvL0hkZ7u2CyKrN+n9TanrxaR95iMCrE38gDbZRzTqM8Fsc818k0uzp
	 WKtB+vNe/1g2nGR4ClzLuQUEsZItZKlZT5UiwtyU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730541AbgFUTux (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 21 Jun 2020 15:50:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:50434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730375AbgFUTux (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 21 Jun 2020 15:50:53 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AEBF2084D;
        Sun, 21 Jun 2020 19:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592769053;
        bh=sQvbvZtNC41Uuf34UfNxe7YlKtNvaxn2Hj0hrJb16ic=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=cmannopnDOv4qkWaLIh5ai4GyQfnki8cosLeS6bTsQEeop4e6/Q6PvC55laeVbAEj
         ptKHftYZfGPqgVW40mXxfy9nLWR2sh2B5l0N9YUZ+f+51P0sazlkRKGmXpQDhG9EMx
         Rryxct6z2W7jbBJWGG6hJfuBYNo/whgT5EzMHBPg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E32EA3522FD1; Sun, 21 Jun 2020 12:50:52 -0700 (PDT)
Date:   Sun, 21 Jun 2020 12:50:52 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Neeraj Upadhyay <neeraju@codeaurora.org>
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/tree: Force quiescent state on callback overload
Message-ID: <20200621195052.GF9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <1592764647-2452-1-git-send-email-neeraju@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592764647-2452-1-git-send-email-neeraju@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Jun 22, 2020 at 12:07:27AM +0530, Neeraj Upadhyay wrote:
> On callback overload, we want to force quiescent state immediately,
> for the first and second fqs. Enforce the same, by including
> RCU_GP_FLAG_OVLD flag, in fqsstart check.
> 
> Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>

Good catch!

But what did you do to verify that this change does the right thing?

						Thanx, Paul

> ---
>  kernel/rcu/tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index d0988a1..6226bfb 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1865,7 +1865,7 @@ static void rcu_gp_fqs_loop(void)
>  			break;
>  		/* If time for quiescent-state forcing, do it. */
>  		if (!time_after(rcu_state.jiffies_force_qs, jiffies) ||
> -		    (gf & RCU_GP_FLAG_FQS)) {
> +		    (gf & (RCU_GP_FLAG_FQS | RCU_GP_FLAG_OVLD))) {
>  			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
>  					       TPS("fqsstart"));
>  			rcu_gp_fqs(first_gp_fqs);
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
