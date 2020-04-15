Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F78AC2BB85
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E79882076D
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586972002;
	bh=Kb43s7UcY0gAmb1E2JqIB0n+FpVohSNuM0G4HK1hwZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vsUIHKrAm+jt8gyshuCVs6rjS1h++c6Bf/62j0JrI7kzswZkcc0MopikipGvNcOiR
	 wrRHs628ya/UaWhdpu+8hw34xNSyj/IpgsJqW6LArVDixE9IAckILgk0NSdr/U+uqJ
	 ICICwOebKoiEuiJq3feWt+1Yl+oFijrD1uzYomlM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411308AbgDORdQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:33:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:46312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411127AbgDORbH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 13:31:07 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D10521775;
        Wed, 15 Apr 2020 17:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586971866;
        bh=Kb43s7UcY0gAmb1E2JqIB0n+FpVohSNuM0G4HK1hwZ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rukd+V7jBcswJRqHLk/W2/9i6Fdw6wNaCIVJQNZWF9oUxpBA+j/3Web5kPfzb3kPc
         LigHe5kEyPJqm2bQyfyxtY1xHiPFI9si3sQs4OgQ5IVgrE050QqFLGl1wO2eKCdOHj
         v3mMp08AQhI2KO2y4cCawUDrHEs8egQ16CHQ77Wk=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 14/18] torture: Allow --kconfig options to override --kcsan defaults
Date:   Wed, 15 Apr 2020 10:30:56 -0700
Message-Id: <20200415173100.9927-14-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415173037.GA9768@paulmck-ThinkPad-P72>
References: <20200415173037.GA9768@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, attempting to override a --kcsan default with a --kconfig
option might or might not work.  However, it would be good to allow the
user to adjust the --kcsan defaults, for example, to specify a different
time for CONFIG_KCSAN_REPORT_ONCE_IN_MS.  This commit therefore uses the
new config_override_param() bash function to apply the --kcsan defaults
and then apply the --kconfig options, which allows this overriding
to occur.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh | 7 ++++---
 tools/testing/selftests/rcutorture/bin/kvm.sh            | 3 ---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index 1801b06..b7296f1 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -73,8 +73,9 @@ else
 fi
 echo " --- $config_template" >> $resdir/ConfigFragment.input
 cat $config_template >> $resdir/ConfigFragment.input
-config_override_param "--kconfig argument" Kc1 Kc2 "$TORTURE_KCONFIG_ARG"
-cp $T/Kc2 $resdir/ConfigFragment
+config_override_param "--kcsan options" Kc1 Kc2 "$TORTURE_KCONFIG_KCSAN_ARG"
+config_override_param "--kconfig argument" Kc2 Kc3 "$TORTURE_KCONFIG_ARG"
+cp $T/Kc3 $resdir/ConfigFragment
 
 base_resdir=`echo $resdir | sed -e 's/\.[0-9]\+$//'`
 if test "$base_resdir" != "$resdir" -a -f $base_resdir/bzImage -a -f $base_resdir/vmlinux
@@ -87,7 +88,7 @@ then
 	ln -s $base_resdir/.config $resdir  # for kvm-recheck.sh
 	# Arch-independent indicator
 	touch $resdir/builtkernel
-elif kvm-build.sh $T/Kc2 $resdir
+elif kvm-build.sh $T/Kc3 $resdir
 then
 	# Had to build a kernel for this test.
 	QEMU="`identify_qemu vmlinux`"
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 75ae8e3..e001fc4 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -205,9 +205,6 @@ else
 	exit 1
 fi
 
-TORTURE_KCONFIG_ARG="${TORTURE_KCONFIG_ARG} ${TORTURE_KCONFIG_KCSAN_ARG}"
-TORTURE_KCONFIG_ARG="`echo ${TORTURE_KCONFIG_ARG} | sed -e 's/^ *//' -e 's/ *$//'`"
-
 CONFIGFRAG=${KVM}/configs/${TORTURE_SUITE}; export CONFIGFRAG
 
 defaultconfigs="`tr '\012' ' ' < $CONFIGFRAG/CFLIST`"
-- 
2.9.5

