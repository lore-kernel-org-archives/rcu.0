Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9FD345ECC;
	Sat, 19 Sep 2026 00:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789776068; cv=none; b=aQLAAcXiELYGn6dsikMhXHsAnzJ0fq84DF5tk31KL3PbjZdAvT5x2OCYqvRODz53IqmwYP2f9YeKc9/rhEJeBlA1vwQhiC//9/Fn8+Rojlqndl++MpNXYaZd5gyuvO1SIMQmHfvVIxFNdNIs006G2RsU3lyVJ2Yp/9Y2DuOrIbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789776068; c=relaxed/simple;
	bh=6ELFQ4Z2TThkDPIJA5/pqfNK9faShsZB7nRuBVb/JyU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P3i8IxeqiNRpGHuwpW16cwcmC51REymkmnUqRyG2gjVyd56eBxVNGQBfp1mpIpChFCiEvMeMoA3KuIZRMEDOZ47sJMyS9FXMaquNnpv09cC2WdlNq3xmSUiDSZ/xCIDW1VrbHfYlR8yEATew2HyYTPgdsmQxeyvVHj/7K5c2sTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFfYqIQ3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFfYqIQ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736EC1F00A00;
	Sat, 19 Sep 2026 00:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789776060;
	bh=mP2PCaDbJqdjlgsc1Ld509iGstx6Zy0F7L0kJv8SOmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bFfYqIQ3NBO8fIu3VGrei6fgzYcCJ0sxyWhDhEv3HjsfyKLRfg5yRyR3Ou3s0+4nf
	 vLLfAxOKInb8pKe2/IDARQQ85NNSN8FjzDYH7j1MoVt1RNjYrz1D78f/Ca/Vfw/sI2
	 ynSEGqqzMwnTacszETSbVD1W+8kHe8NPGHZc16EkrASqcyqJg6ytpBFA6KNtmRX6Gi
	 HGb10LH2o1iEXHQDpr2Gjj7dNvh4sZK/0iNBKb52cyO3qVnlZPhFvoIDbGJpNOlH7g
	 8oBlEE7Y3GhS++TbuMIG6CGJult/IySO45znd67rP8z8DEPBrjvcifb5AZZU+4wKrt
	 YgovlJvhtZA5Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 92522CE0F29; Fri, 18 Sep 2026 17:00:59 -0700 (PDT)
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
	Bradley Morgan <include@grrlz.net>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 25/28] hazptrtorture: Fix inverted sleep condition in do_pending kthread
Date: Fri, 18 Sep 2026 17:00:53 -0700
Message-Id: <20260919000056.3132131-25-paulmck@kernel.org>
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

From: Bradley Morgan <include@grrlz.net>

The do_pending kthread never sleeps. Its supposed to.
kthread_do_pending_ms sets the gap between cleanups, and the docs
say so too. But the sleep sits behind torture_must_stop(), and thats
false while the test runs. So the kthread never sleeps. It just loops.
It drains the pending lists over and over, no pause, and burns a full
CPU for the whole test.

Flip the check. With !torture_must_stop() it sleeps for
kthread_do_pending_ms between passes. When the test stops it does one
last cleanup and exits. Nothing left to do, so no sleep needed then.

Fixes: 94d2e93c222e ("hazptrtorture: Add kthread to release deferred hazard pointers")
Signed-off-by: Bradley Morgan <include@grrlz.net>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 kernel/rcu/hazptrtorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
index 72aeb50668e9..7c8b5899fb01 100644
--- a/kernel/rcu/hazptrtorture.c
+++ b/kernel/rcu/hazptrtorture.c
@@ -555,7 +555,7 @@ static int hazptr_torture_do_pending(void *arg)
 			cpu = cpumask_next_wrap(cpu, cpu_possible_mask);
 			hazptr_torture_do_one_pending(cpu, &rand);
 		}
-		if (torture_must_stop())
+		if (!torture_must_stop())
 			torture_hrtimeout_ms(kthread_do_pending_ms, USEC_PER_MSEC, &rand);
 		// Omit stutter_wait() because this function needs to do cleanup.
 	} while (!torture_must_stop());
-- 
2.40.1

