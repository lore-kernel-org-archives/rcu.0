Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD946C43217
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 23:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 968DD61101
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 23:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbhIOXnF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Sep 2021 19:43:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:44712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233035AbhIOXnD (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Sep 2021 19:43:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 273C7610E8;
        Wed, 15 Sep 2021 23:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631749304;
        bh=A83P4Qm9LmGoQZ5hfPZVMQ6Zn51D9EFd7aMfsb0AB7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SFUTubtZCVwsiebfFSYTpDNcNa+SbNdu57Ovm9DymLoZKr2oTIXfj9+uXArGk16Sr
         N8soYaSmKUh/dxreFIi6zW816wSwmL0SF3BokyOoQNnX/ZRWCaHX9ujgbblN/Wg0Fs
         AjpVw3hG98peHWa/jz2O4jIgFAZyYWRe1gknxJO0RokfdhoGMfhwDDN95lBDtPFHt+
         YVlcgd6pQPjBQULliQr84pHb7OI+g6HuoFmHVdSPyQQMbPdi9Xy4BTUjNJ9BZx4Srl
         cVyAMOLVC+HeimUFQLrKewfEULSq57ehJHHzi/g3sNf/WJI17evjIMcI6GeWe3isMb
         fqeNIkerMIgoA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E4A7D5C054E; Wed, 15 Sep 2021 16:41:43 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 1/5] scftorture: Allow zero weight to exclude an smp_call_function*() category
Date:   Wed, 15 Sep 2021 16:41:37 -0700
Message-Id: <20210915234141.3907301-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210915234117.GA3907188@paulmck-ThinkPad-P17-Gen-1>
References: <20210915234117.GA3907188@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This commit reworks the weighting calculations to allow zero to
be specified to diable a given weight.  For example, specifying the
scftorture.weight_resched=0 kernel boot parameter without specifying a
non-zero value for any of the other scftorture.weight_* parameters would
provide the default weights for the others, but would refrain from doing
any resched-based IPIs.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/scftorture.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 64a08288b1a6..bc3f8e26345c 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -553,18 +553,18 @@ static int __init scf_torture_init(void)
 
 	scftorture_print_module_parms("Start of test");
 
-	if (weight_resched == -1 &&
-	    weight_single == -1 && weight_single_rpc == -1 && weight_single_wait == -1 &&
-	    weight_many == -1 && weight_many_wait == -1 &&
-	    weight_all == -1 && weight_all_wait == -1) {
-		weight_resched1 = 2 * nr_cpu_ids;
-		weight_single1 = 2 * nr_cpu_ids;
-		weight_single_rpc1 = 2 * nr_cpu_ids;
-		weight_single_wait1 = 2 * nr_cpu_ids;
-		weight_many1 = 2;
-		weight_many_wait1 = 2;
-		weight_all1 = 1;
-		weight_all_wait1 = 1;
+	if (weight_resched <= 0 &&
+	    weight_single <= 0 && weight_single_rpc <= 0 && weight_single_wait <= 0 &&
+	    weight_many <= 0 && weight_many_wait <= 0 &&
+	    weight_all <= 0 && weight_all_wait <= 0) {
+		weight_resched1 = weight_resched == 0 ? 0 : 2 * nr_cpu_ids;
+		weight_single1 = weight_single == 0 ? 0 : 2 * nr_cpu_ids;
+		weight_single_rpc1 = weight_single_rpc == 0 ? 0 : 2 * nr_cpu_ids;
+		weight_single_wait1 = weight_single_wait == 0 ? 0 : 2 * nr_cpu_ids;
+		weight_many1 = weight_many == 0 ? 0 : 2;
+		weight_many_wait1 = weight_many_wait == 0 ? 0 : 2;
+		weight_all1 = weight_all == 0 ? 0 : 1;
+		weight_all_wait1 = weight_all_wait == 0 ? 0 : 1;
 	} else {
 		if (weight_resched == -1)
 			weight_resched1 = 0;
-- 
2.31.1.189.g2e36527f23

