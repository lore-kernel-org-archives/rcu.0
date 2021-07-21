Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97732C6377E
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 21:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79CC06124B
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 21:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhGUUVM (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 16:21:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:33182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229638AbhGUUVH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 16:21:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 63A7A6128A;
        Wed, 21 Jul 2021 21:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626901303;
        bh=hCYgEjm28HUWvCmBn4VbCaGHESdbATNc/Ga+CADkdVI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GjbiDJ7iTLDnYG2cxYMMgqZyyXpY0Fre37J4/1i2ffPBxhVyc3MvUJ+sGXwtKq8o4
         PJ/eDggOV/ueybMTPYz16X99+uC6OpexMNFJRCosKaZs0IC/SukvFhxGWuw+lcvAKp
         eOAvBqNkai4gejwIG08yjDYUPJU8X5hGsq1M8tsG5pPZv+v3T0gj8C6v3MZNW/Lw5U
         DbtcFa+CfBXY0cs0YsazxK0Tof+G1yxLOfG7gYwjPNXiZaqChCjUnuFfLYWP3jQdXO
         8AmyfOu43Si/hoHZ9djiz9TsAZ8NaZs2fjA1mSoXhPwUkLUX/NOBWiJAk8RgzpiCxd
         WAjlNmHDF0eWQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D51535C0D47; Wed, 21 Jul 2021 14:01:42 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 07/21] torture: Log more kvm-remote.sh information
Date:   Wed, 21 Jul 2021 14:01:26 -0700
Message-Id: <20210721210140.787717-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721205511.GA786917@paulmck-ThinkPad-P17-Gen-1>
References: <20210721205511.GA786917@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This commit logs additional information to help track down set up and
networking issues.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../selftests/rcutorture/bin/kvm-remote.sh        | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-remote.sh b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
index 79e680e0e7bf3..8f26dbfc2edf2 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
@@ -128,6 +128,7 @@ awk < "$rundir"/scenarios -v dest="$T/bin" -v rundir="$rundir" '
 	for (i = 2; i <= NF; i++)
 		scenarios = scenarios " " $i;
 	print "kvm-test-1-run-batch.sh" scenarios > fn;
+	print "sync" >> fn;
 	print "rm " rundir "/remote.run" >> fn;
 }'
 chmod +x $T/bin/kvm-remote-*.sh
@@ -172,11 +173,20 @@ checkremotefile () {
 	do
 		ssh $1 "test -f \"$2\""
 		ret=$?
-		if test "$ret" -ne 255
+		if test "$ret" -eq 255
 		then
+			echo " ---" ssh failure to $1 checking for file $2, retry after $sleeptime seconds. `date`
+		elif test "$ret" -eq 0
+		then
+			return 0
+		elif test "$ret" -eq 1
+		then
+			echo " ---" File \"$2\" not found: ssh $1 test -f \"$2\"
+			return 1
+		else
+			echo " ---" Exit code $ret: ssh $1 test -f \"$2\", retry after $sleeptime seconds. `date`
 			return $ret
 		fi
-		echo " ---" ssh failure to $1 checking for file $2, retry after $sleeptime seconds. `date`
 		sleep $sleeptime
 	done
 }
@@ -242,6 +252,7 @@ do
 	do
 		sleep 30
 	done
+	echo " ---" Collecting results from $i `date`
 	( cd "$oldrun"; ssh $i "cd $rundir; tar -czf - kvm-remote-*.sh.out */console.log */kvm-test-1-run*.sh.out */qemu_pid */qemu-retval; rm -rf $T > /dev/null 2>&1" | tar -xzf - )
 done
 
-- 
2.31.1.189.g2e36527f23

