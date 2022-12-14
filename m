Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87E6C4332F
	for <rcu@archiver.kernel.org>; Wed, 14 Dec 2022 14:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237347AbiLNOZH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 14 Dec 2022 09:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiLNOZG (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 14 Dec 2022 09:25:06 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1222275DE
        for <rcu@vger.kernel.org>; Wed, 14 Dec 2022 06:25:04 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id z8-20020a17090abd8800b00219ed30ce47so7316240pjr.3
        for <rcu@vger.kernel.org>; Wed, 14 Dec 2022 06:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZVhu3+wc50w9K7EywxpfrE3vWE7JxNrKGRS5GAy1PI0=;
        b=HBCextnb/TUk3qbj6PFgup6k2wlMqKnz83huW7C+VymkLwd8bIx6IEZxoWGXIZ+Cn1
         0ExkjbGsDf76Hpti5FHKD2mjNB0uoUVYAssP8OewF9Zk/Wqs8DOiugE4pcckeBwicoOr
         Wewa5YMXPmsyWSd3L6n7EqVkQ2sBWshXrly9zVm52uHzmsIgXkgjt+JRr2c0r5vBJXN1
         RLzZAigAJ8RNjAjqy9vy1QDf2LFnabR1OKXPKBjhJlGTAOAdQhDOCVe2Ev2Kbwp6nlgK
         1JKojiHzmQTiUIPxDHb9PpS1X4h1buqu3WnScVNCr/zxj+AjQdF24Zv3UacqiC5loJGF
         aWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZVhu3+wc50w9K7EywxpfrE3vWE7JxNrKGRS5GAy1PI0=;
        b=izpsBN4YIjD5AIf0E94wrKEDjTs4ElCVleWPQpa0p8UpenXwEi9Pk2k+R5hFEPolEx
         jSduuWe8iQM2ikUdVMQ8LR+gmRKCZfNfWDA9+qdUrTUqX6t8UWhRmSelOGzVncize1WB
         MQEvGeCbod96/hKdvM6UC1hj6YUqNMAUe+tc4PrSqZAovXNoL3Cl8tvx/gPaiGmkleku
         DBEcEvC6wIlOAmhTp4opFJ+I7JZn0seUeCdIKmEZ81JOmHn6aF5zDDvuzI9DhcHxmghk
         /xaXU81IRC7IM5ve5AzFvigDdwnA81qfVyKi5Kps8d8O/WxkVPMLzEfplsvbEUgVd2MU
         VZRQ==
X-Gm-Message-State: ANoB5pm6GGJtIFm+lZNShVr+aQH+abadUKuVMNF7sMrEtto9Zp5xhLCS
        +Uyfvp3saCrVsE+sGT+V+vYHQaRHaA==
X-Google-Smtp-Source: AA0mqf6ynq37rVIzl4t0etSrVjrDT1lHQ/OpWOEzSB769qRhnNcxq/VJgvRtRhvVMPamWsOOvEWLAw==
X-Received: by 2002:a17:902:d510:b0:185:441e:90ae with SMTP id b16-20020a170902d51000b00185441e90aemr35313664plg.20.1671027903946;
        Wed, 14 Dec 2022 06:25:03 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id iz17-20020a170902ef9100b0018099c9618esm1915244plb.231.2022.12.14.06.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 06:25:03 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     rcu@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH] srcu: Add notes for not-effective mutex
Date:   Wed, 14 Dec 2022 22:24:46 +0800
Message-Id: <20221214142446.56543-1-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Capped by the design and implementation of workqueue, the same work can not
be re-entrant.

SRCU has only a single work ssp->work, there is no way to occur the
concurrent scene in its state machine. Hence the mutexes for the
concurrency in the state machine is unnecessary. On the other hand,
using two works to utilize the window from the release of srcu_gp_mutex
to the end of srcu_gp_end() to enhance the parallelism has limited
effect. [1]

To save any trying of improving parallelism by using two work_struct,
put some notes around the srcu_gp_mutex and srcu_cb_mutex. And keep them
instead of removing them, in case in future, the state machine is moved
out of the protection of workqueue non-reentrant protection.

Some test data to show how dual work_struct affects the SRCU
performance:

-1. on 144 cpus hpe-dl560gen10
  modprobe rcutorture   torture_type=srcud  fwd_progress=144 fwd_progress_holdoff=1 shutdown_secs=36000 stat_interval=60 verbose=1
  # base line
  [37587.632155] srcud:  End-test grace-period state: g28287244 f0x0 total-gps=28287244
  # two dual work_struct
  [36443.468017] srcud:  End-test grace-period state: g29026056 f0x0 total-gps=29026056

-2. on 256 cpus amd-milan
  modprobe rcutorture   torture_type=srcud  fwd_progress=256 fwd_progress_holdoff=1 shutdown_secs=36000 stat_interval=60 verbose=1
  # base line
  [36093.605732] srcud:  End-test grace-period state: g10850284 f0x0 total-gps=10850284
  # two dual work_struct
  [36093.856713] srcud:  End-test grace-period state: g10672632 f0x0 total-gps=10672632

The first test shows that it has about 2.6% improvement, while the
second test shows it has no significant effect.

[1]: https://lore.kernel.org/rcu/Y5nC2yBhaUYirByo@piliu.users.ipa.redhat.com/T/#maf99cf1d92077a1b0b8e5c411c79fa4444576624

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
To: rcu@vger.kernel.org
---
 include/linux/srcutree.h | 4 ++++
 kernel/rcu/srcutree.c    | 5 ++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 558057b517b7..f199c31493ab 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -66,8 +66,12 @@ struct srcu_struct {
 						/* First node at each level. */
 	int srcu_size_state;			/* Small-to-big transition state. */
 	struct mutex srcu_cb_mutex;		/* Serialize CB preparation. */
+						/* Not take effect since the only single sdp->work */
+						/* meets the workqueue non-reentrant condition */
 	spinlock_t __private lock;		/* Protect counters and size state. */
 	struct mutex srcu_gp_mutex;		/* Serialize GP work. */
+						/* Not take effect since the only single sdp->work */
+						/* meets the workqueue non-reentrant condition */
 	unsigned int srcu_idx;			/* Current rdr array element. */
 	unsigned long srcu_gp_seq;		/* Grace-period seq #. */
 	unsigned long srcu_gp_seq_needed;	/* Latest gp_seq needed. */
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index ce39907fa381..8ebb1a240219 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -815,7 +815,10 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 	struct srcu_node *snp;
 	int ss_state;
 
-	/* Prevent more than one additional grace period. */
+	/*
+	 * Prevent more than one additional grace period. But at present, it does
+	 * not take effect. Refer to the note at the definition.
+	 * /
 	mutex_lock(&ssp->srcu_cb_mutex);
 
 	/* End the current grace period. */
-- 
2.31.1

