Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB54CC83F2C
	for <rcu@archiver.kernel.org>; Mon,  4 Sep 2023 09:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbjIDJnB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 4 Sep 2023 05:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjIDJnA (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 4 Sep 2023 05:43:00 -0400
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EA6C6;
        Mon,  4 Sep 2023 02:42:55 -0700 (PDT)
From:   Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
        t=1693820571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=75EOlAsPAELSjXIdJH8DlszPhmzP7Amr5cE0/OGlYIE=;
        b=DtZ+ZUAg2X0wiezk0ZZps+fG3XzB5jsh6FXaSZwpWFmO6uGdJ58sOSqDS2dnQHWnnMRDnP
        8MX8H4HiXbb1HMt/Wvyjplh/78SdIotNGp0mvClWYlSyJS6cQ49Tma6HSJNfj1fXgNQYie
        jABP79VF8TXvYR04kayVRZrenvqgRqQ=
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, lvc-project@linuxtesting.org,
        linux-kernel@vger.kernel.org, trufanov@swemel.ru, vfh@swemel.ru
Subject: [PATCH v2] The value may overflow
Date:   Mon,  4 Sep 2023 12:42:51 +0300
Message-Id: <20230904094251.64022-1-arefev@swemel.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The value of an arithmetic expression 1 << (cpu - sdp->mynode->grplo)
is subject to overflow due to a failure to cast operands to a larger
data type before performing arithmetic

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
v2: Added fixes to the srcu_schedule_cbs_snp function as suggested by 
Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
 kernel/rcu/srcutree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 20d7a238d675..6c18e6005ae1 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -223,7 +223,7 @@ static bool init_srcu_struct_nodes(struct srcu_struct *ssp, gfp_t gfp_flags)
 				snp->grplo = cpu;
 			snp->grphi = cpu;
 		}
-		sdp->grpmask = 1 << (cpu - sdp->mynode->grplo);
+		sdp->grpmask = 1UL << (cpu - sdp->mynode->grplo);
 	}
 	smp_store_release(&ssp->srcu_sup->srcu_size_state, SRCU_SIZE_WAIT_BARRIER);
 	return true;
@@ -833,7 +833,7 @@ static void srcu_schedule_cbs_snp(struct srcu_struct *ssp, struct srcu_node *snp
 	int cpu;
 
 	for (cpu = snp->grplo; cpu <= snp->grphi; cpu++) {
-		if (!(mask & (1 << (cpu - snp->grplo))))
+		if (!(mask & (1UL << (cpu - snp->grplo))))
 			continue;
 		srcu_schedule_cbs_sdp(per_cpu_ptr(ssp->sda, cpu), delay);
 	}
-- 
2.25.1

