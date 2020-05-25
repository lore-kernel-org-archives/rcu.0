Return-Path: <SRS0=Lsu2=7H=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D3AC433E0
	for <rcu@archiver.kernel.org>; Mon, 25 May 2020 04:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 332B82071A
	for <rcu@archiver.kernel.org>; Mon, 25 May 2020 04:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="JMKM6a35"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgEYEgx (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 25 May 2020 00:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgEYEgx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 25 May 2020 00:36:53 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA01C061A0E
        for <rcu@vger.kernel.org>; Sun, 24 May 2020 21:36:53 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id o19so13006994qtr.10
        for <rcu@vger.kernel.org>; Sun, 24 May 2020 21:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zBPHTpLy/9QWLr/aIBq8Hs4cOMBIV6k4rc/Eb2CKDIA=;
        b=JMKM6a35mSptNJYaIw3nBoQMdqoyk7i7z7oZ3Malix0oflaA2hVVapoAirhBvRG3nJ
         TqYRK55svrq9Neom7Y0qefb5Qj+Z9yDcBEulJYlDWEAe1RBvQvmg1FSttwGxGf0Ojaye
         +APXz9HZ9uM3MfVfw+Knbzxb0BeQe3WbdNtS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zBPHTpLy/9QWLr/aIBq8Hs4cOMBIV6k4rc/Eb2CKDIA=;
        b=CfoV6fMbBcDRiCvMzms7YPLtd4QqsO2wtzJzU6339IOTDJEjtHyHsdJAOVyZDgd4Ra
         dvFc53xXR2CW8SI9QEfh7GCxbE13H3PpWEY2BAyvIpiz+PmiVfulrZwMLmt50reuEq4Y
         5fg+ln2/4wFmZIIPQvqfVoRQMNjOz6rCKPl5Xxm9PR6n5K74Y5N1fadWZ/8WyRK8Ttit
         RaZYZm4ALlazAYT/asEPf7+mSKr64FkpHeVsjAfs5PZjAAi305631Qo0wPv/7pyzz1oN
         Kw0jRmSJgDK4aY5FQio74rHDv7F8Tp9CbRDds32FB7yVlXampgcTBHQDHRKQMieM/3vG
         qWPA==
X-Gm-Message-State: AOAM533zAZZUGwyu3nX3eKNhK5PSI1Lqr6qhhoeMeY6vM46Cgc3fwEn4
        KS9R3txq9p5zUUVzlQiKugxr9A==
X-Google-Smtp-Source: ABdhPJz7kK8+gBrYJE2/gAEQd8LEG0beqhF9eolqo/LtET8sEp8ucbBAXJSHJ0S21ElLPFxQ0FKIfA==
X-Received: by 2002:ac8:34d0:: with SMTP id x16mr2216011qtb.300.1590381412275;
        Sun, 24 May 2020 21:36:52 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id g66sm13917019qkb.122.2020.05.24.21.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 21:36:51 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 1/2] rcuperf: Remove useless while loops around wait_event
Date:   Mon, 25 May 2020 00:36:47 -0400
Message-Id: <20200525043648.152547-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

wait_event() already retries if the condition for the wake up is not
satisifed after wake up. Remove them from the rcuperf test.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

---
 kernel/rcu/rcuperf.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
index 16dd1e6b7c09f..246da8fe199e8 100644
--- a/kernel/rcu/rcuperf.c
+++ b/kernel/rcu/rcuperf.c
@@ -576,11 +576,8 @@ static int compute_real(int n)
 static int
 rcu_perf_shutdown(void *arg)
 {
-	do {
-		wait_event(shutdown_wq,
-			   atomic_read(&n_rcu_perf_writer_finished) >=
-			   nrealwriters);
-	} while (atomic_read(&n_rcu_perf_writer_finished) < nrealwriters);
+	wait_event(shutdown_wq,
+		   atomic_read(&n_rcu_perf_writer_finished) >= nrealwriters);
 	smp_mb(); /* Wake before output. */
 	rcu_perf_cleanup();
 	kernel_power_off();
@@ -693,11 +690,8 @@ kfree_perf_cleanup(void)
 static int
 kfree_perf_shutdown(void *arg)
 {
-	do {
-		wait_event(shutdown_wq,
-			   atomic_read(&n_kfree_perf_thread_ended) >=
-			   kfree_nrealthreads);
-	} while (atomic_read(&n_kfree_perf_thread_ended) < kfree_nrealthreads);
+	wait_event(shutdown_wq,
+		   atomic_read(&n_kfree_perf_thread_ended) >= kfree_nrealthreads);
 
 	smp_mb(); /* Wake before output. */
 
-- 
2.27.0.rc0.183.gde8f92d652-goog

