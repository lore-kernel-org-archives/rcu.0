Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F049938657E;
	Sat, 19 Sep 2026 00:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789776067; cv=none; b=G4SpIHC+gc6154TAtyboLcLrTQi+ZPkBSs5cZwDp/3dmo/KecN3khErJkv2toSf8O5jA+8oig2aZA54lsV+SpqrqpsvFZXDvTvJBCqytscHsJsjYr4uZCMNSdH3ujM9mbc8rb7AHzqKyc5IfUFhZ1tsn6TgTQV06VToK1aJm1pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789776067; c=relaxed/simple;
	bh=a4iqDk2sW7NpnOWbXOs/N0Dj777ujfFxQbZ/THu2rYE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yiv3HjuJ7vMM/l1RUltV1YAmKyCjAb9ow55iMheI8fmJ2hFgOyxOrJL14ZbRSIlfTWsd10GIeohw55+5uKlK8QQZElJSXUEk94KKJsn4UL2YguT2VMifj8fr2tv/P7npF821xyx7aSXr+JEvz/QUWgS4YB2uHEV5rhFj6BnoQFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUAHReIS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUAHReIS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 737251F00A01;
	Sat, 19 Sep 2026 00:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789776060;
	bh=b4oGecD+B+nMPlN67gULlmKi6boDi4yjYjSch2MF0ng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XUAHReISgEoBb7pUQ8p31orXeFsV6qujDVE1GIxluvsOh3PkmX4y6YFvRk5lCVmfm
	 Lw50gjUGDbTtD9cBSNuVk9BSNd3P/HpboiVF6ratSqRp2e0dkZwfaU3lMHg33BJ8uv
	 ODo4sf5EqnwLh+sJ8VBStjYvK9FC8JeQj4/rnJ2vFrM5NhKb8aKBJ4XN3FM6wkvyV6
	 RJnUn5HoCbd+Ot+NRo7dj1MeRdLIS09EH0+ik7Hc3jjmFmQgf0UgFBdQK5LriF/hIy
	 Bm18bSIqd2yiJXjjZLRHKBscGjKolD82R4U1oqu+OY9fzl28cPGqFszWlqz0g8b+al
	 qG6001scaARaQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 72059CE0D0D; Fri, 18 Sep 2026 17:00:59 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Boqun Feng <boqun@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	lkmm@lists.linux.dev,
	Zqiang <qiang.zhang@linux.dev>,
	Wang Lian <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Bradley Morgan <brads@mainlining.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 14/28] hazptrtorture: Pass hazptr_pending to hazptr_torture_reader_tail()
Date: Fri, 18 Sep 2026 17:00:42 -0700
Message-Id: <20260919000056.3132131-14-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop>
References: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit passes a hazptr_pending structure instead of a pair of
pointers to the hazptr_torture_reader_tail() function in order to make it
easier to test the releasing of hazard pointers from interrupt handlers.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: <rcu@vger.kernel.org>
Cc: <lkmm@lists.linux.dev>
---
 kernel/rcu/hazptrtorture.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
index 51fd0562f9fa..ece38f444be6 100644
--- a/kernel/rcu/hazptrtorture.c
+++ b/kernel/rcu/hazptrtorture.c
@@ -368,9 +368,11 @@ static void hazptr_torture_acquire(void *hppp_in)
  * be invoked from hazptr_torture_reader, but also for hazard pointers
  * sent off to interrupt handlers and the like.
  */
-static void hazptr_torture_reader_tail(struct hazptr_ctx *hcp, struct hazptr_torture *htp,
-				       struct torture_random_state *trsp)
+static void
+hazptr_torture_reader_tail(struct hazptr_pending *hppp, struct torture_random_state *trsp)
 {
+	struct hazptr_ctx *hcp = &hppp->hpp_hc;
+	struct hazptr_torture *htp = hppp->hpp_htp;
 	int pipe_count;
 
 	cur_ops->read_delay(trsp);
@@ -453,7 +455,7 @@ static int hazptr_torture_reader(void *arg)
 			hazptr_torture_defer(hppp, &rand);
 			hppp = NULL;
 		} else {
-			hazptr_torture_reader_tail(&hppp->hpp_hc, hppp->hpp_htp, &rand);
+			hazptr_torture_reader_tail(hppp, &rand);
 		}
 		while (!torture_must_stop() &&
 		       (torture_num_online_cpus() < mynumonline || !rcu_inkernel_boot_has_ended()))
@@ -479,7 +481,7 @@ static void hazptr_torture_do_one_pending(int cpu, struct torture_random_state *
 	if (!llnp)
 		return;
 	llist_for_each_entry_safe(hppp, hppp1, llnp, hpp_node) {
-		hazptr_torture_reader_tail(&hppp->hpp_hc, hppp->hpp_htp, trsp);
+		hazptr_torture_reader_tail(hppp, trsp);
 		kfree(hppp);
 	}
 }
-- 
2.40.1

