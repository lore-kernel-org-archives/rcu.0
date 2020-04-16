Return-Path: <SRS0=pJ0D=6A=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07646C2BA19
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 00:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCB3320936
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 00:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586996643;
	bh=FCPe1gayukNxr6qjvG7Hl461TNHn+GLs5pWruehW7UA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=E7KLcFDRjOJfkHgmll8CQFnitTJF/fVXSLoKoCx/AJyF93cQx6xVCCeIRDcABA3w2
	 6GiI1SXRgDRPj9G3KbfI7aHtNN9FApBe/7xytWCl+hdY853gTGAlG62Ol8NCberKUT
	 YF3xEFFCJzbN9YkD3tXg4Wm93bOLUXT5H81W69a0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733259AbgDPAYD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 20:24:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:35784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729384AbgDPAYB (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 20:24:01 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2938F20936;
        Thu, 16 Apr 2020 00:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586996641;
        bh=FCPe1gayukNxr6qjvG7Hl461TNHn+GLs5pWruehW7UA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=kNauBICbBFUNAiQ/ThXe/hN2YgD9t/61tLxnOUklq/4ZPOCM+JFOwv2aPx8YYCU1L
         eP/ck+uTpuqcdfv59OD6IBTrFqT9/hhWMIJxwGrA7KgRdXvkUcyWmlbtEhzBmXnMOV
         0KnO9WMXMXylJ8YtoSIsns10BM+RcXHcG+N1MPPQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id EFE403522AD1; Wed, 15 Apr 2020 17:24:00 -0700 (PDT)
Date:   Wed, 15 Apr 2020 17:24:00 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     josh@joshtriplett.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: init and destroy rcu_synchronize when necessary
Message-ID: <20200416002400.GL17661@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200415222655.9006-1-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415222655.9006-1-richard.weiyang@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Apr 15, 2020 at 10:26:55PM +0000, Wei Yang wrote:
> We would skip the rcu_synchronize if it is a duplicate call back function.
> 
> This is not necessary to init and destroy for them.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

Applied, thank you!

I edited the commit log a bit.  Could you please check below to make
sure that I didn't mess anything up?

							Thanx, Paul

------------------------------------------------------------------------

commit d9eaddf545fe8e3e2725e2fa0bf87b59b5667c14
Author: Wei Yang <richard.weiyang@gmail.com>
Date:   Wed Apr 15 22:26:55 2020 +0000

    rcu: Initialize and destroy rcu_synchronize only when necessary
    
    The __wait_rcu_gp() function unconditionally initializes and cleans up
    each element of rs_array[], whether used or not.  This is slightly
    wasteful and rather confusing, so this commit skips both initialization
    and cleanup for duplicate callback functions.
    
    Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 3ce63a9..351c322 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -391,13 +391,14 @@ void __wait_rcu_gp(bool checktiny, int n, call_rcu_func_t *crcu_array,
 			might_sleep();
 			continue;
 		}
-		init_rcu_head_on_stack(&rs_array[i].head);
-		init_completion(&rs_array[i].completion);
 		for (j = 0; j < i; j++)
 			if (crcu_array[j] == crcu_array[i])
 				break;
-		if (j == i)
+		if (j == i) {
+			init_rcu_head_on_stack(&rs_array[i].head);
+			init_completion(&rs_array[i].completion);
 			(crcu_array[i])(&rs_array[i].head, wakeme_after_rcu);
+		}
 	}
 
 	/* Wait for all callbacks to be invoked. */
@@ -408,9 +409,10 @@ void __wait_rcu_gp(bool checktiny, int n, call_rcu_func_t *crcu_array,
 		for (j = 0; j < i; j++)
 			if (crcu_array[j] == crcu_array[i])
 				break;
-		if (j == i)
+		if (j == i) {
 			wait_for_completion(&rs_array[i].completion);
-		destroy_rcu_head_on_stack(&rs_array[i].head);
+			destroy_rcu_head_on_stack(&rs_array[i].head);
+		}
 	}
 }
 EXPORT_SYMBOL_GPL(__wait_rcu_gp);
