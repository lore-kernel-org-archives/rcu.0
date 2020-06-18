Return-Path: <SRS0=xc3B=77=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13676C433E0
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 20:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E38B8208C3
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 20:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="RDc8PBr8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729850AbgFRUaG (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729632AbgFRUaF (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 18 Jun 2020 16:30:05 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948CBC06174E
        for <rcu@vger.kernel.org>; Thu, 18 Jun 2020 13:30:05 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id l6so3288142qkc.6
        for <rcu@vger.kernel.org>; Thu, 18 Jun 2020 13:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gMOtZLcID+RRbq+QbVzKX+Sw9GzEGaMQc8XZ1xKu5m8=;
        b=RDc8PBr85lcjVAicltmfcfy4dzfexCk/dEiGFvqbM8lScWjY1PkBHl6o4/PY8wgxcB
         ToIPTtkxdMT5FTrFrESjJb4ugVU0nqz/g2iczQzFDJvRCCnkvM1x9V1NEa97zCQJZANT
         d1tQkqFlCcKx5WaxCSHtW4Dag3Mv3IL4nzxWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gMOtZLcID+RRbq+QbVzKX+Sw9GzEGaMQc8XZ1xKu5m8=;
        b=p0rXhlDRWVSgSg42ncoxtpG996zs11/QJCLpwzwGN8NHyrv4YmaNf9Jj3Ci//HyoMi
         Z14RTY2z6qBSp1E6WFuMDjbvYzt++0DNz4dkDxC93By6ntrUvarp9izfw9U38puAzNPO
         WePfdLjHpMQZS7c/qqi1jxF6WUyjVuQUGi7CAuCYYwDwBztutAk3wg9/7nr95Fl9a5+P
         OKR3SsJREpl857p444JYA8W20f4wliFSVHAVR05rHLsj4eHQbwqzzhuJ+DNyAejQKcer
         2P49tND0F0DVRc8FZ422xKews2q4X/8/1WzPjBhQRMm9bQEKeNlKX8jiWnwXUX4Q6dfb
         lp8Q==
X-Gm-Message-State: AOAM531j/Rnt0tb4c0zfuOo/UbZm2mqyjH0m1sEAV5Vf03v4Tbmjz0bA
        1y8zbVyJNJB9cgDemgN5iX1MhWrrgow=
X-Google-Smtp-Source: ABdhPJyl20IvgCOTKAwxqcbjW4LHgQZsAQJwZpjVLTJInQQ4agKEp/55HP5ET6rkjXy5z2a9EkkwEA==
X-Received: by 2002:ae9:e10f:: with SMTP id g15mr205435qkm.285.1592512204709;
        Thu, 18 Jun 2020 13:30:04 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id v3sm4027503qkh.130.2020.06.18.13.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 13:30:04 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        urezki@gmail.com, Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 1/7] rcu/segcblist: Prevent useless GP start if no CBs to accelerate
Date:   Thu, 18 Jun 2020 16:29:49 -0400
Message-Id: <20200618202955.4024-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

rcu_segcblist_accelerate() returns true if a GP is to be
started/requested and false if not. During tracing, I found that it is
asking that GPs be requested

The exact flow seems to be something like:
1. Callbacks are queued on CPU A - into the NEXT list.
2. softirq runs on CPU A, accelerate all CBs from NEXT->WAIT and request a GP X.
3. GP thread wakes up on another CPU, starts the GP X and requests QS from CPU A.
4. CPU A's softirq runs again presumably because of #3.
5. CPU A's softirq now does acceleration again, this time no CBs are
   accelerated since last attempt, but it still requests GP X+1 which
   could be useless.

The fix is, prevent the useless GP start if we detect no CBs are there
to accelerate.

With this, we have the following improvement in short runs of
rcutorture (5 seconds each):
+----+-------------------+-------------------+
| #  | Number of GPs     | Number of Wakeups |
+====+=========+=========+=========+=========+
| 1  | With    | Without | With    | Without |
+----+---------+---------+---------+---------+
| 2  |      75 |      89 |     113 |     119 |
+----+---------+---------+---------+---------+
| 3  |      62 |      91 |     105 |     123 |
+----+---------+---------+---------+---------+
| 4  |      60 |      79 |      98 |     110 |
+----+---------+---------+---------+---------+
| 5  |      63 |      79 |      99 |     112 |
+----+---------+---------+---------+---------+
| 6  |      57 |      89 |      96 |     123 |
+----+---------+---------+---------+---------+
| 7  |      64 |      85 |      97 |     118 |
+----+---------+---------+---------+---------+
| 8  |      58 |      83 |      98 |     113 |
+----+---------+---------+---------+---------+
| 9  |      57 |      77 |      89 |     104 |
+----+---------+---------+---------+---------+
| 10 |      66 |      82 |      98 |     119 |
+----+---------+---------+---------+---------+
| 11 |      52 |      82 |      83 |     117 |
+----+---------+---------+---------+---------+

Cc: urezki@gmail.com
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/rcu_segcblist.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 9a0f66133b4b3..4782cf17bf4f9 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -475,8 +475,15 @@ bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
 	 * Also advance to the oldest segment of callbacks whose
 	 * ->gp_seq[] completion is at or after that passed in via "seq",
 	 * skipping any empty segments.
+	 *
+	 * Note that "i" is the youngest segment of the list after which
+	 * any older segments than "i" would not be mutated or assigned
+	 * GPs. For example, if i == WAIT_TAIL, then neither WAIT_TAIL,
+	 * nor DONE_TAIL will be touched. Only CBs in NEXT_TAIL will be
+	 * merged with NEXT_READY_TAIL and the GP numbers of both of
+	 * them would be updated.
 	 */
-	if (++i >= RCU_NEXT_TAIL)
+	if (rcu_segcblist_restempty(rsclp, i) || ++i >= RCU_NEXT_TAIL)
 		return false;
 
 	/*
-- 
2.27.0.111.gc72c7da667-goog

