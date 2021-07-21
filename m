Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DACBC6377A
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 21:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6297E61246
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 21:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbhGUUVI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 16:21:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:32982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229463AbhGUUVH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 16:21:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 191466120A;
        Wed, 21 Jul 2021 21:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626901303;
        bh=LsWN34OuWU/Ycjk+u2ir0E9MU/L0UqABM+BrMKVTu7s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=erwg0cBChSImo6UkRCUtHph42PUsjIabaj6EeQPej+w87J1QXBEOADNib1JmprlAs
         znuCFZUDkR2ftKWSfX5bpUwV1sqhL6KpV6j6Cs/lHmNORI4cGJOL9MmwsI8sCqrc25
         +B6Du9lncc6qLtbUhTDTHIjkTS7SOAYV+VgqppayCDRRpDKN7rB7GYZnxkc/Yd+sXz
         vNBoNoxfL7rOZfki6jLZTqsPaRYBkC9sz+w+7bVBVHffxD+IibCCgbXEQNQrzutMMr
         4kLLN5dSfcwpAGZrjspwdXHN858Taw1ZWfgabCxQN3WV8ux8ZZsIlt1YQEo7jD6DCR
         iFd3/ja+y0KXA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C8DA85C09A4; Wed, 21 Jul 2021 14:01:42 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 01/21] torture: Add clocksource-watchdog testing to torture.sh
Date:   Wed, 21 Jul 2021 14:01:20 -0700
Message-Id: <20210721210140.787717-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721205511.GA786917@paulmck-ThinkPad-P17-Gen-1>
References: <20210721205511.GA786917@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This commit adds three short tests of the clocksource-watchdog capability
to the torture.sh script, all to avoid otherwise-inevitable bitrot.
While in the area, fix an obsolete comment.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../selftests/rcutorture/bin/torture.sh       | 29 +++++++++++++++++--
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index 53ec7c046262d..94802ddfb7a6a 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -53,6 +53,7 @@ do_refscale=yes
 do_kvfree=yes
 do_kasan=yes
 do_kcsan=no
+do_clocksourcewd=yes
 
 # doyesno - Helper function for yes/no arguments
 function doyesno () {
@@ -72,6 +73,7 @@ usage () {
 	echo "       --configs-scftorture \"config-file list w/ repeat factor (2*CFLIST)\""
 	echo "       --doall"
 	echo "       --doallmodconfig / --do-no-allmodconfig"
+	echo "       --do-clocksourcewd / --do-no-clocksourcewd"
 	echo "       --do-kasan / --do-no-kasan"
 	echo "       --do-kcsan / --do-no-kcsan"
 	echo "       --do-kvfree / --do-no-kvfree"
@@ -119,10 +121,14 @@ do
 		do_kvfree=yes
 		do_kasan=yes
 		do_kcsan=yes
+		do_clocksourcewd=yes
 		;;
 	--do-allmodconfig|--do-no-allmodconfig)
 		do_allmodconfig=`doyesno "$1" --do-allmodconfig`
 		;;
+	--do-clocksourcewd|--do-no-clocksourcewd)
+		do_clocksourcewd=`doyesno "$1" --do-clocksourcewd`
+		;;
 	--do-kasan|--do-no-kasan)
 		do_kasan=`doyesno "$1" --do-kasan`
 		;;
@@ -145,6 +151,7 @@ do
 		do_kvfree=no
 		do_kasan=no
 		do_kcsan=no
+		do_clocksourcewd=no
 		;;
 	--do-rcuscale|--do-no-rcuscale)
 		do_rcuscale=`doyesno "$1" --do-rcuscale`
@@ -279,9 +286,9 @@ function torture_one {
 #	torture_bootargs="[ kernel boot arguments ]"
 #	torture_set flavor [ kvm.sh arguments ]
 #
-# Note that "flavor" is an arbitrary string.  Supply --torture if needed.
-# Note that quoting is problematic.  So on the command line, pass multiple
-# values with multiple kvm.sh argument instances.
+# Note that "flavor" is an arbitrary string that does not affect kvm.sh
+# in any way.  So also supply --torture if you need something other than
+# the default.
 function torture_set {
 	local cur_kcsan_kmake_args=
 	local kcsan_kmake_tag=
@@ -377,6 +384,22 @@ then
 	torture_set "rcuscale-kvfree" tools/testing/selftests/rcutorture/bin/kvm.sh --torture rcuscale --allcpus --duration 10 --kconfig "CONFIG_NR_CPUS=$HALF_ALLOTED_CPUS" --memory 1G --trust-make
 fi
 
+if test "$do_clocksourcewd" = "yes"
+then
+	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000"
+	torture_set "clocksourcewd-1" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 45s --configs TREE03 --kconfig "CONFIG_TEST_CLOCKSOURCE_WATCHDOG=y" --trust-make
+
+	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 clocksource.max_cswd_read_retries=1"
+	torture_set "clocksourcewd-2" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 45s --configs TREE03 --kconfig "CONFIG_TEST_CLOCKSOURCE_WATCHDOG=y" --trust-make
+
+	# In case our work is already done...
+	if test "$do_rcutorture" != "yes"
+	then
+		torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000"
+		torture_set "clocksourcewd-3" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 45s --configs TREE03 --trust-make
+	fi
+fi
+
 echo " --- " $scriptname $args
 echo " --- " Done `date` | tee -a $T/log
 ret=0
-- 
2.31.1.189.g2e36527f23

