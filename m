Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2D5C433F5
	for <rcu@archiver.kernel.org>; Thu, 16 Sep 2021 00:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3027611C6
	for <rcu@archiver.kernel.org>; Thu, 16 Sep 2021 00:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbhIPA3W (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Sep 2021 20:29:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:59038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233317AbhIPA3V (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Sep 2021 20:29:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A6B97611C1;
        Thu, 16 Sep 2021 00:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631752081;
        bh=yN7E9AbJ0S+LjDJHsAoRy/UPCIkD4N6ykt7IU+TrEhE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eyy1WnQlgxORihPA7fGm/K3DhcSLqD2yBZybAytdrgOTCa7HST0+5WzUK8PL1jLyH
         KPYbhEU8a4Pu3rbvJfRCKpol7ZAV3olnuwjkO18ilMPiW93lIZqye9Gq5JwE/HslhR
         dYz8wCfJMEtl/y+i2y13ZWc09YzyButMyzIpHVogNpKO6iZXYKPV4DOqb2DBDGvniQ
         3Fif1/I2ocUJLPYfBSb6xv8waa270Me/gXWGtVgFek+5qJaqiula2jqSa9sGS8Ivtt
         WJIj15/Ys84bVEt3Bl3JRCzPd5CjcqeoVsiuNw+JBRqX1pnPKcHPOjocXhRPvd8K49
         bS9xnU+wtcMbw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 760185C0926; Wed, 15 Sep 2021 17:28:01 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 5/5] torture: Make kvm-remote.sh print size of downloaded tarball
Date:   Wed, 15 Sep 2021 17:28:00 -0700
Message-Id: <20210916002800.3910056-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210916002710.GA3909915@paulmck-ThinkPad-P17-Gen-1>
References: <20210916002710.GA3909915@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This commit causes kvm-remote.sh to print the size of the tarball that
is downloaded to each of the remote systems.  This size can help with
performance projections and analysis.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-remote.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-remote.sh b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
index 03126eb6ec5a..c7d42ef80c53 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
@@ -149,6 +149,7 @@ do
 done
 
 # Download and expand the tarball on all systems.
+echo Build-products tarball: `du -h $T/binres.tgz` | tee -a "$oldrun/remote-log"
 for i in $systems
 do
 	echo Downloading tarball to $i `date` | tee -a "$oldrun/remote-log"
-- 
2.31.1.189.g2e36527f23

