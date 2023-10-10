Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9228CCD80BA
	for <rcu@archiver.kernel.org>; Tue, 10 Oct 2023 11:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbjJJL7o (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 10 Oct 2023 07:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbjJJL7l (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 10 Oct 2023 07:59:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46181A9;
        Tue, 10 Oct 2023 04:59:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 914E1C433CA;
        Tue, 10 Oct 2023 11:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696939179;
        bh=tSGEYv51Dhg9ETdgGzzG256uidsi90k2m7SJ6WOU+4I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gCAQ+gwcTruuJDRtJOD7wDN2smXZr8OHY+aalBqsNo/w6qpdEw0ouHcERzJcpI2dl
         ov/OXmxzS+Jn15+KhYlHLyfpOSRV49n60ZzztSqqzJ1zrA4aT3LsFs6Zgd7U9lW9/V
         /7csSZ7mr6gy5B0JmyO+CmArP9+WOgOxayT2L2IhBStZkBjNRebpk5FhYlx9iemCyq
         SJzlOK0d46KUVl5SQGADgs8vyDVQgx0PiL9zYZiE4abyB7olIBRnKvyjCOMSLhzu2Z
         hg7H/Pjf1jWx7YqWS18++iRwrOQ0+NuWt+fGL9XC0Dfvd+0qMSDNTv1qYI8HR364QV
         3mS6ZsVRPk/gw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 02/23] torture: Make kvm-recheck.sh use mktemp
Date:   Tue, 10 Oct 2023 13:59:00 +0200
Message-Id: <20231010115921.988766-3-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010115921.988766-1-frederic@kernel.org>
References: <20231010115921.988766-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit switches from the old "/tmp/kvm-recheck.sh.$$" approach to
the newer and now reliable "mktemp" approach.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-recheck.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
index 5be670dd4009..de65d77b47ff 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
@@ -13,7 +13,7 @@
 #
 # Authors: Paul E. McKenney <paulmck@linux.ibm.com>
 
-T=/tmp/kvm-recheck.sh.$$
+T="`mktemp ${TMPDIR-/tmp}/kvm-recheck.sh.XXXXXX`"
 trap 'rm -f $T' 0 2
 
 configerrors=0
-- 
2.34.1

