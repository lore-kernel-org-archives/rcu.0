Return-Path: <SRS0=f31y=DF=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A58BC47420
	for <rcu@archiver.kernel.org>; Mon, 28 Sep 2020 03:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0A11239EB
	for <rcu@archiver.kernel.org>; Mon, 28 Sep 2020 03:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601264477;
	bh=QTlHXalHUZzzoBUIyhBOZL2ALMC9Qtv9NgtUk/coLoM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=g57hFPb+ibSBSsLrV4bEqGlL6aXMrt6Om62EaWZacnZ2zCtjuCdFlbIIX9maxUC9f
	 q0JomrUGZOBl8c8uNGIICgn19Fj18Pz7JXZCgycjDpZjXgOvcV0HIi+P/e7phsdIMD
	 rx0SFiyx0tsrLDKuqsP8FiGV9djtb7GU3ii6huIE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgI1DlR (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 27 Sep 2020 23:41:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:53376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbgI1DlQ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 27 Sep 2020 23:41:16 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E09E20B80;
        Mon, 28 Sep 2020 03:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601264476;
        bh=QTlHXalHUZzzoBUIyhBOZL2ALMC9Qtv9NgtUk/coLoM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=LxRNw1BgfbXuGoXBHDszN1IdgfoEaZLBcCyVSgbMMNTyS+bHQAVzktioJ/F92u7lW
         iCvG20bR8S5wGK3Ktbe5b0iyRJCaLCF1RYzNkFWacOSPOvfcFPiYdlNiRrqG4pIMyn
         pXGgxMiRtsZbtbbzIcihWn1vBAxPhzY4RqBd/VOI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 0C9803520FBE; Sun, 27 Sep 2020 20:41:16 -0700 (PDT)
Date:   Sun, 27 Sep 2020 20:41:16 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Neeraj Upadhyay <neeraju@codeaurora.org>, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Clarify nocb kthreads naming in RCU_NOCB_CPU config
Message-ID: <20200928034116.GM29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <1600929250-20344-1-git-send-email-neeraju@codeaurora.org>
 <20200928001342.GD500818@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928001342.GD500818@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Sep 27, 2020 at 08:13:42PM -0400, Joel Fernandes wrote:
> On Thu, Sep 24, 2020 at 12:04:10PM +0530, Neeraj Upadhyay wrote:
> > Clarify the "x" in rcuox/N naming in RCU_NOCB_CPU config
> > description.
> > 
> 
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Thank you, I will apply your Reviewed-by on the next rebase.

						Thanx, Paul

> thanks,
> 
>  - Joel
> 
> > Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
> > ---
> >  kernel/rcu/Kconfig | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> > 
> > diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> > index b71e21f..5b22747 100644
> > --- a/kernel/rcu/Kconfig
> > +++ b/kernel/rcu/Kconfig
> > @@ -227,11 +227,12 @@ config RCU_NOCB_CPU
> >  	  specified at boot time by the rcu_nocbs parameter.  For each
> >  	  such CPU, a kthread ("rcuox/N") will be created to invoke
> >  	  callbacks, where the "N" is the CPU being offloaded, and where
> > -	  the "p" for RCU-preempt (PREEMPTION kernels) and "s" for RCU-sched
> > -	  (!PREEMPTION kernels).  Nothing prevents this kthread from running
> > -	  on the specified CPUs, but (1) the kthreads may be preempted
> > -	  between each callback, and (2) affinity or cgroups can be used
> > -	  to force the kthreads to run on whatever set of CPUs is desired.
> > +	  the "x" is "p" for RCU-preempt (PREEMPTION kernels) and "s" for
> > +	  RCU-sched (!PREEMPTION kernels).  Nothing prevents this kthread
> > +	  from running on the specified CPUs, but (1) the kthreads may be
> > +	  preempted between each callback, and (2) affinity or cgroups can
> > +	  be used to force the kthreads to run on whatever set of CPUs is
> > +	  desired.
> >  
> >  	  Say Y here if you want to help to debug reduced OS jitter.
> >  	  Say N here if you are unsure.
> > -- 
> > The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> > a Linux Foundation Collaborative Project
> > 
