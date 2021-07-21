Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A5BC6377E
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 21:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A8766124B
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 21:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhGUUVP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 16:21:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:33180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229750AbhGUUVH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 16:21:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B868661364;
        Wed, 21 Jul 2021 21:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626901303;
        bh=9uId8r3azyQJ89CEPsuP45AxvIi0PnNXt088A2xmatI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aFZw0D2FiMDJp/LuiUYZck03/HNMO9cmNRCRB0g6IC1GepZ96cGOCTG26Mo8T21RB
         CoYMvoU3Kv2HuN0FUzRG+GrEfd/NgRaE+GPaqKeOXVwUcVfJSwpMDxHxhQhL3tKOWK
         u+cKzsyrIQz5OW7hiMywKsUYjTbLWALSVtzCI68Xsx3/K6Qga1EMT1CYHrReCJksaO
         oiJq055lQl7EaaUmhTt3T26QwmYt5Fj7vr8zz+UrrklxkHW3IInmJOPWmSxTPCIDmk
         1VPamuDZMMP63tlK3DJ27GG1LRHquT3/dkPwr7Vch3dMrPcgeX7lTrxPh8wUQFonSz
         J6ts4WcVBA4lw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E27FD5C10AA; Wed, 21 Jul 2021 14:01:42 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 14/21] torture: Make kvm-test-1-run-qemu.sh apply affinity
Date:   Wed, 21 Jul 2021 14:01:33 -0700
Message-Id: <20210721210140.787717-14-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721205511.GA786917@paulmck-ThinkPad-P17-Gen-1>
References: <20210721205511.GA786917@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This commit causes the kvm-test-1-run-qemu.sh script to check the
TORTURE_AFFINITY environment variable and to add "taskset" commands to
the qemu-cmd file.  The first "taskset" command is applied only if the
TORTURE_AFFINITY environment variable is a non-empty string, and this
command pins the current scenario's guest OS to the specified CPUs.
The second "taskset" command reports the guest OS's affinity in a new
"qemu-affinity" file.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../selftests/rcutorture/bin/kvm-test-1-run-qemu.sh | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh
index 2fd0868b357c4..b9a0bb6f01154 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh
@@ -39,9 +39,16 @@ echo ' ---' `date`: Starting kernel, PID $$
 grep '^#' $resdir/qemu-cmd | sed -e 's/^# //' > $T/qemu-cmd-settings
 . $T/qemu-cmd-settings
 
-# Decorate qemu-cmd with redirection, backgrounding, and PID capture
-sed -e 's/^[^#].*$/& 2>\&1 \&/' < $resdir/qemu-cmd > $T/qemu-cmd
-echo 'echo $! > $resdir/qemu_pid' >> $T/qemu-cmd
+# Decorate qemu-cmd with affinity, redirection, backgrounding, and PID capture
+taskset_command=
+if test -n "$TORTURE_AFFINITY"
+then
+	taskset_command="taskset -c $TORTURE_AFFINITY "
+fi
+sed -e 's/^[^#].*$/'"$taskset_command"'& 2>\&1 \&/' < $resdir/qemu-cmd > $T/qemu-cmd
+echo 'qemu_pid=$!' >> $T/qemu-cmd
+echo 'echo $qemu_pid > $resdir/qemu_pid' >> $T/qemu-cmd
+echo 'taskset -c -p $qemu_pid > $resdir/qemu-affinity' >> $T/qemu-cmd
 
 # In case qemu refuses to run...
 echo "NOTE: $QEMU either did not run or was interactive" > $resdir/console.log
-- 
2.31.1.189.g2e36527f23

