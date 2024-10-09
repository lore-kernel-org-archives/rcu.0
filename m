Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F401E133D;
	Wed,  9 Oct 2024 18:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728496847; cv=none; b=e2FOnXyXXvLJKAGKGxDPeJXqA0rNFXBxzadbVf/FqB+soKdM3p4JV73IQTFDhKJJXKYcRyXQq8THvYDX3wgFkzMN/4G4JZ8SUFVe7Sa54nvjwRFanKPgnQvXZ2c+U6o+JiyNnJad221vwBZ/uCrRk+/go6qPoJTHKt6FofvbsM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728496847; c=relaxed/simple;
	bh=BE0VZPoXza7bZDtTDVSPUqFCnHF2OgmKDYBLxOWLPvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uhEMFH/9Q3KPnTlJQ9cY9CKt5Q/PO+StT1JzU1nep8U8NhounOoEUow2AxNUq4ZAw9tojNCXGqqsETQ9xJz7gXDkhWamrRfNscmTxHoE8FU8fcAKbcL/JXHbm4FZXKntG5GUWxfRGOVa2bJnUMhfv7Vs2PrimhQkv8DFiA6kA88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSgb6JLC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSgb6JLC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2241FC4CED7;
	Wed,  9 Oct 2024 18:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728496847;
	bh=BE0VZPoXza7bZDtTDVSPUqFCnHF2OgmKDYBLxOWLPvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cSgb6JLCD6/eZ6VcL/J+ttiZoKnA5InYMWxGf6IZNG58AcF56ux1pTX+3yxV0ETPm
	 mAMIJyl5Vn3EIprs4C5J27iNr1aQGVFo/pFLTkW//STjNPDAl0w0Eaiu4FR/UfBg4k
	 n673YC9AU7ubzxYb+cy7MHGwy8kTpR3HMgNEFpYozYuTRJZfIGZXsnny6rPvtsITGq
	 on3guSxt3/Y3UC6wXnA6GqVEcdudq0N2sJxBHRzxt3UEO16gS73IZgartBEjypvBqI
	 AHCd/xZJNtNmO14X/nWysa+8krybY+HOZfJajf/OpnBghzZBgdVHLcJmZJcrL2rri2
	 LQ5VGRda2LrnA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 790CCCE1290; Wed,  9 Oct 2024 11:00:46 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: frederic@kernel.org,
	rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 7/7] rcu-tasks: Remove open-coded one-byte cmpxchg() emulation
Date: Wed,  9 Oct 2024 11:00:45 -0700
Message-Id: <20241009180045.777721-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2dc6de07-374d-44da-82e9-fa9d9c516b46@paulmck-laptop>
References: <2dc6de07-374d-44da-82e9-fa9d9c516b46@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit removes the open-coded one-byte cmpxchg() emulation from
rcu_trc_cmpxchg_need_qs(), replacing it with just cmpxchg() given the
latter's new-found ability to handle single-byte arguments across all
architectures.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index dd9730fd44fbe..c789d994e7ebc 100644
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
2.40.1

