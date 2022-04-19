Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76CEC433EF
	for <rcu@archiver.kernel.org>; Tue, 19 Apr 2022 00:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239341AbiDSASM (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 18 Apr 2022 20:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239369AbiDSASI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 18 Apr 2022 20:18:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD96140B0;
        Mon, 18 Apr 2022 17:15:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABCA761337;
        Tue, 19 Apr 2022 00:15:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 172AFC385A9;
        Tue, 19 Apr 2022 00:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650327327;
        bh=hKYFeLRAfs3mwen3Yl8UtSva8wR3rG52Yfm3W98aAE8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o6CEjkvyr1ezViRAbjUXebY1+4VKLIihGoqKM9XlDTzvghptzNA5W9lukHxl5qFrk
         dQBxZKNG2cD9BLOGhwPY5A/pSeZ4k+Cd/Kxlmw9IscjA1eraHwrhOa1Z6sPSdfO4ES
         cLA6MmAK/7OD9nP1OqACfyIQmMcNn1Ycdzt3PWg7MStAxAlkxIdEr6ONlpBlgKtqsJ
         cJFSCDf20BXGAkmQATZ4ModZdC54PfYkQrKtayKZC0Vi7uI0U760MGTjW5mIDMuRXS
         G0td/ogxGZ2ZEuJAXe8VYUqfGe3Qoi7S6goQAFDcqC3/7+Bn4j/PURIBSxnKUIsUbt
         RB3GXH9JgfTTQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C6EDD5C0848; Mon, 18 Apr 2022 17:15:26 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 03/12] torture: Permit running of experimental torture types
Date:   Mon, 18 Apr 2022 17:15:16 -0700
Message-Id: <20220419001525.3950505-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419001519.GA3950405@paulmck-ThinkPad-P17-Gen-1>
References: <20220419001519.GA3950405@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This commit weakens the checks of the kvm.sh script's --torture parameter
and the kvm-recheck.sh script's parsing so that experimental torture tests
may be created without updating these two scripts.  The changes required
are to the appropriate Makefile and Kconfig file, plus a directory
whose name begins with "X" must be added to the rcutorture/configs file.
This new directory's name can then be passed in via the kvm.sh script's
--torture parameter.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-recheck.sh | 7 ++++++-
 tools/testing/selftests/rcutorture/bin/kvm.sh         | 4 ++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
index 0a5419982ab3..0789c5606d2a 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
@@ -33,7 +33,12 @@ do
 		TORTURE_SUITE="`cat $i/../torture_suite`"
 		configfile=`echo $i | sed -e 's,^.*/,,'`
 		rm -f $i/console.log.*.diags
-		kvm-recheck-${TORTURE_SUITE}.sh $i
+		case "${TORTURE_SUITE}" in
+		X*)
+			;;
+		*)
+			kvm-recheck-${TORTURE_SUITE}.sh $i
+		esac
 		if test -f "$i/qemu-retval" && test "`cat $i/qemu-retval`" -ne 0 && test "`cat $i/qemu-retval`" -ne 137
 		then
 			echo QEMU error, output:
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 55b2c1533282..af58b86a503a 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -86,7 +86,7 @@ usage () {
 	echo "       --remote"
 	echo "       --results absolute-pathname"
 	echo "       --shutdown-grace seconds"
-	echo "       --torture lock|rcu|rcuscale|refscale|scf"
+	echo "       --torture lock|rcu|rcuscale|refscale|scf|X*"
 	echo "       --trust-make"
 	exit 1
 }
@@ -231,7 +231,7 @@ do
 		shift
 		;;
 	--torture)
-		checkarg --torture "(suite name)" "$#" "$2" '^\(lock\|rcu\|rcuscale\|refscale\|scf\)$' '^--'
+		checkarg --torture "(suite name)" "$#" "$2" '^\(lock\|rcu\|rcuscale\|refscale\|scf\|X.*\)$' '^--'
 		TORTURE_SUITE=$2
 		TORTURE_MOD="`echo $TORTURE_SUITE | sed -e 's/^\(lock\|rcu\|scf\)$/\1torture/'`"
 		shift
-- 
2.31.1.189.g2e36527f23

