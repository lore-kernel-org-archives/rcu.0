Return-Path: <SRS0=ZNv1=EE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B1CC4363A
	for <rcu@archiver.kernel.org>; Thu, 29 Oct 2020 16:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 864A7214DB
	for <rcu@archiver.kernel.org>; Thu, 29 Oct 2020 16:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDcGD5Fk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbgJ2Qvr (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 29 Oct 2020 12:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbgJ2Quh (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 29 Oct 2020 12:50:37 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A5EC0613D6;
        Thu, 29 Oct 2020 09:50:37 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id y184so2225521lfa.12;
        Thu, 29 Oct 2020 09:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Wc02XaEw+MkdyCkLxl/H0wu90RBnxL4HVWq12itskk=;
        b=FDcGD5FkdTzZb1Ffd7DdaIXkH4AYeDKFsHRhdg9FGozcGwv+vG2fKsv/h6hjx0z0SX
         O2XqOcoc5ES0KmXI1Q+TtkdiKLgqqVDHmbLgxxJp88A2pB30GT9QQUsG4mc7QJCbFlmo
         otm7VztlG5QJESsvV+xuICpihxMkYGasDQuqFKgiimsrtfVr94K1oZwo1v5qxEkwR471
         xwtVWhPbTclzuw8SZzAl2UKem8Y0V5YpCcdFY6Lr4aKt4YQbkWn7u6UUrd0VpxD+Lls3
         8Eh7gRIfvR2KWraCbjBwLrFDxLQCHMLlb5IpT4XfSHwK+HevUh96sg96D/Af3Zk/ZNX7
         eO4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Wc02XaEw+MkdyCkLxl/H0wu90RBnxL4HVWq12itskk=;
        b=AXaI7Ms6I6F9unvZyNzxXJAn//Mh6FYTsArAFH4FBdlYSuo8GogYkZzCt2rdT7L8T6
         KTj98FgzKrg55C7dGaEJy+KAsZcfl/KlG+iShLZ8TmfYlmQ0h0txacBkIWxyP0gfeyaU
         Vcqnqa0eZGCG3qF6ucf7kUKuPa+ywGGf4NAFBViDuzSTX28BziVQnkZ2QAAH6Ac0DajP
         fjv13I/wAZIBNz9Gy6wjKFuH+BDub6V3SIC2h2uMPQx+z3RZ82tltXZNTRx3wLqhTJUk
         0A+3av1YNtMf8LZCkctPsvAYFAcUEqj2yXa4QneLHIf0tAkaZTCO7wdW65yhb/3CFINz
         DnMQ==
X-Gm-Message-State: AOAM531Upitj4/rdZ0K9hGH9mGmvFabLYsiTXejQe8cUFzgFSWTm6lXA
        4P+OcUniE2O4BtAvp2dq+nSApUtvag3wLw==
X-Google-Smtp-Source: ABdhPJwh25PXsfs7oCTTRgU00nBhcb5z1GRewfbf3vrHWMUNkMGFgkeXrCHPxdR3icnO0IL6VJw2gQ==
X-Received: by 2002:a05:6512:36c7:: with SMTP id e7mr1898529lfs.206.1603990235320;
        Thu, 29 Oct 2020 09:50:35 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id s1sm331832lfd.236.2020.10.29.09.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 09:50:34 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 03/16] preempt: Make preempt count unconditional
Date:   Thu, 29 Oct 2020 17:50:06 +0100
Message-Id: <20201029165019.14218-3-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201029165019.14218-1-urezki@gmail.com>
References: <20201029165019.14218-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The handling of preempt_count() is inconsistent accross kernel
configurations. On kernels which have PREEMPT_COUNT=n
preempt_disable/enable() and the lock/unlock functions are not affecting
the preempt count, only local_bh_disable/enable() and _bh variants of
locking, soft interrupt delivery, hard interrupt and NMI context affect it.

It's therefore impossible to have a consistent set of checks which provide
information about the context in which a function is called. In many cases
it makes sense to have seperate functions for seperate contexts, but there
are valid reasons to avoid that and handle different calling contexts
conditionally.

The lack of such indicators which work on all kernel configuratios is a
constant source of trouble because developers either do not understand the
implications or try to work around this inconsistency in weird
ways. Neither seem these issues be catched by reviewers and testing.

Recently merged code does:

	 gfp = preemptible() ? GFP_KERNEL : GFP_ATOMIC;

Looks obviously correct, except for the fact that preemptible() is
unconditionally false for CONFIF_PREEMPT_COUNT=n, i.e. all allocations in
that code use GFP_ATOMIC on such kernels.

Attempts to make preempt count unconditional and consistent have been
rejected in the past with handwaving performance arguments.

Freshly conducted benchmarks did not reveal any measurable impact from
enabling preempt count unconditionally. On kernels with CONFIG_PREEMPT_NONE
or CONFIG_PREEMPT_VOLUNTARY the preempt count is only incremented and
decremented but the result of the decrement is not tested. Contrary to that
enabling CONFIG_PREEMPT which tests the result has a small but measurable
impact due to the conditional branch/call.

It's about time to make essential functionality of the kernel consistent
accross the various preemption models.

Enable CONFIG_PREEMPT_COUNT unconditionally. Follow up changes will remove
the #ifdeffery and remove the config option at the end.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/Kconfig.preempt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index bf82259cff96..3f4712ff073b 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -75,8 +75,7 @@ config PREEMPT_RT
 endchoice
 
 config PREEMPT_COUNT
-       bool
+       def_bool y
 
 config PREEMPTION
        bool
-       select PREEMPT_COUNT
-- 
2.20.1

