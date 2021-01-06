Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E855FC433DB
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAEE723125
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbhAFRce (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 12:32:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:47940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbhAFRcd (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 12:32:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8CC5023135;
        Wed,  6 Jan 2021 17:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609954283;
        bh=tds2Ei07GXjQXACUY34RoTge9HcGyFIf6O24KAJ3Zyo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GrY62hLu53LG1BXAvkU15h7Ly93h/eIk8JOBo+QlT9IcaSgg+tt9E32iYvsyC86yM
         sSfD0+ZWrjM2xll3sA3g8TDZHQRYeLtmvHUWGx48+AMOPp6ovYEjTQm4tBthtBXk/U
         Lb+gX3U8VMh1wn4yRDIssFPc48Z6W63YEO+cwrER/gEPwEGobbDQt4aIGyuKT/bkDL
         Iou2QKyxPsSl8LT3Yc06oSwC/6xUKbJHdxiI1WNePyH5dNT4XPfo0m+HNvbtQp09om
         Tyw6bvjx5TjMLZNVBjT6H6eqpab5O34Mf6bGjxkJtMEVBdrfCqb8h+CN6Y0hPQLr3n
         Tmf6aKiHI16cg==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 15/18] torture: Allow scenarios to be specified to torture.sh
Date:   Wed,  6 Jan 2021 09:31:16 -0800
Message-Id: <20210106173119.23159-15-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106173056.GA23035@paulmck-ThinkPad-P72>
References: <20210106173056.GA23035@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds --configs-rcutorture, --configs-locktorture, and
--configs-scftorture arguments to torture.sh, allowing the desired
set of scenarios to be passed to each.  The default for each has been
changed from a large-system-appropriate set to just CFLIST for each.
Users are encouraged to create scripts that provide appropriate settings
for their specific systems.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 46 +++++++++++++++++++++--
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index cf74123..f614011 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -30,6 +30,11 @@ then
 	VERBOSE_BATCH_CPUS=0
 fi
 
+# Configurations/scenarios.
+configs_rcutorture=
+configs_locktorture=
+configs_scftorture=
+
 # Default duration and apportionment.
 duration_base=10
 duration_rcutorture_frac=7
@@ -59,6 +64,9 @@ function doyesno () {
 
 usage () {
 	echo "Usage: $scriptname optional arguments:"
+	echo "       --configs-rcutorture \"config-file list w/ repeat factor (3*TINY01)\""
+	echo "       --configs-locktorture \"config-file list w/ repeat factor (10*LOCK01)\""
+	echo "       --configs-scftorture \"config-file list w/ repeat factor (2*CFLIST)\""
 	echo "       --doall"
 	echo "       --doallmodconfig / --do-no-allmodconfig"
 	echo "       --do-kasan / --do-no-kasan"
@@ -77,6 +85,21 @@ usage () {
 while test $# -gt 0
 do
 	case "$1" in
+	--config-rcutorture|--configs-rcutorture)
+		checkarg --configs-rcutorture "(list of config files)" "$#" "$2" '^[^/]\+$' '^--'
+		configs_rcutorture="$configs_rcutorture $2"
+		shift
+		;;
+	--config-locktorture|--configs-locktorture)
+		checkarg --configs-locktorture "(list of config files)" "$#" "$2" '^[^/]\+$' '^--'
+		configs_locktorture="$configs_locktorture $2"
+		shift
+		;;
+	--config-scftorture|--configs-scftorture)
+		checkarg --configs-scftorture "(list of config files)" "$#" "$2" '^[^/]\+$' '^--'
+		configs_scftorture="$configs_scftorture $2"
+		shift
+		;;
 	--doall)
 		do_allmodconfig=yes
 		do_rcutorture=yes
@@ -155,18 +178,35 @@ T=/tmp/torture.sh.$$
 trap 'rm -rf $T' 0 2
 mkdir $T
 
+# Calculate rcutorture defaults and apportion time
+if test -z "$configs_rcutorture"
+then
+	configs_rcutorture=CFLIST
+fi
 duration_rcutorture=$((duration_base*duration_rcutorture_frac/10))
 if test "$duration_rcutorture" -eq 0
 then
 	echo " --- Zero time for rcutorture, disabling" | tee -a $T/log
 	do_rcutorture=no
 fi
+
+# Calculate locktorture defaults and apportion time
+if test -z "$configs_locktorture"
+then
+	configs_locktorture=CFLIST
+fi
 duration_locktorture=$((duration_base*duration_locktorture_frac/10))
 if test "$duration_locktorture" -eq 0
 then
 	echo " --- Zero time for locktorture, disabling" | tee -a $T/log
 	do_locktorture=no
 fi
+
+# Calculate scftorture defaults and apportion time
+if test -z "$configs_scftorture"
+then
+	configs_scftorture=CFLIST
+fi
 duration_scftorture=$((duration_base*duration_scftorture_frac/10))
 if test "$duration_scftorture" -eq 0
 then
@@ -268,19 +308,19 @@ fi
 if test "$do_rcutorture" = "yes"
 then
 	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000"
-	torture_set "rcutorture" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration "$duration_rcutorture" --configs "TREE10 4*CFLIST" --trust-make
+	torture_set "rcutorture" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration "$duration_rcutorture" --configs "$configs_rcutorture" --trust-make
 fi
 
 if test "$do_locktorture" = "yes"
 then
 	torture_bootargs="torture.disable_onoff_at_boot"
-	torture_set "locktorture" tools/testing/selftests/rcutorture/bin/kvm.sh --torture lock --allcpus --duration "$duration_locktorture" --configs "14*CFLIST" --trust-make
+	torture_set "locktorture" tools/testing/selftests/rcutorture/bin/kvm.sh --torture lock --allcpus --duration "$duration_locktorture" --configs "$configs_locktorture" --trust-make
 fi
 
 if test "$do_scftorture" = "yes"
 then
 	torture_bootargs="scftorture.nthreads=$HALF_ALLOTED_CPUS torture.disable_onoff_at_boot"
-	torture_set "scftorture" tools/testing/selftests/rcutorture/bin/kvm.sh --torture scf --allcpus --duration "$duration_scftorture" --kconfig "CONFIG_NR_CPUS=$HALF_ALLOTED_CPUS" --trust-make
+	torture_set "scftorture" tools/testing/selftests/rcutorture/bin/kvm.sh --torture scf --allcpus --duration "$duration_scftorture" --configs "$configs_scftorture" --kconfig "CONFIG_NR_CPUS=$HALF_ALLOTED_CPUS" --trust-make
 fi
 
 if test "$do_refscale" = yes
-- 
2.9.5

