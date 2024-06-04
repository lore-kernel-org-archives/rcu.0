Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282A2145322;
	Tue,  4 Jun 2024 22:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717539837; cv=none; b=gO5KqU7hcuBR8PgfhPuxdkW2aIz0WG47tu2NB7Um+Z93PrysUb9jA5N3nTU4U1N0N/lwFpYvwGRKQwy14GF3aUkzxqjVakVpLhkyoTj7MYT8YB+EiCf/7jo+jxDrDtCP78GPzWEtun2dut9rVy0/D2booqY5D7Km65ffT1V3oGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717539837; c=relaxed/simple;
	bh=Zg9sZgSfw8tshKxAzI3tRPCKrOIhzkGKLv0XgiHxsM8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WAGx8X1ly7Z82GQwUeE5dRpLWMCTnP9bFdD4XoicZuPunNlag2F1F5WWBFPoEcH8kX+D1B3P1vOH5TzBUMzld6Tl9VpN22kcmm58o/tw3e3opcBIFvaHs5aEAjTtsmrXsC8NYnNM3pNht88WiXbPBbdkpWW/zUZQuECRENDwn7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SS+UH7cu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SS+UH7cu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7DF9C2BBFC;
	Tue,  4 Jun 2024 22:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717539836;
	bh=Zg9sZgSfw8tshKxAzI3tRPCKrOIhzkGKLv0XgiHxsM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SS+UH7cuLvDau5uNM/gzwumHyeUhSvhZjWKDAh0R08pe+kWTHr6B0sW3nIobnTbPK
	 pfIbzPhGCS9fSN+RpdylGD4JVJ1NxKbrNn2vYu25HgrwNlSDgtSzh1y9YNSXiFSf75
	 LTH8hQaiRPEUYnTq4cnuRYOycWkVi9gItuDKzPNiivBTfobmL3QdheLQC916jhqbS3
	 GpvwxexASDXfWgRqvGI/ZweGSYeIYs5K/VuARYV7wH9K/JvVfbkmKs4X+/bLmtwLYW
	 /L/uMR6JdJU149Pd6/lcbmTpfgH/p+HWhrow2hD3nOv/4tT84A7BqGXm3O7UNu9BDZ
	 LSiZrHadbpZ2A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5A049CE3ED6; Tue,  4 Jun 2024 15:23:56 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH rcu 1/9] rcu: Add lockdep_assert_in_rcu_read_lock() and friends
Date: Tue,  4 Jun 2024 15:23:47 -0700
Message-Id: <20240604222355.2370768-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <657595c8-e86c-4594-a5b1-3c64a8275607@paulmck-laptop>
References: <657595c8-e86c-4594-a5b1-3c64a8275607@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no direct RCU counterpart to lockdep_assert_irqs_disabled()
and friends.  Although it is possible to construct them, it would
be more convenient to have the following lockdep assertions:

lockdep_assert_in_rcu_read_lock()
lockdep_assert_in_rcu_read_lock_bh()
lockdep_assert_in_rcu_read_lock_sched()
lockdep_assert_in_rcu_reader()

This commit therefore creates them.

Reported-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h | 60 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index dfd2399f2cde0..8470a85f65634 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -421,11 +421,71 @@ static inline void rcu_preempt_sleep_check(void) { }
 				 "Illegal context switch in RCU-sched read-side critical section"); \
 	} while (0)
 
+// See RCU_LOCKDEP_WARN() for an explanation of the double call to
+// debug_lockdep_rcu_enabled().
+static inline bool lockdep_assert_rcu_helper(bool c)
+{
+	return debug_lockdep_rcu_enabled() &&
+	       (c || !rcu_is_watching() || !rcu_lockdep_current_cpu_online()) &&
+	       debug_lockdep_rcu_enabled();
+}
+
+/**
+ * lockdep_assert_in_rcu_read_lock - WARN if not protected by rcu_read_lock()
+ *
+ * Splats if lockdep is enabled and there is no rcu_read_lock() in effect.
+ */
+#define lockdep_assert_in_rcu_read_lock() \
+	WARN_ON_ONCE(lockdep_assert_rcu_helper(!lock_is_held(&rcu_lock_map)))
+
+/**
+ * lockdep_assert_in_rcu_read_lock_bh - WARN if not protected by rcu_read_lock_bh()
+ *
+ * Splats if lockdep is enabled and there is no rcu_read_lock_bh() in effect.
+ * Note that local_bh_disable() and friends do not suffice here, instead an
+ * actual rcu_read_lock_bh() is required.
+ */
+#define lockdep_assert_in_rcu_read_lock_bh() \
+	WARN_ON_ONCE(lockdep_assert_rcu_helper(!lock_is_held(&rcu_bh_lock_map)))
+
+/**
+ * lockdep_assert_in_rcu_read_lock_sched - WARN if not protected by rcu_read_lock_sched()
+ *
+ * Splats if lockdep is enabled and there is no rcu_read_lock_sched()
+ * in effect.  Note that preempt_disable() and friends do not suffice here,
+ * instead an actual rcu_read_lock_sched() is required.
+ */
+#define lockdep_assert_in_rcu_read_lock_sched() \
+	WARN_ON_ONCE(lockdep_assert_rcu_helper(!lock_is_held(&rcu_sched_lock_map)))
+
+/**
+ * lockdep_assert_in_rcu_reader - WARN if not within some type of RCU reader
+ *
+ * Splats if lockdep is enabled and there is no RCU reader of any
+ * type in effect.  Note that regions of code protected by things like
+ * preempt_disable, local_bh_disable(), and local_irq_disable() all qualify
+ * as RCU readers.
+ *
+ * Note that this will never trigger in PREEMPT_NONE or PREEMPT_VOLUNTARY
+ * kernels that are not also built with PREEMPT_COUNT.  But if you have
+ * lockdep enabled, you might as well also enable PREEMPT_COUNT.
+ */
+#define lockdep_assert_in_rcu_reader()								\
+	WARN_ON_ONCE(lockdep_assert_rcu_helper(!lock_is_held(&rcu_lock_map) &&			\
+					       !lock_is_held(&rcu_bh_lock_map) &&		\
+					       !lock_is_held(&rcu_sched_lock_map) &&		\
+					       preemptible()))
+
 #else /* #ifdef CONFIG_PROVE_RCU */
 
 #define RCU_LOCKDEP_WARN(c, s) do { } while (0 && (c))
 #define rcu_sleep_check() do { } while (0)
 
+#define lockdep_assert_in_rcu_read_lock() do { } while (0)
+#define lockdep_assert_in_rcu_read_lock_bh() do { } while (0)
+#define lockdep_assert_in_rcu_read_lock_sched() do { } while (0)
+#define lockdep_assert_in_rcu_reader() do { } while (0)
+
 #endif /* #else #ifdef CONFIG_PROVE_RCU */
 
 /*
-- 
2.40.1

