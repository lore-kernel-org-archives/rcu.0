Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A21AC4332B
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CE7A64FBC
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351433AbhCDBBk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:01:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:39066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1452934AbhCDAji (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:39:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A213164F1D;
        Thu,  4 Mar 2021 00:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614818295;
        bh=+/BHZnyQu3x+TLvuoXAAH0ZOlEtJuPfnvhvrNqDpmcQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G8lhYnK+iSE3Crra0uXfcnt8tUEdatdcw30GSbazRtF8dF/ZdkU04MMjOF+6lRseM
         7x7OPcMJRmjVvvnzu80WW/e/MyNtQ/r0YU6D6JbWR0Bl6kq55EyLEQuu8ni4+vm2m1
         Dgw3W1McBmDVIVtXFjV/Us4rz24A8iFR+DpqLcse/uwoE1cNlblYctyW5AeGTywdzM
         Dubd6VvRVoAbxBF1yOXKp3m3cpEcyGvj4HPF8tNBTc5co+y3A0i2pwORmM3AzqjdDK
         RTt4043GzRawmOoGmQoUP7Vn+HSAWLbhxeFBMDsGQDKflYgE4PngThH8lnVFXb0c5g
         FP9/gwWxf54Zw==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 13/28] torture: Record TORTURE_KCONFIG_GDB_ARG in qemu-cmd
Date:   Wed,  3 Mar 2021 16:37:57 -0800
Message-Id: <20210304003812.24833-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304003750.GA24696@paulmck-ThinkPad-P72>
References: <20210304003750.GA24696@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

When re-running old rcutorture builds, if the original run involved
gdb, the re-run also needs to do so.  This commit therefore records the
TORTURE_KCONFIG_GDB_ARG environment variable into the qemu-cmd file so
that the re-run can access it.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index eb5346b..5d9ac90 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -201,6 +201,7 @@ echo kernel here: `head -n 1 $testid_txt | sed -e 's/^Build directory: //'`  >>
 echo $QEMU $qemu_args -m $TORTURE_QEMU_MEM -kernel $KERNEL -append \"$qemu_append $boot_args\" $TORTURE_QEMU_GDB_ARG > $resdir/qemu-cmd
 echo "# TORTURE_SHUTDOWN_GRACE=$TORTURE_SHUTDOWN_GRACE" >> $resdir/qemu-cmd
 echo "# seconds=$seconds" >> $resdir/qemu-cmd
+echo "# TORTURE_KCONFIG_GDB_ARG=\"$TORTURE_KCONFIG_GDB_ARG\"" >> $resdir/qemu-cmd
 
 if test -n "$TORTURE_BUILDONLY"
 then
-- 
2.9.5

