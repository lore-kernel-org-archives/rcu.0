Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326161A7273;
	Thu, 12 Dec 2024 18:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029401; cv=none; b=l3t5xRVogCsbv/Rgl9y8Etmqo5TusRiETKYAHWTPJHXkjMc3WORCSMeafMvlJfPzqXpm8F4vzgG1GUjhYITwAmHbISW4RN0xQcXKEfypXM8UKNBiQAjpjlX9dwfSgegDAommN+OinDVt6sdTyDttm2CRlSXBMYmJtUKR9GWknDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029401; c=relaxed/simple;
	bh=ScQnI2Tiu7YwnbaIgWWsJamhTX9TTOQiO/w1w3aYwmM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=faCrArK2H7TYCwX+ul45QFnvzDwLNa6CiN2Pa6IIOX/3a+BS0h/U2hzrKsk5DlKICzLBn0Ef9canaXE6nLNHZQo4ntgWNA4ijIm76YqFYjyCeebV5MCbrm+sjvepVhTpOTfLAJQj6n9SbeAcis8X8ykgyfYDah1/2WgUXrxxwCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tiNIkCqI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tiNIkCqI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D836CC4AF09;
	Thu, 12 Dec 2024 18:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734029400;
	bh=ScQnI2Tiu7YwnbaIgWWsJamhTX9TTOQiO/w1w3aYwmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tiNIkCqILBPT3d+VVSQ+TuuM7bl+XuaQ0CJaH7gx2x/akQ0NajgmkrHbdRq8pxr39
	 lPHZze/PhhH2OpWRbbVXCweOLX8Mte0L83ekYXH7Jr8tFKtHeNCsglGnCJ+48LIRzL
	 o5l9NXZxo/rHxExQCknkANjsGmMz7wOLqik/SpbTA5VEzetUkZ6y/ekfK+HadXpGpA
	 w1buqkbSkFQlg/bNkNvyLAihAXiyAA4rvGIC0hMlZ0Pcf+z4XP/a4afdtlx+s6UF85
	 RoMc4aeaqv1VaLqfe/AjEsaqX114Ed9AHtvOVS6cR0zOy9xYRRaLMRDkcpm+8EfYdd
	 zoIbSP2HOB73A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E378ECE1653; Thu, 12 Dec 2024 10:49:59 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: [PATCH rcu 18/18] rcutorture: Use symbols for SRCU reader flavors
Date: Thu, 12 Dec 2024 10:49:57 -0800
Message-Id: <20241212184957.2127441-18-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <62e4d9a4-18ad-49b3-9656-23e17b78033f@paulmck-laptop>
References: <62e4d9a4-18ad-49b3-9656-23e17b78033f@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit converts rcutorture.c values for the reader_flavor module
parameter from hexadecimal to the SRCU_READ_FLAVOR_* C-preprocessor
macros.  The actual modprobe or kernel-boot-parameter values for
read_flavor must still be entered in hexadecimal.

Link: https://lore.kernel.org/all/c48c9dca-fe07-4833-acaa-28c827e5a79e@amd.com/

Suggested-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcu.h     |  6 ++++++
 include/linux/srcutree.h |  6 +-----
 kernel/rcu/rcutorture.c  | 14 +++++++-------
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 08339eb8a01c8..da8224d0f71c5 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -43,6 +43,12 @@ int init_srcu_struct(struct srcu_struct *ssp);
 #define __SRCU_DEP_MAP_INIT(srcu_name)
 #endif /* #else #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 
+/* Values for SRCU Tree srcu_data ->srcu_reader_flavor, but also used by rcutorture. */
+#define SRCU_READ_FLAVOR_NORMAL	0x1		// srcu_read_lock().
+#define SRCU_READ_FLAVOR_NMI	0x2		// srcu_read_lock_nmisafe().
+#define SRCU_READ_FLAVOR_LITE	0x4		// srcu_read_lock_lite().
+#define SRCU_READ_FLAVOR_ALL	0x7		// All of the above.
+
 #ifdef CONFIG_TINY_SRCU
 #include <linux/srcutiny.h>
 #elif defined(CONFIG_TREE_SRCU)
diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 490aeecc6bb47..80016bbed6725 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -26,6 +26,7 @@ struct srcu_data {
 	atomic_long_t srcu_lock_count[2];	/* Locks per CPU. */
 	atomic_long_t srcu_unlock_count[2];	/* Unlocks per CPU. */
 	int srcu_reader_flavor;			/* Reader flavor for srcu_struct structure? */
+						/* Values: SRCU_READ_FLAVOR_.*  */
 
 	/* Update-side state. */
 	spinlock_t __private lock ____cacheline_internodealigned_in_smp;
@@ -43,11 +44,6 @@ struct srcu_data {
 	struct srcu_struct *ssp;
 };
 
-/* Values for ->srcu_reader_flavor. */
-#define SRCU_READ_FLAVOR_NORMAL	0x1		// srcu_read_lock().
-#define SRCU_READ_FLAVOR_NMI	0x2		// srcu_read_lock_nmisafe().
-#define SRCU_READ_FLAVOR_LITE	0x4		// srcu_read_lock_lite().
-
 /*
  * Node in SRCU combining tree, similar in function to rcu_data.
  */
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 41b661bf000a7..d26fb1d33ed9a 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -121,7 +121,7 @@ torture_param(int, preempt_duration, 0, "Preemption duration (ms), zero to disab
 torture_param(int, preempt_interval, MSEC_PER_SEC, "Interval between preemptions (ms)");
 torture_param(int, read_exit_delay, 13, "Delay between read-then-exit episodes (s)");
 torture_param(int, read_exit_burst, 16, "# of read-then-exit bursts per episode, zero to disable");
-torture_param(int, reader_flavor, 0x1, "Reader flavors to use, one per bit.");
+torture_param(int, reader_flavor, SRCU_READ_FLAVOR_NORMAL, "Reader flavors to use, one per bit.");
 torture_param(int, shuffle_interval, 3, "Number of seconds between shuffles");
 torture_param(int, shutdown_secs, 0, "Shutdown time (s), <= zero to disable.");
 torture_param(int, stall_cpu, 0, "Stall duration (s), zero to disable.");
@@ -679,17 +679,17 @@ static int srcu_torture_read_lock(void)
 	int idx;
 	int ret = 0;
 
-	if ((reader_flavor & 0x1) || !(reader_flavor & 0x7)) {
+	if ((reader_flavor & SRCU_READ_FLAVOR_NORMAL) || !(reader_flavor & SRCU_READ_FLAVOR_ALL)) {
 		idx = srcu_read_lock(srcu_ctlp);
 		WARN_ON_ONCE(idx & ~0x1);
 		ret += idx;
 	}
-	if (reader_flavor & 0x2) {
+	if (reader_flavor & SRCU_READ_FLAVOR_NMI) {
 		idx = srcu_read_lock_nmisafe(srcu_ctlp);
 		WARN_ON_ONCE(idx & ~0x1);
 		ret += idx << 1;
 	}
-	if (reader_flavor & 0x4) {
+	if (reader_flavor & SRCU_READ_FLAVOR_LITE) {
 		idx = srcu_read_lock_lite(srcu_ctlp);
 		WARN_ON_ONCE(idx & ~0x1);
 		ret += idx << 2;
@@ -719,11 +719,11 @@ srcu_read_delay(struct torture_random_state *rrsp, struct rt_read_seg *rtrsp)
 static void srcu_torture_read_unlock(int idx)
 {
 	WARN_ON_ONCE((reader_flavor && (idx & ~reader_flavor)) || (!reader_flavor && (idx & ~0x1)));
-	if (reader_flavor & 0x4)
+	if (reader_flavor & SRCU_READ_FLAVOR_LITE)
 		srcu_read_unlock_lite(srcu_ctlp, (idx & 0x4) >> 2);
-	if (reader_flavor & 0x2)
+	if (reader_flavor & SRCU_READ_FLAVOR_NMI)
 		srcu_read_unlock_nmisafe(srcu_ctlp, (idx & 0x2) >> 1);
-	if ((reader_flavor & 0x1) || !(reader_flavor & 0x7))
+	if ((reader_flavor & SRCU_READ_FLAVOR_NORMAL) || !(reader_flavor & SRCU_READ_FLAVOR_ALL))
 		srcu_read_unlock(srcu_ctlp, idx & 0x1);
 }
 
-- 
2.40.1

