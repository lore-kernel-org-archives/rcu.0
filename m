Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC515C4332B
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A489F64EFD
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239122AbhCDBAf (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:00:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:58958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352939AbhCDACo (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:02:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7B1B064FA5;
        Thu,  4 Mar 2021 00:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614816022;
        bh=Kp0pUDwbc2/Wi2wONM2Pspfg5qtgiwIcASHFHauAdjg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P1q8tESvo8YtTXrAEAJNUwqOkPSD3NhBeEdkShGvvdfH9DgbUHaMrdYENHrL8ZI3B
         xuBFXrSEFviwHN0ji7Nt2sM0QRiJWPqU/UKSfauq8dYxzx0if5N4pH/MLK4wr9Gyl3
         P+YE5V/aiSHerqgcIO9IQlBWEXn/gedboHoqh8Wqd9bRqU9AHRinnmFUvLG6oUunNo
         L14s0yhubBtb357g1uqlucmJVaT2pAkoc2A4Rf4epcDl4AVrzTObABzFviIXY6pP2z
         zjhjs8PCS7sIBO4NoGBeoa5Bv1Y3wMVpCu1biGo/dIK9yGx3HGs93hXyng8bl4zzLw
         5iEnZTbbVvFPw==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 05/10] rcu: Fix kfree_rcu() docbook errors
Date:   Wed,  3 Mar 2021 16:00:14 -0800
Message-Id: <20210304000019.22459-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210303235958.GA22373@paulmck-ThinkPad-P72>
References: <20210303235958.GA22373@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

After commit 5130b8fd0690 ("rcu: Introduce kfree_rcu() single-argument macro"),
kernel-doc now emits two warnings:

	./include/linux/rcupdate.h:884: warning: Excess function parameter 'ptr' description in 'kfree_rcu'
	./include/linux/rcupdate.h:884: warning: Excess function parameter 'rhf' description in 'kfree_rcu'

This commit added some macro magic in order to call two different versions
of kfree_rcu(), the first having just one argument and the second having
two arguments.  That makes it difficult to document the kfree_rcu() arguments
in the docboook header.

In order to make clearer that this macro accepts optional arguments,
this commit uses macro concatenation so that this macro changes from:
	#define kfree_rcu kvfree_rcu

to:
	#define kfree_rcu(ptr, rhf...) kvfree_rcu(ptr, ## rhf)

That not only helps kernel-doc understand the macro arguments, but also
provides a better C definition that makes clearer that the first argument
is mandatory and the second one is optional.

Fixes: 5130b8fd0690 ("rcu: Introduce kfree_rcu() single-argument macro")
Tested-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index bd04f72..5cc6dea 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -881,7 +881,7 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
  * The BUILD_BUG_ON check must not involve any function calls, hence the
  * checks are done in macros here.
  */
-#define kfree_rcu kvfree_rcu
+#define kfree_rcu(ptr, rhf...) kvfree_rcu(ptr, ## rhf)
 
 /**
  * kvfree_rcu() - kvfree an object after a grace period.
-- 
2.9.5

