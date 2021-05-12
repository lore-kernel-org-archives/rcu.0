Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DB4C433B4
	for <rcu@archiver.kernel.org>; Wed, 12 May 2021 18:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03CE061453
	for <rcu@archiver.kernel.org>; Wed, 12 May 2021 18:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243136AbhELSdT (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 12 May 2021 14:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355736AbhELS3J (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 12 May 2021 14:29:09 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED460C061345;
        Wed, 12 May 2021 11:23:20 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id s6so28157681edu.10;
        Wed, 12 May 2021 11:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fKX6JLMddsj2QIsWTB0q5RqXGPJy18yr11an7r8jFDE=;
        b=fNb8XvX2bdQFsgq//ZiupRvbehV4om2g6KZLv6vMDSvjZwo/79qo4Y7Tct3aEXyxHk
         SrR4Az+b37RCWN8rSvATI7PEPli2xayIrFM+9lyUwA+NrIcWK/STxRBGca7rB4v5mqbz
         vXmHrTkhYQsEs/7L72O6NVnc5fwVjbUi4s5za/WYWzOLWh7aWNJNj+Mq1rRvmLdkLYPf
         NPB2L33UJ2hzXdXwTvommus05b0Fp+dUujhIosfNR7eG8Z0JVk5b065xXn5l52X6ARFT
         J1348kpRggmlsytyojlPnoF6DPDY+nNR4NbsQzDXiCgxL9lSqiipbRXE9AD0Gm407m/k
         nAWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=fKX6JLMddsj2QIsWTB0q5RqXGPJy18yr11an7r8jFDE=;
        b=I5bx5fQfetT/PgcHaZ2KvvfIAF/8O1k1/TjthRDJ9p9loBEpbMvgeapLHaOm63ZiIl
         k4CoV1AveWMOKmZYuIGST5O1JOMGt31WSy3/QxmvwOkDJ+AGDFFMU5Im5Badb1NcQJiM
         IHLNOQf0SgVvKqVWPGzKQCrZwtjG9/B6myNBPebJtsuMknGe9pikaH/KYv2u4+29ACeO
         HlO3m75aGUqYgojlukMWW8aWsEj+0t8Mv3CQYtRd2LzPI2iPVN0qnQ8h7+z/G5ZAacvh
         6LXRuBzKwrZz25qihPUyTI4CRckYRwOChfqG52Zpwb/POlG4ohQz9Y/tHX5gPMdj/nQr
         fWow==
X-Gm-Message-State: AOAM532Q3W/SlpKg2rCLBBsMFNvx1shP5Jmm4OuPC1bdPSd4C0nmYSH5
        5I2USTb8VlNBeGG621agOGs=
X-Google-Smtp-Source: ABdhPJz+RMbEAG1HZqNZ29tkXkC2IHm6vt/BlwhGOKWig1DTOhsBrEmUVCdU3FZ77VigkqQOyfukcw==
X-Received: by 2002:a05:6402:12c6:: with SMTP id k6mr44791644edx.372.1620843799542;
        Wed, 12 May 2021 11:23:19 -0700 (PDT)
Received: from gmail.com (0526E777.dsl.pool.telekom.hu. [5.38.231.119])
        by smtp.gmail.com with ESMTPSA id e4sm296654ejh.98.2021.05.12.11.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 11:23:19 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 12 May 2021 20:23:17 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH tip/core/rcu 10/10] rcu: Fix various typos in comments
Message-ID: <YJwdFeb825Nzhpo2@gmail.com>
References: <20210511230244.GA2894061@paulmck-ThinkPad-P17-Gen-1>
 <20210511230336.2894314-10-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511230336.2894314-10-paulmck@kernel.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org


* Paul E. McKenney <paulmck@kernel.org> wrote:

> From: Ingo Molnar <mingo@kernel.org>
> 
> Fix ~12 single-word typos in RCU code comments.
> 
> [ paulmck: Apply feedback from Randy Dunlap. ]
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  kernel/rcu/srcutree.c                                     | 4 ++--
>  kernel/rcu/sync.c                                         | 4 ++--
>  kernel/rcu/tasks.h                                        | 8 ++++----
>  kernel/rcu/tree.c                                         | 4 ++--
>  kernel/rcu/tree.h                                         | 2 +-
>  kernel/rcu/tree_plugin.h                                  | 2 +-
>  .../selftests/rcutorture/formal/srcu-cbmc/src/locks.h     | 2 +-
>  7 files changed, 13 insertions(+), 13 deletions(-)

There's one more I missed.

Thanks,

	Ingo

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 60ad78560be3..a7dd763a70c3 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3848,7 +3848,7 @@ EXPORT_SYMBOL_GPL(start_poll_synchronize_rcu);
  *
  * If a full RCU grace period has elapsed since the earlier call from
  * which oldstate was obtained, return @true, otherwise return @false.
- * If @false is returned, it is the caller's responsibilty to invoke this
+ * If @false is returned, it is the caller's responsibility to invoke this
  * function later on until it does return @true.  Alternatively, the caller
  * can explicitly wait for a grace period, for example, by passing @oldstate
  * to cond_synchronize_rcu() or by directly invoking synchronize_rcu().

