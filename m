Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025ADC4332F
	for <rcu@archiver.kernel.org>; Fri,  3 Nov 2023 21:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjKCVdH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 3 Nov 2023 17:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjKCVdH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 3 Nov 2023 17:33:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995F11A8;
        Fri,  3 Nov 2023 14:33:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97329C433C9;
        Fri,  3 Nov 2023 21:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699045991;
        bh=+Igi/lFwr57gBQvQdonrHcdpinPyg9JShPR8XF/aqCY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=MRo4zvTlhjpcwyhHiYMFbi3T+LMghihO8qW21zwDiKZAKHv/+4W9hEuAR2GlPmbQK
         2iVtRSvMrf5Q0E98DyQ5v8rPiPJL22ISoCr+dQnkH9NSVH7ASDOCyYdwVWQ1rOVgVX
         m+RG+oQpvS081h5YIo52yqXQ3zKANORoiqXqeBeUC8Y7OkLgjLOGcUcN0vKyy1VK3V
         6IkSTbWYuWDMgwdvOJxruUGk+f5r6JidYzlQMoCGdNmh9UEGfxZT7NawE5J9BaLLl6
         +5RqzeKT5FtKf+d4qDu2e/SmJrI4Bq77fP1u5FtqJTgngykwvZCIUH/mq2uAchS8ly
         r8xvtnFi9BW5Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 359F6CE0E17; Fri,  3 Nov 2023 14:13:11 -0700 (PDT)
Date:   Fri, 3 Nov 2023 14:13:11 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang.zhang1211@gmail.com>
Cc:     frederic@kernel.org, joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcutorture: Add fqs_holdoff check before the fqs_task is
 created
Message-ID: <b8fdfee6-793b-4c88-9af4-152e4803f7b2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231103072639.11426-1-qiang.zhang1211@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103072639.11426-1-qiang.zhang1211@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Nov 03, 2023 at 03:26:39PM +0800, Zqiang wrote:
> For rcutorture tests that support fqs operations and set fqs_duration
> greater than zero, the fqs_task kthread will be created. but if the
> fqs_holdoff is not set, the default value is zero, this cause fqs_task
> enter a long-term busy loop and won't voluntarily give up the CPU until
> stopped by kthread_stop(). this commit therefore add for fqs_holdoff check
> before the fqs_task is created, make sure the fqs_task is created when
> the fqs_holdoff is also greater than zero.
> 
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>

Queued and pushed, thank you!

							Thanx, Paul

------------------------------------------------------------------------

commit 964f05cdec9f84be006fd836d64d04e79a50cb31
Author: Zqiang <qiang.zhang1211@gmail.com>
Date:   Fri Nov 3 15:26:39 2023 +0800

    rcutorture: Add fqs_holdoff check before fqs_task is created
    
    For rcutorture tests on RCU implementations that support
    force-quiescent-state operations and that set the fqs_duration module
    parameter greater than zero, the fqs_task kthread will be created.
    However, if the fqs_holdoff module parameter is not set, then its default
    value of zero will cause fqs_task enter a long-term busy loop until
    stopped by kthread_stop().  This commit therefore adds a fqs_holdoff
    check before the fqs_task is created, making sure that whenever the
    fqs_task is created, the fqs_holdoff will be greater than zero.
    
    Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 83999e57b3eaf..9f0e6c1cad443 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -3886,7 +3886,9 @@ rcu_torture_init(void)
 	}
 	if (fqs_duration < 0)
 		fqs_duration = 0;
-	if (fqs_duration) {
+	if (fqs_holdoff < 0)
+		fqs_holdoff = 0;
+	if (fqs_duration && fqs_holdoff) {
 		/* Create the fqs thread */
 		firsterr = torture_create_kthread(rcu_torture_fqs, NULL,
 						  fqs_task);
