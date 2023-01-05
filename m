Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FB3C46467
	for <rcu@archiver.kernel.org>; Thu,  5 Jan 2023 00:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjAEAwS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 4 Jan 2023 19:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjAEAwA (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 4 Jan 2023 19:52:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF6E4F11F;
        Wed,  4 Jan 2023 16:46:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49B5E61892;
        Thu,  5 Jan 2023 00:46:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A835FC433F0;
        Thu,  5 Jan 2023 00:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672879615;
        bh=B6gIniQnZBonQ3QREWfSBaHtgf7ijfEwBiQzYXwXU6k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HM4dasVfwPpZTJb0eDebMijs/CLqc5FPyJZMnk32tAG1VY6tWuE8HCGehQ2ZR1mof
         VX4u618gphCXuH/GgLm/9ImZr+b9Dl5JmRkHpLfgjZOTxdnqe8tzKTHtyUKEJJSZvy
         1MfqNV/VszGeHWdwSdXARDM4E6c6HmLPnzuH0DDOI/uO2+LQOvC5VuI1ibiiZPmzUb
         wGU2WXQ5c1O4NHsh57a755g9+41nz90IBs4aciUE35lASD8NjdRKo8yHHpO2bRj0vU
         afrd47DXcrGMaYCTME3xalgvtYRbPB/vBZidKBmGZMlm3cCUlA+cugVjfMVgxLSZk/
         hs1Mttj93fD8Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5BFC55C05CA; Wed,  4 Jan 2023 16:46:55 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 1/4] torture: make kvm-find-errors.sh check for compressed vmlinux files
Date:   Wed,  4 Jan 2023 16:46:49 -0800
Message-Id: <20230105004652.1771676-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105004646.GA1771551@paulmck-ThinkPad-P17-Gen-1>
References: <20230105004646.GA1771551@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Under some conditions, a given run's vmlinux file will be compressed,
so that it is named vmlinux.xz rather than vmlinux.  in such cases,
kvm-find-errors.sh will complain about the nonexistence of vmlinux.
This commit therefore causes kvm-find-errors.sh to check for vmlinux.xz
as well as for vmlinux.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh b/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
index 88983cba79563..d4dc059843a43 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
@@ -36,7 +36,7 @@ do
 	then
 		egrep "error:|warning:|^ld: .*undefined reference to" < $i > $i.diags
 		files="$files $i.diags $i"
-	elif ! test -f ${scenariobasedir}/vmlinux && ! test -f "${rundir}/re-run"
+	elif ! test -f ${scenariobasedir}/vmlinux && ! test -f ${scenariobasedir}/vmlinux.xz && ! test -f "${rundir}/re-run"
 	then
 		echo No ${scenariobasedir}/vmlinux file > $i.diags
 		files="$files $i.diags $i"
-- 
2.31.1.189.g2e36527f23

