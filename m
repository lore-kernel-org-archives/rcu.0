Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91833EC2FF;
	Wed,  7 Oct 2026 20:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791406767; cv=none; b=uHzXp92kXmMaWV0q3TaggGjZ/mVSeEFdYPrL1oxfCEuAzeYOiUew6Mu5fqtj/9NDjOGfOtW9sMAfaoNueNlMdt5h2U6elNXQaVZp7UinD0uTkxYOfIRoUamE+kl4BKu+VGkV4VRLedA/GwtBEYMwfxdlBM99gVTG8ODR+OeaIow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791406767; c=relaxed/simple;
	bh=osjmcsVIUAzHvaXOC1bwpXM81DsYJa3uVS2Ga+Nkcmk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Px1/9Y22MTIkdbZRUZxv211kY9m+9y5BFx3pmSnv/ZtG2DTTkiTUoeIAM0QCXs5cuRTSUGPws8qJSSKUwwmJ57pDGc1mZeBp8/pj6h51Eirn50w0DCuSx5ldT/I7camQOQE4q6R6rstOM4PhQi10ecwjCUnwEzmzQAC80MX9AH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Efw7htTk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Efw7htTk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE021F0089B;
	Wed,  7 Oct 2026 20:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791406765;
	bh=k9FdsTLoKr9msJLFS131MIyb8vGvd62fmsv2S4aH5jI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Efw7htTkckHqfQiJlcAgaZKqox3DH1Qgy+pLjN8bMSJmszEnI6+P7z9d6fB6Gq2lR
	 jz5/1nUj3tvTYKU2aNTs9aav7hKfD85IsOrvA3HfMEkdpxKUGIZgmhqyXF8faw2LwK
	 iMf/duoPe0FZrFggauPtlRyOL/2n87v8aLK1ArIvdrvrxwHom8WdK/7SrmlRCOYVG8
	 0/p0Kb8sZsRGoCg7eDFM2hb3HlzZF4w88OVOX7K0lCygIw/IpJorja2A9cvFUpYb9o
	 gFhmG8FY66kzCE5nXGBej96VTQyrLZ6ua1cY+apO7dfs622BwrzzKko27uyadYy1mN
	 vDROzc3xEFjgQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 26340CE2744; Wed,  7 Oct 2026 13:59:25 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 09/21] srcutree: Warn if Tiny SRCU readers are preempted
Date: Wed,  7 Oct 2026 13:59:12 -0700
Message-Id: <20261007205924.1983367-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <546c81a7-f677-4d8e-a304-746b227058b0@paulmck-laptop>
References: <546c81a7-f677-4d8e-a304-746b227058b0@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fastpath of synchronize_srcu_atomic() should always be taken
because readers always disable preemption.  Therefore, the fact that
synchronize_srcu_atomic() is running at all should mean that all readers
have ended.

But there are always bugs.  And responding to a usage bug with a
too-short SRCU grace period, and thus possibly corrupting memory
is at best a sadistic response so such a bug.  For this reason,
synchronize_srcu_atomic() explicitly waits for readers.  Except that
it does so silently, possibly failing to flag this bug.  This commit
therefore adds a splat if synchronize_srcu_atomic() fails to take the
early exit.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutiny.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index 08e089e3e969e..a31398def0b18 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -375,6 +375,14 @@ void synchronize_srcu_atomic(struct srcu_struct *ssp)
 		return;
 	}
 
+	// Because readers disable preemption, we should never get here.
+	// However, a splat and some spinning is usually preferable to
+	// memory corruption due to a too-short grace period.  There is
+	// the possibility that this will hang if the preempted reader is
+	// not looked upon favorably by the scheduler, but this is still
+	// preferable to memory corruption.
+	WARN_ON_ONCE(1);
+
 	// Wait to drive a grace period or for someone else to do it
 	// for us while we are lazily preempted.
 	while (ssp->srcu_atomic_gp_flag) {
-- 
2.40.1

