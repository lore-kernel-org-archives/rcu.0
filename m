Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6CB204F96;
	Wed,  6 Nov 2024 14:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730905176; cv=none; b=bSPBbjEI51dSr/PS5+9Qxx98z8lz3it54QfFiJdtGPusrzMuAZ+zmkAzeBZyr64ikQr6yc3kZe+1t01OkuRlMwmX2N6xQ3mSpNWD7LRjkAWEvEHYB+oEbYGkr3lqPP8997QRLLGidGgHn1NZR5cSAD0qPODXSmetl2slLDH6NYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730905176; c=relaxed/simple;
	bh=mtdPPDok0LE6Co+ZnXJpGWxQCPVzxrwR26bqD2LgnTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PESlHCKa5WiYPMlEkoY130LRo9BLlM7b1p2YZGRCAbW2ZAym8jre3u+ibMiMgJmOlJd4CZwjw9GTSvlZ/EWzc5kkXH0ENuiATCwOYNyICtJWUydFB81X/qXg/07pfD46Qzaa2Y/XQtEyOUECNYxau38/+59/H73fRIAqqmVJTCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBoMPArA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBoMPArA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B796C4CECD;
	Wed,  6 Nov 2024 14:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730905175;
	bh=mtdPPDok0LE6Co+ZnXJpGWxQCPVzxrwR26bqD2LgnTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NBoMPArArXziFiODkWMo3Q4cjM0j3yc+9XzDF5qPCwia2cAz4I92VHl4TL1Ufah9/
	 Zs1ys+mghx86xoubxR+0D3ljwHezb6YFMR91K7A7WPcvt50jLTeV0saO0TgtkcfORw
	 bmmb/pVjXz3RL5IOKG78967AuV7L9+L21SPBQXeeTif/b0c9IlEzZIGfoSAq8VqNu9
	 TKvrBDj2a/QDQetwXcGbPhwwPccJXPm0JJyA991ebL4Dx8V8/B/2+lNnjd3/TvDrSm
	 Wkyjjt2jnFxJp1eQRKIsWtH8Sl5knTatY7dHdyzRX9BusW5BKPTo6MIW6lVFO+GbTN
	 xuvh8vT0xLXLg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 6/8] rcu-tasks: Remove open-coded one-byte cmpxchg() emulation
Date: Wed,  6 Nov 2024 15:59:09 +0100
Message-ID: <20241106145911.35503-7-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241106145911.35503-1-frederic@kernel.org>
References: <20241106145911.35503-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit removes the open-coded one-byte cmpxchg() emulation from
rcu_trc_cmpxchg_need_qs(), replacing it with just cmpxchg() given the
latter's new-found ability to handle single-byte arguments across all
architectures.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tasks.h | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index dd9730fd44fb..c789d994e7eb 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1541,22 +1541,7 @@ static void rcu_st_need_qs(struct task_struct *t, u8 v)
  */
 u8 rcu_trc_cmpxchg_need_qs(struct task_struct *t, u8 old, u8 new)
 {
-	union rcu_special ret;
-	union rcu_special trs_old = READ_ONCE(t->trc_reader_special);
-	union rcu_special trs_new = trs_old;
-
-	if (trs_old.b.need_qs != old)
-		return trs_old.b.need_qs;
-	trs_new.b.need_qs = new;
-
-	// Although cmpxchg() appears to KCSAN to update all four bytes,
-	// only the .b.need_qs byte actually changes.
-	instrument_atomic_read_write(&t->trc_reader_special.b.need_qs,
-				     sizeof(t->trc_reader_special.b.need_qs));
-	// Avoid false-positive KCSAN failures.
-	ret.s = data_race(cmpxchg(&t->trc_reader_special.s, trs_old.s, trs_new.s));
-
-	return ret.b.need_qs;
+	return cmpxchg(&t->trc_reader_special.b.need_qs, old, new);
 }
 EXPORT_SYMBOL_GPL(rcu_trc_cmpxchg_need_qs);
 
-- 
2.46.0

