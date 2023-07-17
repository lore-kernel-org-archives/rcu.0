Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48159C001DF
	for <rcu@archiver.kernel.org>; Mon, 17 Jul 2023 18:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjGQSYY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 17 Jul 2023 14:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjGQSYF (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 17 Jul 2023 14:24:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA47610EF;
        Mon, 17 Jul 2023 11:23:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D849661213;
        Mon, 17 Jul 2023 18:23:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F9EBC43215;
        Mon, 17 Jul 2023 18:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689618220;
        bh=tpSNGTaai4SYfMsF8EY+/TuqmqP8/w/8cn3E8iuGjL8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WUE/bRySZD5f6P4vEdRcD4NT2CCcZokn/SYfBfjCGw+h8luuY1SosYpoS2bgHuhBh
         i9srvlzw2dsX15gD3iLXQoSvy2+ySd36Wr69kMuF9Ihj+7aq6z9cz9vgOCks8QbeFV
         pviKQObTY7HJbOvSPHSkPkmFejXynnydTVodM8KQkVK6Pj0yd/Maskqkd7Rby/b/OD
         clcaJzJJMTjWiQs2lby70CEhX1j7OyCnXSUV0uGm72NjifFq1Jq3oRuxC6hVUE5h8j
         G9bFUf/E/mcz96Cbyumo+wQNtKCbFXBxny//uQzG0Ti0qpM9ExlKQbsFMaLlwHSNv3
         Z5dsIQlZe4e5Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3AE94CE0A11; Mon, 17 Jul 2023 11:23:39 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 13/18] torture: Add srcu_lockdep.sh to torture.sh
Date:   Mon, 17 Jul 2023 11:23:32 -0700
Message-Id: <20230717182337.1098991-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <d03c7482-acde-4f33-a7fb-fa7c58fdc9a2@paulmck-laptop>
References: <d03c7482-acde-4f33-a7fb-fa7c58fdc9a2@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This commit adds srcu_lockdep.sh to torture.sh, thus exercizing the
extended SRCU-aware lockdep-RCU functionality on a regular basis.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../selftests/rcutorture/bin/torture.sh       | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index d36b839bf586..7917ba9ea544 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -56,6 +56,7 @@ do_kcsan=no
 do_clocksourcewd=yes
 do_rt=yes
 do_rcutasksflavors=yes
+do_srcu_lockdep=yes
 
 # doyesno - Helper function for yes/no arguments
 function doyesno () {
@@ -87,6 +88,7 @@ usage () {
 	echo "       --do-refscale / --do-no-refscale / --no-refscale"
 	echo "       --do-rt / --do-no-rt / --no-rt"
 	echo "       --do-scftorture / --do-no-scftorture / --no-scftorture"
+	echo "       --do-srcu-lockdep / --do-no-srcu-lockdep / --no-srcu-lockdep"
 	echo "       --duration [ <minutes> | <hours>h | <days>d ]"
 	echo "       --kcsan-kmake-arg kernel-make-arguments"
 	exit 1
@@ -179,6 +181,9 @@ do
 	--do-scftorture|--do-no-scftorture|--no-scftorture)
 		do_scftorture=`doyesno "$1" --do-scftorture`
 		;;
+	--do-srcu-lockdep|--do-no-srcu-lockdep|--no-srcu-lockdep)
+		do_srcu_lockdep=`doyesno "$1" --do-srcu-lockdep`
+		;;
 	--duration)
 		checkarg --duration "(minutes)" $# "$2" '^[0-9][0-9]*\(m\|h\|d\|\)$' '^error'
 		mult=1
@@ -432,6 +437,23 @@ then
 	torture_set "rcurttorture-exp" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration "$duration_rcutorture" --configs "TREE03" --trust-make
 fi
 
+if test "$do_srcu_lockdep" = "yes"
+then
+	echo " --- do-srcu-lockdep:" Start `date` | tee -a $T/log
+	tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh --datestamp "$ds/results-srcu-lockdep" > $T/srcu_lockdep.sh.out 2>&1
+	retcode=$?
+	cp $T/srcu_lockdep.sh.out "tools/testing/selftests/rcutorture/res/$ds/results-srcu-lockdep/log"
+	if test "$retcode" -eq 0
+	then
+		echo "srcu_lockdep($retcode)" "tools/testing/selftests/rcutorture/res/$ds/results-srcu-lockdep" >> $T/successes
+		echo Success >> "tools/testing/selftests/rcutorture/res/$ds/results-srcu-lockdep/log"
+	else
+		echo "srcu_lockdep($retcode)" "tools/testing/selftests/rcutorture/res/$ds/results-srcu-lockdep" >> $T/failures
+		echo " --- srcu_lockdep Test Summary:" >> "tools/testing/selftests/rcutorture/res/$ds/results-srcu-lockdep/log"
+		echo " --- Summary: Exit code $retcode from srcu_lockdep.sh, see ds/results-srcu-lockdep" >> "tools/testing/selftests/rcutorture/res/$ds/results-srcu-lockdep/log"
+	fi
+fi
+
 if test "$do_refscale" = yes
 then
 	primlist="`grep '\.name[ 	]*=' kernel/rcu/refscale.c | sed -e 's/^[^"]*"//' -e 's/".*$//'`"
-- 
2.40.1

