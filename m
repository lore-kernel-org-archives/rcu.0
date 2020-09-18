Return-Path: <SRS0=xZUe=C3=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CC2C43464
	for <rcu@archiver.kernel.org>; Fri, 18 Sep 2020 17:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AECF21741
	for <rcu@archiver.kernel.org>; Fri, 18 Sep 2020 17:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600451953;
	bh=RCXbSmb6TBTU6Nop+hAYsV3487c8KGvxhJr+53EhKec=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=bnA2wSChM8X7hltP0v+VM5tAOAOqWm/hYSJnQgRBNM4Lhk0mFR85Gv6pTSVzD5IiU
	 VHT396vpbr71hGOgoZOfJEU44kT+d+CtDWPIyhmvu1PjFF1QCok/7YXbq1qd9jRbHQ
	 Am4NA/+77hlmoK3kl9/p2TE01gBtkUftkLN/y7Kw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgIRR7N (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 18 Sep 2020 13:59:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:60608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbgIRR7M (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 18 Sep 2020 13:59:12 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00FBC21734;
        Fri, 18 Sep 2020 17:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600451952;
        bh=RCXbSmb6TBTU6Nop+hAYsV3487c8KGvxhJr+53EhKec=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ymfu+wGX0x9B5IGQMtA1nMLh/EusxF0K33xJ2JSuxrX8fKlJQsSTWuVJc0yPUewBv
         mFPmT6E9WrIkc7O2N3jaMFkxkMFIx8UPs+wPukeTQ2+jbY5Nyswc6lh+9iWjmaA/hs
         uLQMJiFtqU92H73YN52/pcnZv1qoumHyc5yVn5ME=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 9781A35226AD; Fri, 18 Sep 2020 10:59:11 -0700 (PDT)
Date:   Fri, 18 Sep 2020 10:59:11 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Hou Tao <houtao1@huawei.com>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH v2 1/2] locktorture: doesn't check nreaders_stress when
 no readlock support
Message-ID: <20200918175911.GV29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200918033755.GS29330@paulmck-ThinkPad-P72>
 <20200918114424.100852-1-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918114424.100852-1-houtao1@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Sep 18, 2020 at 07:44:24PM +0800, Hou Tao wrote:
> When do locktorture for exclusive lock which doesn't have readlock
> support, the following module parameters will be considered as valid:
> 
>  torture_type=mutex_lock nwriters_stress=0 nreaders_stress=1
> 
> But locktorture will do nothing useful, so instead of permitting
> these useless parameters, let's reject these parameters by returning
> -EINVAL during module init.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>

Much better, much easier for people a year from now to understand.
Queued for v5.11, thank you!

I did edit the commit log a bit as shown below, so please let me
know if I messed anything up.

							Thanx, Paul

commit 4985c52e3b5237666265e59f56856f485ee36e71
Author: Hou Tao <houtao1@huawei.com>
Date:   Fri Sep 18 19:44:24 2020 +0800

    locktorture: Ignore nreaders_stress if no readlock support
    
    Exclusive locks do not have readlock support, which means that a
    locktorture run with the following module parameters will do nothing:
    
     torture_type=mutex_lock nwriters_stress=0 nreaders_stress=1
    
    This commit therefore rejects this combination for exclusive locks by
    returning -EINVAL during module init.
    
    Signed-off-by: Hou Tao <houtao1@huawei.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 316531d..046ea2d 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -870,7 +870,8 @@ static int __init lock_torture_init(void)
 		goto unwind;
 	}
 
-	if (nwriters_stress == 0 && nreaders_stress == 0) {
+	if (nwriters_stress == 0 &&
+	    (!cxt.cur_ops->readlock || nreaders_stress == 0)) {
 		pr_alert("lock-torture: must run at least one locking thread\n");
 		firsterr = -EINVAL;
 		goto unwind;
