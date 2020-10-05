Return-Path: <SRS0=BSCp=DM=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F4E1C4363C
	for <rcu@archiver.kernel.org>; Mon,  5 Oct 2020 02:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9196B20657
	for <rcu@archiver.kernel.org>; Mon,  5 Oct 2020 02:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="flyFCTjc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbgJECLn (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 4 Oct 2020 22:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgJECLn (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 4 Oct 2020 22:11:43 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B2AC0613CE
        for <rcu@vger.kernel.org>; Sun,  4 Oct 2020 19:11:43 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id d20so10495813qka.5
        for <rcu@vger.kernel.org>; Sun, 04 Oct 2020 19:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6Wo+VVS05SJfb/lGrce8kONJ0+ZjW+Qw+ub5hCYDws8=;
        b=flyFCTjcoKiGY8teOGCLQEtCmmdwZqrCG8CtbKxKXz3X0oDtteVryqGhKg5Sc+zL0o
         /b2u1bIe73bfY2JydNKMWRIJZS/h3ftO7VoiSE2MCQP8WZaVBL7EBH+De9Igj1miojgU
         +Lx/+tCy3ayuo3eSmDh3b1psuoTQylb2H2PtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6Wo+VVS05SJfb/lGrce8kONJ0+ZjW+Qw+ub5hCYDws8=;
        b=fnNDDPx67S8KI8O5UeRS6NlMLA/7f8qDoGIONCmEwB8OiBDLKA4Vj2Gg8eDJ3AzDe3
         DHX+BCP59wppvkiNjbFqMaZjbrGZH0Q/EKReiWmYGG3r9aaBcdwADTepEn0IUudO10tT
         jwf8kjHVjQ3BrW/DlkoGLOQM+ZiOpHVyDLDwCN05rMT6S65EuqODLD6fBQOGxuRs9BZx
         yXqD0EDF/k/yDC++qyX5gvOT4eNioz5aLj6PHChKgeSnul4WHILT6+8dwc/g7lZqNHqa
         V9P531mkVQjyArrUxfgmo6knLmC/IB9OdOH3jgUZk8yhma/7onNwmz4xWm6ubPTVPFx8
         Wmuw==
X-Gm-Message-State: AOAM532nVFpMSKPibEXP/E9bBgg4YVUnNFa5sz4ZTSrlrtihcrnic9dC
        TXImBadCEJgjnMKDkpEpYxXaFA==
X-Google-Smtp-Source: ABdhPJxSYUxdXA8c+v9vtX3ccMync1CwApLKme6U2VSGJmwmzBD0aNk7VP4qCkNytZoM2buox9TvUQ==
X-Received: by 2002:a37:af02:: with SMTP id y2mr12513717qke.346.1601863902188;
        Sun, 04 Oct 2020 19:11:42 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id d129sm2705207qkg.127.2020.10.04.19.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 19:11:41 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        neeraju@codeaurora.org, Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2] rcu/tree: nocb: Avoid raising softirq when there are ready to execute CBs
Date:   Sun,  4 Oct 2020 22:11:32 -0400
Message-Id: <20201005021132.146534-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

During testing, I see it is possible that rcu_pending() returns 1 when
offloaded callbacks are ready to execute thus raising the RCU softirq.

However, softirq does not execute offloaded callbacks. They are executed in a
kthread which is awakened independent of the softirq.

This commit therefore avoids raising the softirq in the first place. That's
probably a good thing considering that the purpose of callback offloading is to
reduce softirq activity.

Passed 30 minute tests of TREE01 through TREE09 each.

On TREE08, I notice that there is atmost 150us from when the softirq was
NOT raised when ready cbs were present, to when the ready callbacks were
invoked by the rcuop thread. This also further confirms that there is no
need to raise the softirq for ready cbs in the first place.

Cc: neeraju@codeaurora.org
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

---

v1->v2: Also cleaned up another test of the nocb configuration macro.

 kernel/rcu/tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f78ee759af9c..2b1e1b21db92 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3652,13 +3652,13 @@ static int rcu_pending(int user)
 		return 1;
 
 	/* Does this CPU have callbacks ready to invoke? */
-	if (rcu_segcblist_ready_cbs(&rdp->cblist))
+	if (!rcu_segcblist_is_offloaded(&rdp->cblist) &&
+	    rcu_segcblist_ready_cbs(&rdp->cblist))
 		return 1;
 
 	/* Has RCU gone idle with this CPU needing another grace period? */
 	if (!gp_in_progress && rcu_segcblist_is_enabled(&rdp->cblist) &&
-	    (!IS_ENABLED(CONFIG_RCU_NOCB_CPU) ||
-	     !rcu_segcblist_is_offloaded(&rdp->cblist)) &&
+	    (!rcu_segcblist_is_offloaded(&rdp->cblist)) &&
 	    !rcu_segcblist_restempty(&rdp->cblist, RCU_NEXT_READY_TAIL))
 		return 1;
 
-- 
2.28.0.806.g8561365e88-goog
