Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57329C43217
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A06923131
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbhAFR2M (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 12:28:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:37870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727811AbhAFR1a (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 12:27:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 24EB92313A;
        Wed,  6 Jan 2021 17:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609953971;
        bh=AmmICU03UKPb+MIsTu2cbyQtL2ayOHiTex25QIkIzp8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pp/P/6Siq2cSor2uClu5Cz7RvqwVEPucGoDjHw000zZUx8lCfgc5smNaAUNcj9OP/
         zhEXKs3lNxEssgdjIRJoGapFz8V9uXgovFHdFFfgDbHSvEPsci7L5VhPwMNrT29tJn
         CNjb9JS+2PlofzejJ1mo4ByF3ZX5/3hCylIps+xX2jtwEAwojI9WaftuVWvUBks6HM
         U8ukX5AWPPovgo7+HfZp+OZQ/MO//L/J/QiHCfKGKuIRoAEo83gImMY+B3wALakT9v
         3Ii6RyP1Tudy5fdHgqtHWTxn/zgUeg9xfkroVkuAU3yQHUx31Kd5/ZUe5+OFcQP2SH
         rN3PTO/+XUlrg==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 10/20] torture: Print run duration at end of kvm.sh execution
Date:   Wed,  6 Jan 2021 09:25:57 -0800
Message-Id: <20210106172607.22816-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106172547.GA22404@paulmck-ThinkPad-P72>
References: <20210106172547.GA22404@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Yes, you can mentally subtract the timestamps, but this commit makes
the computer do this work.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../testing/selftests/rcutorture/bin/functions.sh  | 33 ++++++++++++++++++++++
 tools/testing/selftests/rcutorture/bin/kvm.sh      |  6 ++++
 2 files changed, 39 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/testing/selftests/rcutorture/bin/functions.sh
index fef8b4b..97c3a17 100644
--- a/tools/testing/selftests/rcutorture/bin/functions.sh
+++ b/tools/testing/selftests/rcutorture/bin/functions.sh
@@ -108,6 +108,39 @@ configfrag_hotplug_cpu () {
 	grep -q '^CONFIG_HOTPLUG_CPU=y$' "$1"
 }
 
+# get_starttime
+#
+# Returns a cookie identifying the current time.
+get_starttime () {
+	awk 'BEGIN { print systime() }' < /dev/null
+}
+
+# get_starttime_duration starttime
+#
+# Given the return value from get_starttime, compute a human-readable
+# string denoting the time since get_starttime.
+get_starttime_duration () {
+	awk -v starttime=$1 '
+	BEGIN {
+		ts = systime() - starttime; 
+		tm = int(ts / 60);
+		th = int(ts / 3600);
+		td = int(ts / 86400);
+		d = td;
+		h = th - td * 24;
+		m = tm - th * 60;
+		s = ts - tm * 60;
+		if (d >= 1)
+			printf "%dd %d:%02d:%02d\n", d, h, m, s
+		else if (h >= 1)
+			printf "%d:%02d:%02d\n", h, m, s
+		else if (m >= 1)
+			printf "%d:%02d.0\n", m, s
+		else
+			print s " seconds"
+	}' < /dev/null
+}
+
 # identify_boot_image qemu-cmd
 #
 # Returns the relative path to the kernel build image.  This will be
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 6fd7ef7..6f21268 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -47,6 +47,9 @@ cpus=0
 ds=`date +%Y.%m.%d-%H.%M.%S`
 jitter="-1"
 
+startdate="`date`"
+starttime="`get_starttime`"
+
 usage () {
 	echo "Usage: $scriptname optional arguments:"
 	echo "       --allcpus"
@@ -548,6 +551,9 @@ then
 else
 	# Not a dryrun, so run the script.
 	sh $T/script
+	ret=$?
+	echo " --- Done at `date` (`get_starttime_duration $starttime`)"
+	exit $ret
 fi
 
 # Tracing: trace_event=rcu:rcu_grace_period,rcu:rcu_future_grace_period,rcu:rcu_grace_period_init,rcu:rcu_nocb_wake,rcu:rcu_preempt_task,rcu:rcu_unlock_preempted_task,rcu:rcu_quiescent_state_report,rcu:rcu_fqs,rcu:rcu_callback,rcu:rcu_kfree_callback,rcu:rcu_batch_start,rcu:rcu_invoke_callback,rcu:rcu_invoke_kfree_callback,rcu:rcu_batch_end,rcu:rcu_torture_read,rcu:rcu_barrier
-- 
2.9.5

