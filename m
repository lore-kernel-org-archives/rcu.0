Return-Path: <SRS0=QfF2=7R=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57181C433DF
	for <rcu@archiver.kernel.org>; Thu,  4 Jun 2020 10:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D98D207DA
	for <rcu@archiver.kernel.org>; Thu,  4 Jun 2020 10:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgFDKoE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 4 Jun 2020 06:44:04 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:9755 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725881AbgFDKoD (ORCPT
        <rfc822;rcu@vger.kernel.org>); Thu, 4 Jun 2020 06:44:03 -0400
X-Greylist: delayed 1217 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Jun 2020 06:44:03 EDT
From:   Peter Enderborg <peter.enderborg@sony.com>
To:     "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, <rcu@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Peter Enderborg <peter.enderborg@sony.com>
Subject: [PATCH] rcu: Stop shrinker loop
Date:   Thu, 4 Jun 2020 12:23:20 +0200
Message-ID: <20200604102320.15914-1-peter.enderborg@sony.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-SEG-SpamProfiler-Analysis: v=2.3 cv=VdGJw2h9 c=1 sm=1 tr=0 a=Jtaq2Av1iV2Yg7i8w6AGMw==:117 a=nTHF0DUjJn0A:10 a=z6gsHLkEAAAA:8 a=ZjHLJIMreXujHcPb9Y4A:9 a=d-OLMTCWyvARjPbQ-enb:22
X-SEG-SpamProfiler-Score: 0
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The count and scan can be separated in time. It is a fair chance
that all work is already done when the scan starts. It
then might retry. This is can be avoided with returning SHRINK_STOP.

Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index c716eadc7617..8b36c6b2887d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3310,7 +3310,7 @@ kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 			break;
 	}
 
-	return freed;
+	return freed == 0 ? SHRINK_STOP : freed;
 }
 
 static struct shrinker kfree_rcu_shrinker = {
-- 
2.17.1

