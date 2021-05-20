Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F0CC433B4
	for <rcu@archiver.kernel.org>; Thu, 20 May 2021 06:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A74E6611AB
	for <rcu@archiver.kernel.org>; Thu, 20 May 2021 06:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhETGTe (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 20 May 2021 02:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbhETGTe (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 20 May 2021 02:19:34 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01D0C06175F
        for <rcu@vger.kernel.org>; Wed, 19 May 2021 23:18:13 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id q15so11099239pgg.12
        for <rcu@vger.kernel.org>; Wed, 19 May 2021 23:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=01MV2hP3VJImp8lv5HjPWYkORCHdBsuXiy9X6dXV6YU=;
        b=DsRG7WxRE7EMzawpEEJOKHEzG9I7QHPq0kzxxD6dXmFCQGdKCs40LMDkMk0R1wcoFD
         +lv6rZ1ePCj3qrDc/Um2NyMQUdMtpgC3PwBa51r0rWoP3I+Qi0OfGcA1bNTi5uCBZtz4
         PehpSwwGHZc7hudZeNCx0mi3VE4prwfrexFq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=01MV2hP3VJImp8lv5HjPWYkORCHdBsuXiy9X6dXV6YU=;
        b=ntlNK7tnUnMVRBIzGjGvJ9Ir2wfmgkdu0PCN33dTPZiYLNYpK+5zTHkf5UPbBIhOAj
         xnn70SXM6pbRqmnqLqRjkA7N+kTEDDytkB2TuapZR2wPUNLT1oyekNyeAjdiBwJnhfBM
         nZ/rpXXHYmwk7FOv2C82A5SbdTDlliCrz8J17/0oQ/1x3io9H9+1oq8L0xfr0n+Mj477
         klUdbCE1Aw+CxrMeUAcyvGr2cpbCzebt4I++qmuvTX5iHATF4QXWCLFMee7TLM8XXmZo
         Tr3i5Z2aeYLE/9jqyQcqNzPNGX2pWdabkTpCyGqiKPt/JD5GXsqR0DOYS3UNQQaTHf1z
         5zhg==
X-Gm-Message-State: AOAM5305mUh/+l+qXREGkVQN5fvT9o64sB1BzztQHZVPg7PbYMWy8oW4
        AzNkq6FwIvnOdbCjUT18rJAjdw==
X-Google-Smtp-Source: ABdhPJwWnAZwLnVFnZ+A8woriH+Ho+piMTb6AvydDLDkPisvxoo5+SiK+QE67zK46llEijxDGrYEKA==
X-Received: by 2002:a63:64c6:: with SMTP id y189mr2932733pgb.333.1621491493223;
        Wed, 19 May 2021 23:18:13 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:48db:abf:343e:b4f7])
        by smtp.gmail.com with ESMTPSA id x21sm1073113pfr.124.2021.05.19.23.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 23:18:12 -0700 (PDT)
Date:   Thu, 20 May 2021 15:18:07 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suleiman Souhlal <suleiman@google.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/tree: consider time a VM was suspended
Message-ID: <YKX/H0EwRRLM+cAa@google.com>
References: <20210516102716.689596-1-senozhatsky@chromium.org>
 <20210517162312.GG4441@paulmck-ThinkPad-P17-Gen-1>
 <YKMbQQ0qBAixXC5p@google.com>
 <20210518231514.GS4441@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518231514.GS4441@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On (21/05/18 16:15), Paul E. McKenney wrote:
> 
> In the shorter term...  PVCLOCK_GUEST_STOPPED is mostly for things like
> guest migration and debugger breakpoints, correct?  Either way, I am
> wondering if rcu_cpu_stall_reset() should take a lighter touch.  Right
> now, it effectively disables all stalls for the current grace period.
> Why not make it restart the stall timeout when the stoppage is detected?

rcu_cpu_stall_reset() is used in many other places, not sure if we can
change its behaviour rcu_cpu_stall_reset().

Maybe it'll be possible to just stop calling it from PV-clock and do
something like this

---

diff --git a/arch/x86/kernel/pvclock.c b/arch/x86/kernel/pvclock.c
index eda37df016f0..2d2489eda8e6 100644
--- a/arch/x86/kernel/pvclock.c
+++ b/arch/x86/kernel/pvclock.c
@@ -40,7 +40,7 @@ void pvclock_touch_watchdogs(void)
 {
 	touch_softlockup_watchdog_sync();
 	clocksource_touch_watchdog();
-	rcu_cpu_stall_reset();
+	record_gp_stall_check_time();
 	reset_hung_task_detector();
 }
 
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index cb233c79f0bc..6b3165c7a2c3 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -137,7 +137,7 @@ void rcu_cpu_stall_reset(void)
 // Interaction with RCU grace periods
 
 /* Start of new grace period, so record stall time (and forcing times). */
-static void record_gp_stall_check_time(void)
+void record_gp_stall_check_time(void)
 {
 	unsigned long j = jiffies;
 	unsigned long j1;
