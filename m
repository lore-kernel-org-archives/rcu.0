Return-Path: <SRS0=f31y=DF=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50313C2D0A8
	for <rcu@archiver.kernel.org>; Mon, 28 Sep 2020 12:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3C4121974
	for <rcu@archiver.kernel.org>; Mon, 28 Sep 2020 12:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="TEKdCS8D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgI1Mqk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 28 Sep 2020 08:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgI1Mqk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 28 Sep 2020 08:46:40 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEAFC061755
        for <rcu@vger.kernel.org>; Mon, 28 Sep 2020 05:46:40 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id c18so575216qtw.5
        for <rcu@vger.kernel.org>; Mon, 28 Sep 2020 05:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dbSiDedMj6Fi2FYAEkzpCM05qVLOKb0E2B69e7H8fn8=;
        b=TEKdCS8Dxi3PrABwVjZpWaEAS70Pbf9sgKwKP0IbyLaSRsiBQ6U3DRPSQ9YYx8UrYI
         3b4PiAXkBJDmaSXNL6H5E6k68j2iTaYCDj6E6a8oWULeBDCXdMcBjUkwDmZwLIolrbib
         J/2bbA9sjUn8ymiri3oABrQ4Kin+zyioWXMm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dbSiDedMj6Fi2FYAEkzpCM05qVLOKb0E2B69e7H8fn8=;
        b=tbcvuTHly209ayydraNnmy2ARvkCEPmXRMur9h9AsrVrRt4Qn5RHp3T/nks6HYB+FH
         Hogqadz3bH30w7pX7qmtoKTQqJAJe5Pe48Y+2h88sXTFB/GGPqKmEJZX7yOZpoQbWPkA
         lZu+eJwoidCKvNP/NvLJXS6ThK9PtKwTCogegtx7FhX3sga082nhzdZ+gvNCsoZnsS0N
         VlE3UsVD4RfrWKA8axXhdygF1DiKEx0ZKA8TfHqoXRnzI2ZjmVQhI9OY+Evv/hOHDL6z
         Ndxf3FDHjlIKOhWtBx/OUP1p/Z/dfscDc3QZdezQF0VGfZ4C5UKDAOw8NZT4j+zw59Cw
         7AcA==
X-Gm-Message-State: AOAM532XN7DY5sf+NnmCs1jNd81RhnGznxEQ0FFn+HpzL3pT0FiTyyKq
        fUhf2Qq2VQ8uq6RBm4Clo5A+iw==
X-Google-Smtp-Source: ABdhPJyV1m9Uu4p9yfBBOaGtJeqDobIT55/QnD00o4ONcmno3VrccZPI2W8JOdyLO0F0LiIyGpLLIw==
X-Received: by 2002:ac8:18da:: with SMTP id o26mr568249qtk.92.1601297199518;
        Mon, 28 Sep 2020 05:46:39 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id g5sm974902qtx.43.2020.09.28.05.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 05:46:38 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        neeraju@codeaurora.org, fweisbec@gmail.com,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, peterz@infradead.org
Subject: [PATCH] rcu/tree: nocb: Avoid raising softirq when CBs ready to execute
Date:   Mon, 28 Sep 2020 08:46:25 -0400
Message-Id: <20200928124625.1677571-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

During testing, I see it is possible that rcu_pending() returns 1 when
offloaded callbacks are ready to execute thus raising the RCU softirq.

However, softirq does not execute offloaded callbacks. They are executed in a
kthread which is awakened independent of the softirq. The softirq ignores the
request.

This commit therefore avoids raising the softirq in the first place.
Considering that the purpose of callback offloading is to reduce softirq
activity, avoiding the softirq in the first place is the right thing to do
especially for systems that employ callback offloading to reduce real-time
jitter.

Passed 30 minute tests of TREE01 through TREE09 each.

Cc: neeraju@codeaurora.org
Cc: fweisbec@gmail.com
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

---
 kernel/rcu/tree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 55d3700dd1e7..caea5bfec2c0 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3759,7 +3759,8 @@ static int rcu_pending(int user)
 		return 1;
 
 	/* Does this CPU have callbacks ready to invoke? */
-	if (rcu_segcblist_ready_cbs(&rdp->cblist))
+	if (!rcu_segcblist_is_offloaded(&rdp->cblist) &&
+	    rcu_segcblist_ready_cbs(&rdp->cblist))
 		return 1;
 
 	/* Has RCU gone idle with this CPU needing another grace period? */
-- 
2.28.0.709.gb0816b6eb0-goog

