Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C88C4332F
	for <rcu@archiver.kernel.org>; Wed, 16 Nov 2022 01:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiKPB4p (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 15 Nov 2022 20:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbiKPB4i (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 15 Nov 2022 20:56:38 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551B126AE1
        for <rcu@vger.kernel.org>; Tue, 15 Nov 2022 17:56:37 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id w3-20020a17090a460300b00218524e8877so1576408pjg.1
        for <rcu@vger.kernel.org>; Tue, 15 Nov 2022 17:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z989fHCgBNlEW+UtdMA7vdxuePIKuhDcp2EIbq1hmdo=;
        b=IcpijP27Z7R7KATlu22ZESgWghaJPpCny7meSGn3ChrmnzxYn1F0KTEylZkOLccnvV
         T8VnINt7REwCsXv9mfHrJy9HDwg42TVfyglrk8Ekg16iAD1CN+Mlm+ZunQdGR3Nl7vaL
         /HiHTg4kgejESiEIgbrpaFwDUw3rVNeqWTbjXmZaMMzJqpdSsZn+lg3LMsNsERZOlnbl
         eXHa7eb9WTqTKHy/sVnjuVymeAW60uBzSqfZXY/g5QAnDjixXUeHCb/nctRMyfe8JP6B
         RrLQNWHgPEITgLUYPbx+l2ykjZmos5Nd/5vCKrpi2ITTK8QqUfOso1mM1BJRaL3UR5su
         T9MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z989fHCgBNlEW+UtdMA7vdxuePIKuhDcp2EIbq1hmdo=;
        b=arlkFumFrVHd3fzMwiUR1s96nbz15GWB3sAB5jK56V1IdpFnkNC1o6xcIQXPvBJwaC
         +yU9uQ36VGmcvmfDy+8RxtnEQJ8CNTONsgc0Hh10m5AXCaUWrq6l0KrYmo/Ke8Rut8qZ
         emlbAXk/+abXfGwpEYxjGuOxKyepXLoMIPO7/wTtQNhiyA18mBLyOxC4vgHSdjT3dgOm
         6jAihXxbA0Vs5Z8apX/OFyRtuywgzLQFATNOtD1WW66aWORIm3ZM5g49+lH4Bxie1ji+
         0bqkFMgF4JAosMcqjEOrewXSxIr+5Pwg8NgRixy1JJ1I9oWDE4fViRtJD/cuADfRiKdk
         4rdg==
X-Gm-Message-State: ANoB5pnZq0jNwVHwTwr/NHXrOxkfbqvOj6yHEFunxBnUEUH3hZ2Ivf2D
        RVl0vEyaXVt6ENzqVOVsHQCw13KxCA==
X-Google-Smtp-Source: AA0mqf543YI+aVcePzCM9cMpsT2y/4hgZWCsC92Mfx+k7HXAJL2ylzWJvsvmjiRZ3YoELTZh/v97JQ==
X-Received: by 2002:a17:90a:9c18:b0:212:fa9a:12df with SMTP id h24-20020a17090a9c1800b00212fa9a12dfmr1210569pjp.231.1668563796425;
        Tue, 15 Nov 2022 17:56:36 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y9-20020aa793c9000000b0056c349f5c70sm9496401pff.79.2022.11.15.17.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 17:56:35 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     rcu@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH] srcu: Move updating of segcblist from srcu_gp_start() to srcu_might_be_idle()
Date:   Wed, 16 Nov 2022 09:56:26 +0800
Message-Id: <20221116015626.10872-1-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The pair of segcblist operations: rcu_segcblist_advance() and
rcu_segcblist_accelerate() in srcu_gp_start() is needless from two
perspectives:

  -1. As a part of the SRCU state machine, it should take care of either
all sda or none. But here it only takes care of a single sda.

  -2. From the viewpoint of the callback, at the entrance,
srcu_gp_start_if_needed() has called that pair operations and attached
it with gp_seq. At the exit, srcu_invoke_callbacks() calls that pair
again to extract the done callbacks. So the harvesting of the callback
is not affected by the call to that pair in srcu_gp_start().

But because the updating of RCU_DONE_TAIL by srcu_invoke_callbacks() may
have some delay than by srcu_gp_end()->srcu_gp_start(), the removal may
cause srcu_might_be_idle() not to be real time.  To compensate that,
supplement that pair just before the calling to rcu_segcblist_pend_cbs()
in srcu_might_be_idle().

Test info:
torture test passed using the following command against commit 094226ad94f4 ("Linux 6.1-rc5")
   tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 10h --configs 18*SRCU-P

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: rcu@vger.kernel.org
---
 kernel/rcu/srcutree.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 725c82bb0a6a..36ba18967133 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -659,21 +659,10 @@ EXPORT_SYMBOL_GPL(__srcu_read_unlock);
  */
 static void srcu_gp_start(struct srcu_struct *ssp)
 {
-	struct srcu_data *sdp;
 	int state;
 
-	if (smp_load_acquire(&ssp->srcu_size_state) < SRCU_SIZE_WAIT_BARRIER)
-		sdp = per_cpu_ptr(ssp->sda, 0);
-	else
-		sdp = this_cpu_ptr(ssp->sda);
 	lockdep_assert_held(&ACCESS_PRIVATE(ssp, lock));
 	WARN_ON_ONCE(ULONG_CMP_GE(ssp->srcu_gp_seq, ssp->srcu_gp_seq_needed));
-	spin_lock_rcu_node(sdp);  /* Interrupts already disabled. */
-	rcu_segcblist_advance(&sdp->srcu_cblist,
-			      rcu_seq_current(&ssp->srcu_gp_seq));
-	(void)rcu_segcblist_accelerate(&sdp->srcu_cblist,
-				       rcu_seq_snap(&ssp->srcu_gp_seq));
-	spin_unlock_rcu_node(sdp);  /* Interrupts remain disabled. */
 	WRITE_ONCE(ssp->srcu_gp_start, jiffies);
 	WRITE_ONCE(ssp->srcu_n_exp_nodelay, 0);
 	smp_mb(); /* Order prior store to ->srcu_gp_seq_needed vs. GP start. */
@@ -1037,6 +1026,10 @@ static bool srcu_might_be_idle(struct srcu_struct *ssp)
 	/* If the local srcu_data structure has callbacks, not idle.  */
 	sdp = raw_cpu_ptr(ssp->sda);
 	spin_lock_irqsave_rcu_node(sdp, flags);
+	rcu_segcblist_advance(&sdp->srcu_cblist,
+			      rcu_seq_current(&ssp->srcu_gp_seq));
+	(void)rcu_segcblist_accelerate(&sdp->srcu_cblist,
+				       rcu_seq_snap(&ssp->srcu_gp_seq));
 	if (rcu_segcblist_pend_cbs(&sdp->srcu_cblist)) {
 		spin_unlock_irqrestore_rcu_node(sdp, flags);
 		return false; /* Callbacks already present, so not idle. */
-- 
2.31.1

