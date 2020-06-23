Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F28AC433E2
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 360B22053B
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592872308;
	bh=IZSNB4AWn6OuXatm8zVziiAtvfUYw2x70nXoriANTTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zIHaf3aD8eE9iLKle7gR3hhIMkeC9FitzzWyyKHfrWRVYSfnSX14I8+rLz9sx3tmU
	 ZWfdRXISmcustT7fdDioaQOtCl3L7rOy2Z4kj6Idom88m7r/wrbK6pKiML4+Y1xugH
	 yCF41WXsIqcE891mP0ig4oqKuctNbv0N2U1SmsL4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731885AbgFWAbZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:31:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731681AbgFWAaT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:30:19 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3C2420776;
        Tue, 23 Jun 2020 00:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872218;
        bh=IZSNB4AWn6OuXatm8zVziiAtvfUYw2x70nXoriANTTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GnHn3n48N9gZljrx59kSS/CL7ijWi8m1BRUJcEmPX3bCBOr8vZqHuDkyKJG1h9yvp
         szNFKGTMswpZkLMvLz8dIAwCKK7myT//CqYkXX49j50kY070vOJEN7MwN1yc8F+d1t
         rolFfWUwR0rTBXyZ5wbPCLaYcZYRbFuLaxgXftk8=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 18/30] refperf: Output per-experiment data points
Date:   Mon, 22 Jun 2020 17:30:01 -0700
Message-Id: <20200623003013.26252-18-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002941.GA26089@paulmck-ThinkPad-P72>
References: <20200623002941.GA26089@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, it is necessary to manually edit the console output to see
anything more than statistics, and sometimes the statistics can indicate
outliers that need more investigation.  This commit therefore dumps out
the per-experiment measurements, sorted in ascending order, just before
dumping out the statistics.

Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-recheck-refperf.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck-refperf.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck-refperf.sh
index 0660f3f..0e29cfd 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck-refperf.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck-refperf.sh
@@ -59,6 +59,10 @@ END {
 		medianvalue = (readertimes[medianidx - 1] + readertimes[medianidx]) / 2;
 	else
 		medianvalue = readertimes[medianidx];
+	points = "Points:";
+	for (i = 1; i <= newNR; i++)
+		points = points " " readertimes[i];
+	print points;
 	print "Average reader duration: " sum / newNR " nanoseconds";
 	print "Minimum reader duration: " readertimes[1];
 	print "Median reader duration: " medianvalue;
-- 
2.9.5

