Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139C6C3815B
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7921A2173E
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586971873;
	bh=ffx1dAR8HucNxwd3zkd4vwf0ktA1zHRiDCG/WvVGM/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=koWa9ND5cCt2olgkNZyIJ+VuSAtExfsRugi6tNHnfeYOH8AWvfMJq3+YxGQ0t5Vg8
	 Tx51ipbJVQdq+WfGzte2EOCadKQhd1tTyuVWhqVPDQPXI+eHtxX8WaYRRWBH37J9C/
	 Dsq17rEVB1+UdHEBAzk/e6l/Q+UWFGJUgkQUBJJA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411139AbgDORbL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:31:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:46310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411126AbgDORbH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 13:31:07 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0ED021744;
        Wed, 15 Apr 2020 17:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586971866;
        bh=ffx1dAR8HucNxwd3zkd4vwf0ktA1zHRiDCG/WvVGM/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sE7Qu/mjr7lMQed1ctWObQXwvkiph77Jhv3CP+lRYSEx0/bmrlb4Vpjt21g0TeaZz
         AfLdyGTGO1hr3hbLtwVaKtI2BevUoSrdr2wUTlHS5G3mJPkJKCqhNjwsLqX8bqVbF3
         pFzu4AoqvW1uWANZZKkkduj9FDhjuIQ94oYCqLUM=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 13/18] torture: Abstract application of additional Kconfig options
Date:   Wed, 15 Apr 2020 10:30:55 -0700
Message-Id: <20200415173100.9927-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415173037.GA9768@paulmck-ThinkPad-P72>
References: <20200415173037.GA9768@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit introduces a config_override_param() bash function that
folds in an additional set of Kconfig options.  This is initially applied
to fold in the --kconfig kvm.sh parameter, but later commits will also
apply it to the Kconfig options added by the --kcsan kvm.sh parameter.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../selftests/rcutorture/bin/kvm-test-1-run.sh     | 31 ++++++++++++++--------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index 74da059..1801b06 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -45,6 +45,24 @@ fi
 echo ' ---' `date`: Starting build
 echo ' ---' Kconfig fragment at: $config_template >> $resdir/log
 touch $resdir/ConfigFragment.input
+
+# Combine additional Kconfig options into an existing set such that newer
+# options win.  The first argument is the Kconfig source ID, the second
+# the source file within $T, the third the destination file within $T,
+# and the fourth and final the list of additional Kconfig options.
+config_override_param () {
+	if test -n "$4"
+	then
+		echo $4 | sed -e 's/^ *//' -e 's/ *$//' | tr -s " " "\012" > $T/Kconfig_args
+		echo " --- $1" >> $resdir/ConfigFragment.input
+		cat $T/Kconfig_args >> $resdir/ConfigFragment.input
+		config_override.sh $T/$2 $T/Kconfig_args > $T/$3
+		# Note that "#CHECK#" is not permitted on commandline.
+	else
+		cp $T/$2 $T/$3
+	fi
+}
+
 if test -r "$config_dir/CFcommon"
 then
 	echo " --- $config_dir/CFcommon" >> $resdir/ConfigFragment.input
@@ -55,17 +73,8 @@ else
 fi
 echo " --- $config_template" >> $resdir/ConfigFragment.input
 cat $config_template >> $resdir/ConfigFragment.input
-if test -n "$TORTURE_KCONFIG_ARG"
-then
-	echo $TORTURE_KCONFIG_ARG | tr -s " " "\012" > $T/cmdline
-	echo " --- --kconfig argument" >> $resdir/ConfigFragment.input
-	cat $T/cmdline >> $resdir/ConfigFragment.input
-	config_override.sh $T/Kc1 $T/cmdline > $T/Kc2
-	# Note that "#CHECK#" is not permitted on commandline.
-else
-	cp $T/Kc1 $T/Kc2
-fi
-cat $T/Kc2 > $resdir/ConfigFragment
+config_override_param "--kconfig argument" Kc1 Kc2 "$TORTURE_KCONFIG_ARG"
+cp $T/Kc2 $resdir/ConfigFragment
 
 base_resdir=`echo $resdir | sed -e 's/\.[0-9]\+$//'`
 if test "$base_resdir" != "$resdir" -a -f $base_resdir/bzImage -a -f $base_resdir/vmlinux
-- 
2.9.5

