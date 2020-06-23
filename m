Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41750C433E0
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 140DC20809
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592872732;
	bh=3HldJl6rCxEuhG0HoNYBopjLz6whfEIiDZYQgQq3UdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IvX/u++pBFyApPP/IPFKO5pdngQa14IXaEj8NAM+7eG0mxQFbmvALxSj+kvYdroP6
	 wdtPQPBMAvWf5AG0noB1EjoOZMaSvtRVkWxZQ3idpu3yo7o4vOJUBTRet5dbsEbmFi
	 drob+W44sdwLDAsHw0CyMF7IA5aTwbYER0H2WeUI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732060AbgFWAiv (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:38:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:33658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732140AbgFWAh4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:37:56 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D560208E4;
        Tue, 23 Jun 2020 00:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872676;
        bh=3HldJl6rCxEuhG0HoNYBopjLz6whfEIiDZYQgQq3UdE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NkoM3ka9VDh99AwCe7Y/ZKHcIASmhtIJLYehTQ9FC5nVvPlUw9u0/tDb1Z343DzvC
         D0CAhKrwcx16nczUb1rupAKgnsigIxV9IZlD16rv3OzNBG5UMgK8ewPtE8Xf3Ne7gN
         1CqOsfNBjNs0ARz0L8ODBiTDl+BFLNQrvqMa7EgA=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 11/23] torture: Create qemu-cmd in --buildonly runs
Date:   Mon, 22 Jun 2020 17:37:40 -0700
Message-Id: <20200623003752.26872-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623003731.GA26717@paulmck-ThinkPad-P72>
References: <20200623003731.GA26717@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

One reason to do a --buildonly run is to use the build products elsewhere,
for example, to do the actual test on some other system.  Part of doing
the test is the actual qemu command, which is not currently produced
by --buildonly runs.  This commit therefore causes --buildonly runs to
create this file.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index 1b9aebd..064dd73 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -153,6 +153,7 @@ qemu_append="`identify_qemu_append "$QEMU"`"
 boot_args="`configfrag_boot_params "$boot_args" "$config_template"`"
 # Generate kernel-version-specific boot parameters
 boot_args="`per_version_boot_params "$boot_args" $resdir/.config $seconds`"
+echo $QEMU $qemu_args -m $TORTURE_QEMU_MEM -kernel $KERNEL -append \"$qemu_append $boot_args\" > $resdir/qemu-cmd
 
 if test -n "$TORTURE_BUILDONLY"
 then
@@ -161,7 +162,6 @@ then
 	exit 0
 fi
 echo "NOTE: $QEMU either did not run or was interactive" > $resdir/console.log
-echo $QEMU $qemu_args -m $TORTURE_QEMU_MEM -kernel $KERNEL -append \"$qemu_append $boot_args\" > $resdir/qemu-cmd
 ( $QEMU $qemu_args -m $TORTURE_QEMU_MEM -kernel $KERNEL -append "$qemu_append $boot_args" > $resdir/qemu-output 2>&1 & echo $! > $resdir/qemu_pid; wait `cat  $resdir/qemu_pid`; echo $? > $resdir/qemu-retval ) &
 commandcompleted=0
 sleep 10 # Give qemu's pid a chance to reach the file
-- 
2.9.5

