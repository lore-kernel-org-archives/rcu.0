Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0CFC43219
	for <rcu@archiver.kernel.org>; Tue, 19 Apr 2022 00:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239369AbiDSASP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 18 Apr 2022 20:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239840AbiDSASM (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 18 Apr 2022 20:18:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527EB140F3;
        Mon, 18 Apr 2022 17:15:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5557B8113A;
        Tue, 19 Apr 2022 00:15:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77B06C385B0;
        Tue, 19 Apr 2022 00:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650327327;
        bh=o3Ak4YE3U+NXcNtnERapFxHUhpwWgj59xr5vPo6wev8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XbGJtWFMJ7gSDMwij2wWriR5fBFI/P6AvK2N5qfJ+hcEbCuKWjbqR9hYrEP36NzeI
         yrrCQAKSrNDd7Ndo28Hy4KuLv3fAtwViXQPfRdEYQfLHVEm26HXGzMHiGAcqHU7Lps
         vZvtYi5qVaKWvPAhYyPCLCvBDS4X4Mf+AzEDcwSDfcr+bDM4NAAMk4IA9Q4fvulleb
         NBwEBh1N6wjFbgqf7d9Wt5wc0qRQ2pThSXvrP2+IkMWWMARq24wBCXDWSmik4Fjib6
         KyhcM3QUq7fYqxl5kB7Cke8YVcy9geVWwPBD7VbFMyYbQq2hkgW8nURR2h86obF3oO
         TMyIP4CVP0ZyQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D2BC65C12AB; Mon, 18 Apr 2022 17:15:26 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 09/12] torture: Save "make allmodconfig" .config file
Date:   Mon, 18 Apr 2022 17:15:22 -0700
Message-Id: <20220419001525.3950505-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419001519.GA3950405@paulmck-ThinkPad-P17-Gen-1>
References: <20220419001519.GA3950405@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Currently, torture.sh saves only the build output and exit code from the
"make allmodconfig" test.  This commit also saves the .config file.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index e84db823a50d..c5b3dedc6dc4 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -322,6 +322,7 @@ then
 	echo " --- make clean" > "$amcdir/Make.out" 2>&1
 	make -j$MAKE_ALLOTED_CPUS clean >> "$amcdir/Make.out" 2>&1
 	echo " --- make allmodconfig" >> "$amcdir/Make.out" 2>&1
+	cp .config $amcdir
 	make -j$MAKE_ALLOTED_CPUS allmodconfig >> "$amcdir/Make.out" 2>&1
 	echo " --- make " >> "$amcdir/Make.out" 2>&1
 	make -j$MAKE_ALLOTED_CPUS >> "$amcdir/Make.out" 2>&1
-- 
2.31.1.189.g2e36527f23

