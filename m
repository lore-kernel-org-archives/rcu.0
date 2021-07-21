Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB41CC6377C
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 21:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C507861246
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 21:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbhGUUVJ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 16:21:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:33184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229655AbhGUUVH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 16:21:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6392961289;
        Wed, 21 Jul 2021 21:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626901303;
        bh=Ua2aCs2M28OEnDurjWyslc2dz0CsyNmcWg6WUCzeMXA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o+SNnk1pRIFDz5EcPJWArpccrxm0JzDBNcqDng19RSew3nNvhhQhAxRiWbzLOIv32
         sCg9rtdGLKCkS7MuPzSvbkY0soqum5GD6hTqm53dwV7/UKtwJBeXHLs9rmUos39AxE
         eOnKw5DEEuow9qRceqtdudPnaVg+KVAip7C5RfMXQKLXzbqq3Mm+KEjHdeQL/0DCuh
         0OldCJiWN2Fon9CKbe2WsBcqmPRO8mJJ9sWDPe38n+XvCTi2haFtLhZbNHiSzapLdi
         ZvyWZuEKglap7obytENLN2M9EFshYraqcKwoxL9EASNgqTf7chqvOMOULPfbCXPT97
         3Emdz5hF5IZMA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D33D35C0C70; Wed, 21 Jul 2021 14:01:42 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 06/21] torture: Make kvm-recheck-lock.sh tolerate qemu-cmd comments
Date:   Wed, 21 Jul 2021 14:01:25 -0700
Message-Id: <20210721210140.787717-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721205511.GA786917@paulmck-ThinkPad-P17-Gen-1>
References: <20210721205511.GA786917@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The qemu-cmd file can contain comments that are not relevant to the
operation of kvm-recheck-lock.sh.  This commit therefore strips these
comments before looking for timing information.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-recheck-lock.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck-lock.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck-lock.sh
index f3a7a5e2b89d4..db2c0e2c8e1de 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck-lock.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck-lock.sh
@@ -25,7 +25,7 @@ then
 	echo "$configfile -------"
 else
 	title="$configfile ------- $ncs acquisitions/releases"
-	dur=`sed -e 's/^.* locktorture.shutdown_secs=//' -e 's/ .*$//' < $i/qemu-cmd 2> /dev/null`
+	dur=`grep -v '^#' $i/qemu-cmd | sed -e 's/^.* locktorture.shutdown_secs=//' -e 's/ .*$//' 2> /dev/null`
 	if test -z "$dur"
 	then
 		:
-- 
2.31.1.189.g2e36527f23

