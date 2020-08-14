Return-Path: <SRS0=bMVE=BY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80138C433E1
	for <rcu@archiver.kernel.org>; Fri, 14 Aug 2020 06:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61C0820708
	for <rcu@archiver.kernel.org>; Fri, 14 Aug 2020 06:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgHNGq7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Aug 2020 02:46:59 -0400
Received: from mail.windriver.com ([147.11.1.11]:36062 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgHNGq6 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Aug 2020 02:46:58 -0400
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 07E6kCBH029450
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Thu, 13 Aug 2020 23:46:13 -0700 (PDT)
Received: from pek-qzhang2-d1.wrs.com (128.224.162.183) by
 ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
 14.3.487.0; Thu, 13 Aug 2020 23:45:59 -0700
From:   <qiang.zhang@windriver.com>
To:     <paulmck@kernel.org>, <josh@joshtriplett.org>,
        <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
        <jiangshanlai@gmail.com>, <joel@joelfernandes.org>
CC:     <rcu@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] rcu: shrink each possible cpu krcp
Date:   Fri, 14 Aug 2020 14:45:57 +0800
Message-ID: <20200814064557.17365-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Zqiang <qiang.zhang@windriver.com>

Due to cpu hotplug. some cpu may be offline after call "kfree_call_rcu"
func, if the shrinker is triggered at this time, we should drain each
possible cpu "krcp".

Signed-off-by: Zqiang <qiang.zhang@windriver.com>
---
 kernel/rcu/tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8ce77d9ac716..619ccbb3fe4b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3443,7 +3443,7 @@ kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 	unsigned long count = 0;
 
 	/* Snapshot count of all CPUs */
-	for_each_online_cpu(cpu) {
+	for_each_possible_cpu(cpu) {
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
 		count += READ_ONCE(krcp->count);
@@ -3458,7 +3458,7 @@ kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 	int cpu, freed = 0;
 	unsigned long flags;
 
-	for_each_online_cpu(cpu) {
+	for_each_possible_cpu(cpu) {
 		int count;
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
@@ -3491,7 +3491,7 @@ void __init kfree_rcu_scheduler_running(void)
 	int cpu;
 	unsigned long flags;
 
-	for_each_online_cpu(cpu) {
+	for_each_possible_cpu(cpu) {
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
 		raw_spin_lock_irqsave(&krcp->lock, flags);
-- 
2.17.1

