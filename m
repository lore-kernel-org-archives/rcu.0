Return-Path: <SRS0=Iwfc=46=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E2EC10DCE
	for <rcu@archiver.kernel.org>; Fri, 13 Mar 2020 13:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7334E20724
	for <rcu@archiver.kernel.org>; Fri, 13 Mar 2020 13:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584107388;
	bh=At/75gfQwkhyDMreQNSP6ToQofJ4Q7qQJMTCfs6C/io=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=cJh+NH8n74DM3t+6PK33Zk/ckBdxyV56Tl4FNLbJXhxkZTXkqsO04ZELrssfKkpld
	 BgtpvTxRo6x0Y1AIwwTBQDTd40u9X1J0Y+PgiKc2U7g870sg7DTWhJa8i8aS0lnATO
	 0rEERqJNeRT4lJVvM2GLq8Ja5fJwJoeluHlBHspk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgCMNts (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 13 Mar 2020 09:49:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:51002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbgCMNts (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 13 Mar 2020 09:49:48 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE868206B7;
        Fri, 13 Mar 2020 13:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584107387;
        bh=At/75gfQwkhyDMreQNSP6ToQofJ4Q7qQJMTCfs6C/io=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=GfU+L0K/k90Bm8na1YSrZ4vf9Wp9FDH+ezeOGE2p//LpG5E5IissloSZX08X1JsFp
         j/oEVSb8hnv0fk7S07leNxNxy9YQt0bE8AzwjCdxCnqcvRh7JhLNFrK0rE/GF7Dxsx
         byha3pKVZMSUuZKof6dyCxd4T0OZUKJFd/6XCmOw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 7FD4E3522719; Fri, 13 Mar 2020 06:49:47 -0700 (PDT)
Date:   Fri, 13 Mar 2020 06:49:47 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Qiujun Huang <hqjagain@gmail.com>
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] rcu-tasks: fix a modpost warning for
 rcu_tasks_rude_wait_gp
Message-ID: <20200313134947.GP3199@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200313113810.3840-1-hqjagain@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313113810.3840-1-hqjagain@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Mar 13, 2020 at 07:38:10PM +0800, Qiujun Huang wrote:
> Found by gcc:
> WARNING: modpost: "rcu_tasks_rude_wait_gp" [vmlinux] is a static
> EXPORT_SYMBOL_GPL
> 
> Signed-off-by: Qiujun Huang <hqjagain@gmail.com>

Good eyes, thank you!

However, the fix is instead to remove the EXPORT_SYMBOL_GPL().  I will
squash the removal of this line into a04838a348a9 ("rcu-tasks: Add an
RCU-tasks rude variant"), crediting you with catching this bug.

Again, thank you!

							Thanx, Paul

> ---
>  kernel/rcu/tasks.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index cd071b5d4274..04d3c583a9fc 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -447,7 +447,7 @@ static void rcu_tasks_be_rude(struct work_struct *work)
>  }
>  
>  // Wait for one rude RCU-tasks grace period.
> -static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
> +void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
>  {
>  	schedule_on_each_cpu(rcu_tasks_be_rude);
>  }
> -- 
> 2.17.1
> 
