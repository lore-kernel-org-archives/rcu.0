Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DFFC43331
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 647A923133
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbhAFRcS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 12:32:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:47942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbhAFRcS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 12:32:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F2E832313E;
        Wed,  6 Jan 2021 17:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609954282;
        bh=RNHIeD36YcwQOiNIPCVuhLjjsSW1KAgzrc1zej6chu0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LVKiB+vPk2sJbi2QtZEruR3REkQdeLXPyIP46+E9UHAnlVq4+iVzJ55OITUoW2tbt
         vco8xiJyB7IyvHkXwmV1m9442Acnsoh8aaCPnzEXR+4UXUTkdBZzx6SjfBsezEUQHN
         aW6WqB7oHn9VW4ZAAQpECDTjDy/ZYPWkn0k11nRnqHRrYdXsIWmnoa/j3sr2ICMtcC
         o7lSmivAfFCWOVFK9hmHrm5oA4Xq7g9oGe9lBOam+9BIBg29attEDnZozZMdQn+JBA
         7BdEBbflr6drsop/rFq2plHiYzus1HnioqAf/ahP6j8ispVlu6mZXEaIaW1m6x1TTI
         eEjixq4kLASqA==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 06/18] torture: Auto-size SCF and scaling runs based on number of CPUs
Date:   Wed,  6 Jan 2021 09:31:07 -0800
Message-Id: <20210106173119.23159-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106173056.GA23035@paulmck-ThinkPad-P72>
References: <20210106173056.GA23035@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit improves torture.sh flexibility by autoscaling the number
of CPUs to be used in variable-CPUs torture tests, including scftorture,
refscale, rcuscale, and kvfree.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index 57f2f31..e13dacf 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -19,6 +19,11 @@ PATH=${KVM}/bin:$PATH; export PATH
 
 TORTURE_ALLOTED_CPUS="`identify_qemu_vcpus`"
 MAKE_ALLOTED_CPUS=$((TORTURE_ALLOTED_CPUS*2))
+HALF_ALLOTED_CPUS=$((TORTURE_ALLOTED_CPUS/2))
+if test "$HALF_ALLOTED_CPUS" -lt 1
+then
+	HALF_ALLOTED_CPUS=1
+fi
 
 # Default duration and apportionment.
 duration_base=10
@@ -291,8 +296,8 @@ fi
 
 if test "$do_scftorture" = "yes"
 then
-	torture_bootargs="scftorture.nthreads=224 torture.disable_onoff_at_boot"
-	torture_set "scftorture" tools/testing/selftests/rcutorture/bin/kvm.sh --torture scf --allcpus --duration "$duration_scftorture" --kconfig "CONFIG_NR_CPUS=224" --trust-make
+	torture_bootargs="scftorture.nthreads=$HALF_ALLOTED_CPUS torture.disable_onoff_at_boot"
+	torture_set "scftorture" tools/testing/selftests/rcutorture/bin/kvm.sh --torture scf --allcpus --duration "$duration_scftorture" --kconfig "CONFIG_NR_CPUS=$HALF_ALLOTED_CPUS" --trust-make
 fi
 
 if test "$do_refscale" = yes
@@ -303,8 +308,8 @@ else
 fi
 for prim in $primlist
 do
-	torture_bootargs="refscale.scale_type="$prim" refscale.nreaders=224 refscale.loops=10000 refscale.holdoff=20 torture.disable_onoff_at_boot"
-	torture_set "refscale-$prim" tools/testing/selftests/rcutorture/bin/kvm.sh --torture refscale --allcpus --duration 5 --kconfig "CONFIG_NR_CPUS=224" --trust-make
+	torture_bootargs="refscale.scale_type="$prim" refscale.nreaders=$HALF_ALLOTED_CPUS refscale.loops=10000 refscale.holdoff=20 torture.disable_onoff_at_boot"
+	torture_set "refscale-$prim" tools/testing/selftests/rcutorture/bin/kvm.sh --torture refscale --allcpus --duration 5 --kconfig "CONFIG_NR_CPUS=$HALF_ALLOTED_CPUS" --trust-make
 done
 
 if test "$do_rcuscale" = yes
@@ -315,14 +320,14 @@ else
 fi
 for prim in $primlist
 do
-	torture_bootargs="rcuscale.scale_type="$prim" rcuscale.nwriters=224 rcuscale.holdoff=20 torture.disable_onoff_at_boot"
-	torture_set "rcuscale-$prim" tools/testing/selftests/rcutorture/bin/kvm.sh --torture rcuscale --allcpus --duration 5 --kconfig "CONFIG_NR_CPUS=224" --trust-make
+	torture_bootargs="rcuscale.scale_type="$prim" rcuscale.nwriters=$HALF_ALLOTED_CPUS rcuscale.holdoff=20 torture.disable_onoff_at_boot"
+	torture_set "rcuscale-$prim" tools/testing/selftests/rcutorture/bin/kvm.sh --torture rcuscale --allcpus --duration 5 --kconfig "CONFIG_NR_CPUS=$HALF_ALLOTED_CPUS" --trust-make
 done
 
 if test "$do_kvfree" = "yes"
 then
 	torture_bootargs="rcuscale.kfree_rcu_test=1 rcuscale.kfree_nthreads=16 rcuscale.holdoff=20 rcuscale.kfree_loops=10000 torture.disable_onoff_at_boot"
-	torture_set "rcuscale-kvfree" tools/testing/selftests/rcutorture/bin/kvm.sh --torture rcuscale --allcpus --duration 10 --kconfig "CONFIG_NR_CPUS=224" --trust-make
+	torture_set "rcuscale-kvfree" tools/testing/selftests/rcutorture/bin/kvm.sh --torture rcuscale --allcpus --duration 10 --kconfig "CONFIG_NR_CPUS=$HALF_ALLOTED_CPUS" --trust-make
 fi
 
 echo " --- " $scriptname $args
-- 
2.9.5

