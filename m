Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9523BC2BB85
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74D0720857
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586971897;
	bh=VDMgFXtEbxfcmNxE2Wc86fVZ8tPC0P5vQUBS7cJpFtw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=njnMc6q0onWvqlfOTSngK0k3wyISWZpwlSvDaoSfCbU7Ljj0oHt2bFm+MiY53Cv5A
	 wXDvSpjQlrwuEk833NfMoy84AymqLVqp8cEuSZu4C2ImplvJIyXCsueicD7k+SrN2u
	 AkLKbyZdTGigbMplJotwQdGxxsrbRcO5GuY64H8U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411168AbgDORba (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:31:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:46360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411131AbgDORbI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 13:31:08 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE75F21734;
        Wed, 15 Apr 2020 17:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586971867;
        bh=VDMgFXtEbxfcmNxE2Wc86fVZ8tPC0P5vQUBS7cJpFtw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RppcM/lFCOEpVWjwUGGIskHsep0SDO/QKTKdbvzGPQz2IBD2N5X83gdrpkxI3sr0I
         cy9bkYDfrDzGOeOML760E3Fhm4lOetfP99M9NjOwfzFt+KyV6yVfsC/MYyjLVUKEKc
         lVsCykftUrfOg+G5cuG3dzQhwLdu3e357QCuBfuw=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 16/18] torture: Save a few lines by using config_override_param initially
Date:   Wed, 15 Apr 2020 10:30:58 -0700
Message-Id: <20200415173100.9927-16-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415173037.GA9768@paulmck-ThinkPad-P72>
References: <20200415173037.GA9768@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit saves a few lines of code by also using the bash
config_override_param() to set the initial list of Kconfig options from
the CFcommon file.  While in the area, it makes this function capable of
update-in-place on the file containing the cumulative Kconfig options,
thus avoiding annoying changes when adding another source of options.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../selftests/rcutorture/bin/kvm-test-1-run.sh     | 38 +++++++++-------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index c7534fd..52f8966 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -46,35 +46,29 @@ echo ' ---' `date`: Starting build
 echo ' ---' Kconfig fragment at: $config_template >> $resdir/log
 touch $resdir/ConfigFragment.input
 
-# Combine additional Kconfig options into an existing set such that newer
-# options win.  The first argument is the Kconfig source ID, the second
-# the source file within $T, the third the destination file within $T,
-# and the fourth and final the list of additional Kconfig options.
+# Combine additional Kconfig options into an existing set such that
+# newer options win.  The first argument is the Kconfig source ID, the
+# second the to-be-updated file within $T, and the third and final the
+# list of additional Kconfig options.  Note that a $2.tmp file is
+# created when doing the update.
 config_override_param () {
-	if test -n "$4"
+	if test -n "$3"
 	then
-		echo $4 | sed -e 's/^ *//' -e 's/ *$//' | tr -s " " "\012" > $T/Kconfig_args
+		echo $3 | sed -e 's/^ *//' -e 's/ *$//' | tr -s " " "\012" > $T/Kconfig_args
 		echo " --- $1" >> $resdir/ConfigFragment.input
 		cat $T/Kconfig_args >> $resdir/ConfigFragment.input
-		config_override.sh $T/$2 $T/Kconfig_args > $T/$3
+		config_override.sh $T/$2 $T/Kconfig_args > $T/$2.tmp
+		mv $T/$2.tmp $T/$2
 		# Note that "#CHECK#" is not permitted on commandline.
-	else
-		cp $T/$2 $T/$3
 	fi
 }
 
-if test -r "$config_dir/CFcommon"
-then
-	echo " --- $config_dir/CFcommon" >> $resdir/ConfigFragment.input
-	cat < $config_dir/CFcommon >> $resdir/ConfigFragment.input
-	cp $config_dir/CFcommon $T/Kc0
-else
-	echo > $T/Kc0
-fi
-config_override_param "$config_template" Kc0 Kc1 "`cat $config_template 2> /dev/null`"
-config_override_param "--kcsan options" Kc1 Kc2 "$TORTURE_KCONFIG_KCSAN_ARG"
-config_override_param "--kconfig argument" Kc2 Kc3 "$TORTURE_KCONFIG_ARG"
-cp $T/Kc3 $resdir/ConfigFragment
+echo > $T/KcList
+config_override_param "$config_dir/CFcommon" KcList "`cat $config_dir/CFcommon 2> /dev/null`"
+config_override_param "$config_template" KcList "`cat $config_template 2> /dev/null`"
+config_override_param "--kcsan options" KcList "$TORTURE_KCONFIG_KCSAN_ARG"
+config_override_param "--kconfig argument" KcList "$TORTURE_KCONFIG_ARG"
+cp $T/KcList $resdir/ConfigFragment
 
 base_resdir=`echo $resdir | sed -e 's/\.[0-9]\+$//'`
 if test "$base_resdir" != "$resdir" -a -f $base_resdir/bzImage -a -f $base_resdir/vmlinux
@@ -87,7 +81,7 @@ then
 	ln -s $base_resdir/.config $resdir  # for kvm-recheck.sh
 	# Arch-independent indicator
 	touch $resdir/builtkernel
-elif kvm-build.sh $T/Kc3 $resdir
+elif kvm-build.sh $T/KcList $resdir
 then
 	# Had to build a kernel for this test.
 	QEMU="`identify_qemu vmlinux`"
-- 
2.9.5

