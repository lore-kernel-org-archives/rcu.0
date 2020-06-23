Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4886C433E2
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D1722053B
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592872286;
	bh=Lvk15VfxUhLA0kTiJnXZl+9fP6N6hldQFQod866iDmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xBw94hw66GhLelt4NKXCAz+otCaakRCbig+AsBm8TsxTzC4y0M4GmODF/AAYC0vLv
	 lyiBu9caWRXTLEMLINChUfODr7IoPqkr/j1o8DkFKsXEkZ+b4EbY/JfYXaUAX2VxTP
	 40iRMOR6AAorn38wwsqhRkJcEPIlWFSbdGw6W5ak=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731887AbgFWAbZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:31:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731679AbgFWAaT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:30:19 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F8972084D;
        Tue, 23 Jun 2020 00:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872218;
        bh=Lvk15VfxUhLA0kTiJnXZl+9fP6N6hldQFQod866iDmc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s6c+aHIc1jGhVjBm+L+bJJnpUPdeOFmObB4DeyzJTekL2nDTpX6qj8CpGkGUTskcH
         9TNF5jfWjY4GL+0R0J5QCRIugjGiQJy8bwMPjW7ifcAEk56aNe42XRXOrvI5e7wgsF
         UjyOR5QpBwCCnw2fTzgGzXBTLRJmG4XAKfJEVEpo=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 17/30] refperf: Label experiment-number column "Runs"
Date:   Mon, 22 Jun 2020 17:30:00 -0700
Message-Id: <20200623003013.26252-17-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002941.GA26089@paulmck-ThinkPad-P72>
References: <20200623002941.GA26089@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The experiment-number column is currently labeled "Threads", which is
misleading at best.  This commit therefore relabels it as "Runs", and
adjusts the scripts accordingly.

Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refperf.c                                          | 2 +-
 tools/testing/selftests/rcutorture/bin/kvm-recheck-refperf.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/refperf.c b/kernel/rcu/refperf.c
index 445190b..2d2d227 100644
--- a/kernel/rcu/refperf.c
+++ b/kernel/rcu/refperf.c
@@ -415,7 +415,7 @@ static int main_func(void *arg)
 
 	buf[0] = 0;
 	strcat(buf, "\n");
-	strcat(buf, "Threads\tTime(ns)\n");
+	strcat(buf, "Runs\tTime(ns)\n");
 
 	for (exp = 0; exp < nruns; exp++) {
 		if (errexit)
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck-refperf.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck-refperf.sh
index 6fc06cd..0660f3f 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck-refperf.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck-refperf.sh
@@ -24,7 +24,7 @@ configfile=`echo $i | sed -e 's/^.*\///'`
 
 sed -e 's/^\[[^]]*]//' < $i/console.log | tr -d '\015' |
 awk -v configfile="$configfile" '
-/^[ 	]*Threads	Time\(ns\) *$/ {
+/^[ 	]*Runs	Time\(ns\) *$/ {
 	if (dataphase + 0 == 0) {
 		dataphase = 1;
 		# print configfile, $0;
-- 
2.9.5

