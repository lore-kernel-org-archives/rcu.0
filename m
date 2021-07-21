Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BA1C6377B
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 21:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E0DF61246
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 21:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhGUUVO (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 16:21:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:33214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229699AbhGUUVH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 16:21:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A8A9F61369;
        Wed, 21 Jul 2021 21:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626901303;
        bh=h7y1IPoLKf0WIKi0qVEuaafWd+uFwVuM9gFNWPdggCg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I6Yu8g68h4bq+QmdnbJUdYy894h8kvm38BLltUd6lW3BTpDiJ7oCH2AHHG9OzEd5n
         aIFVvaVJWhYk/QpnWKCNfezU05G3WbUnZKufCPKPIblpUlCOPq/AkqYLLqx312rUBv
         5NevXEjJSNL1CwFctehGtghCXMJiC5EbZglhV0JqBiDthS9xGSaOyECk5a1qTe4ia9
         l9R+IVoZ+IrGFckD3xiDaLogA4IRE7KERSk2x7EAnNytcxVrXJpLSP3A9Iqo3Qtu7o
         rs0Qw2luJJfMkZK6BuFz2vu+zkZojnXeVN5VIc9xF3N4CrtEx2rHCMnxTA7dsyqdQ2
         UcGeTud/BImuA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E65295C22F7; Wed, 21 Jul 2021 14:01:42 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 16/21] torture: Use numeric taskset argument in jitter.sh
Date:   Wed, 21 Jul 2021 14:01:35 -0700
Message-Id: <20210721210140.787717-16-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721205511.GA786917@paulmck-ThinkPad-P17-Gen-1>
References: <20210721205511.GA786917@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The jitter.sh script has some entertaining awk code to generate a
hex mask from a randomly selected CPU number, which is handed to the
"taskset" command.  Except that this command has a "-c" parameter to
take a comma/dash-separated list of CPU numbers.  This commit therefore
saves a few lines of awk by switching to a single-number CPU list.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/jitter.sh | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/jitter.sh b/tools/testing/selftests/rcutorture/bin/jitter.sh
index 15d937ba96cad..fd1ffaa5a1358 100755
--- a/tools/testing/selftests/rcutorture/bin/jitter.sh
+++ b/tools/testing/selftests/rcutorture/bin/jitter.sh
@@ -68,16 +68,12 @@ do
 	cpumask=`awk -v cpus="$cpus" -v me=$me -v n=$n 'BEGIN {
 		srand(n + me + systime());
 		ncpus = split(cpus, ca);
-		curcpu = ca[int(rand() * ncpus + 1)];
-		z = "";
-		for (i = 1; 4 * i <= curcpu; i++)
-			z = z "0";
-		print "0x" 2 ^ (curcpu % 4) z;
+		print ca[int(rand() * ncpus + 1)];
 	}' < /dev/null`
 	n=$(($n+1))
-	if ! taskset -p $cpumask $$ > /dev/null 2>&1
+	if ! taskset -c -p $cpumask $$ > /dev/null 2>&1
 	then
-		echo taskset failure: '"taskset -p ' $cpumask $$ '"'
+		echo taskset failure: '"taskset -c -p ' $cpumask $$ '"'
 		exit 1
 	fi
 
-- 
2.31.1.189.g2e36527f23

