Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933BA298CC7;
	Mon,  3 Nov 2025 07:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762154352; cv=none; b=j6Rgryl1+JifpIPqRwxeu/e5D1STbCa1u76mS4/LxeW0IyVrbWYNpEiZFk39JPOOrpaD+XZZBGY36jpAQA8xc3txp3mkc/ywlpJWnY6Nb7zTdonUN9o8IWDqeqZQyKqDclElJyTRKSjGSOk1VvRxYiXwFI9wGhQFsAN0VKl+khI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762154352; c=relaxed/simple;
	bh=d+Yn3i1lzgRjb0Q5CeMOtXQwj+BmYuzfNnrAziwjsOA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YeFu8O+4AXbBNkShijA4zXlyeyVV/oPuUFKlp3lZpt4bbKvEmbWRQZzk4pphp1drHNH7oIC/zTcmMBpKoc3MToUwXJrk4dkZmBtN3f8a9dwHmOVkAl6y/Uney9gCvPzK/iLKIrpFJsDUb4vvQaRN2CMzfyUCZKEx64zOL7cKcFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBa2rhcF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBa2rhcF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36172C4CEFD;
	Mon,  3 Nov 2025 07:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762154352;
	bh=d+Yn3i1lzgRjb0Q5CeMOtXQwj+BmYuzfNnrAziwjsOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gBa2rhcFvKwFNpcXBJrF+Z0Q2utbsvC+ckcki/Fk/XaUl816LJjpLORp38k11FxS4
	 6cIX8pVEDaEKtrdmEjdRqnipQKoEOkmm6WSsWGHpMJDZyzSqIMZAZif2R3dchUtsYk
	 vVvyfmGCygm+wcqOq2Pgz5utpUHvatRme9iuSfrzl6GNHe6p1VulqWelhItiMscTZ8
	 FZfuIitkKXA5uPexsT2eVJ32T6w7tTxSfk+0IW7aXXzZuPSQD2vt3g4z/Q1IJQFOmT
	 o2hhInf6pvZc5UeSzICOavGUMVqtZhbT0b8Ij+EyHkG4hd8Eo/NuJlsN0E22E5fLW8
	 f/PYNWZbGb5BA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 019E0CE13CA; Sun,  2 Nov 2025 14:49:50 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 7/8] refscale: Do not diable interrupts for tests involving local_bh_enable()
Date: Sun,  2 Nov 2025 14:49:47 -0800
Message-Id: <20251102224948.3906224-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <19fae851-0c49-43d2-9bbf-913424641ff4@paulmck-laptop>
References: <19fae851-0c49-43d2-9bbf-913424641ff4@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some kernel configurations prohibit invoking local_bh_enable() while
interrupts are disabled.  However, refscale disables interrupts to reduce
OS noise during the tests, which results in splats.  This commit therefore
adds an ->enable_irqs flag to the ref_scale_ops structure, and refrains
from disabling interrupts when that flag is set.  This flag is set for
the "bh" and "incpercpubh" scale_type module-parameter values.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refscale.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 2b247355de40..7429ec9f0092 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -136,6 +136,7 @@ struct ref_scale_ops {
 	void (*cleanup)(void);
 	void (*readsection)(const int nloops);
 	void (*delaysection)(const int nloops, const int udl, const int ndl);
+	bool enable_irqs;
 	const char *name;
 };
 
@@ -495,6 +496,7 @@ static const struct ref_scale_ops incpercpubh_ops = {
 	.init		= rcu_sync_scale_init,
 	.readsection	= ref_incpercpubh_section,
 	.delaysection	= ref_incpercpubh_delay_section,
+	.enable_irqs	= true,
 	.name		= "incpercpubh"
 };
 
@@ -872,6 +874,7 @@ static void ref_bh_delay_section(const int nloops, const int udl, const int ndl)
 static const struct ref_scale_ops bh_ops = {
 	.readsection	= ref_bh_section,
 	.delaysection	= ref_bh_delay_section,
+	.enable_irqs	= true,
 	.name		= "bh"
 };
 
@@ -1234,15 +1237,18 @@ ref_scale_reader(void *arg)
 	if (!atomic_dec_return(&n_warmedup))
 		while (atomic_read_acquire(&n_warmedup))
 			rcu_scale_one_reader();
-	// Also keep interrupts disabled.  This also has the effect
-	// of preventing entries into slow path for rcu_read_unlock().
-	local_irq_save(flags);
+	// Also keep interrupts disabled when it is safe to do so, which
+	// it is not for local_bh_enable().  This also has the effect of
+	// preventing entries into slow path for rcu_read_unlock().
+	if (!cur_ops->enable_irqs)
+		local_irq_save(flags);
 	start = ktime_get_mono_fast_ns();
 
 	rcu_scale_one_reader();
 
 	duration = ktime_get_mono_fast_ns() - start;
-	local_irq_restore(flags);
+	if (!cur_ops->enable_irqs)
+		local_irq_restore(flags);
 
 	rt->last_duration_ns = WARN_ON_ONCE(duration < 0) ? 0 : duration;
 	// To reduce runtime-skew noise, do maintain-load invocations until
-- 
2.40.1

