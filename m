Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E89DEB64DC
	for <rcu@archiver.kernel.org>; Mon, 17 Jul 2023 18:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbjGQSSk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 17 Jul 2023 14:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbjGQSSf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 17 Jul 2023 14:18:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092671700;
        Mon, 17 Jul 2023 11:18:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 916F7611DC;
        Mon, 17 Jul 2023 18:18:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A34C433C7;
        Mon, 17 Jul 2023 18:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689617903;
        bh=5yZnYA/vYH5K7ZYo4itQZ34JbDb64O4rGCUZ6y8VJ9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C6GIMua+brOodMq7+iCLtjYjLpI4ibvqi1J3nVXHWPyDduASQ+Xh+3oQSa4v8O8e7
         8oXCUzQgNtwAfUFwWfqPnB1wV9IvTJDnAbRW69Wm3OFDArHJmvJ74Ytj7ucDmHi97d
         uElDQM7sw0ZZenGPbp01W7j24L3g1VspxVR/MFmUgv+MmhBoQi1SY5ubBSDQkhFmH8
         ZIAQxleBE/6tpMNZlpWZq3vxm29G6HprQnisVF/Tr8VRA6cUOjEmM99SRxOUOJ0L86
         ei4rHA4PwBD1yO7R/0dExfc5i6WjQDB77286MTEK2KqK12BVw9zO8XW0sXyVY0O/UR
         bkPForBmE6A/w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A836DCE03F1; Mon, 17 Jul 2023 11:18:22 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 1/4] torture: Scale scftorture memory based on number of CPUs
Date:   Mon, 17 Jul 2023 11:18:17 -0700
Message-Id: <20230717181820.1098541-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <38be0135-a7a4-4c16-b2c6-1b3817c3067f@paulmck-laptop>
References: <38be0135-a7a4-4c16-b2c6-1b3817c3067f@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

As the number of CPUs increases, the number of outstanding no-wait
smp_call_function() handlers also increases, so that the default of
2G of memory is not always sufficient on 80-CPU systems.  This commit
therefore scales the amount of memory specified to qemu based on the
number of CPUs specified to the scftorture test instance.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index 5a2ae2264403..9fa6526067f0 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -376,8 +376,10 @@ fi
 
 if test "$do_scftorture" = "yes"
 then
+	# Scale memory based on the number of CPUs.
+	scfmem=$((2+HALF_ALLOTED_CPUS/16))
 	torture_bootargs="scftorture.nthreads=$HALF_ALLOTED_CPUS torture.disable_onoff_at_boot csdlock_debug=1"
-	torture_set "scftorture" tools/testing/selftests/rcutorture/bin/kvm.sh --torture scf --allcpus --duration "$duration_scftorture" --configs "$configs_scftorture" --kconfig "CONFIG_NR_CPUS=$HALF_ALLOTED_CPUS" --memory 2G --trust-make
+	torture_set "scftorture" tools/testing/selftests/rcutorture/bin/kvm.sh --torture scf --allcpus --duration "$duration_scftorture" --configs "$configs_scftorture" --kconfig "CONFIG_NR_CPUS=$HALF_ALLOTED_CPUS" --memory ${scfmem}G --trust-make
 fi
 
 if test "$do_rt" = "yes"
-- 
2.40.1

