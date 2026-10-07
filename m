Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A1A3DAAD6;
	Wed,  7 Oct 2026 20:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791405916; cv=none; b=S8en/HZ0wRbcloKwvHbBh3NLxqENKW/FV2svoKr2JZGGqoPZyXznYzG3FXxkpUDM+mYBxUdlqBHXxTKqT9rXtektZj7wLk2RgGlfeCsMdU35KppcIgmrFMBlvBNSUqIYXlXqEa5Ltm3KqLfJo7lyRp2NYCeUvGtCejy6Qs4fboM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791405916; c=relaxed/simple;
	bh=8LpJsrtXdYO8EiB729s4dbWWphsVhR1OxJ/04Up9+HU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gI4fXjSsyrWatnCD+wqZuRnLQmx9BF89uc4g79QbzI1NwkmVEmT5RSlHZS+eauLtTcC2s3zFDaw0rkScHaEoRdyB6TI75YNVTp+8LU8STsmqp4r94EwrBNl5m6Yxyz9T7WZsdet7Ry/CNlETKd9MGHy7wKQJN3TdTJTvQ5Z4SIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwJAORjJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwJAORjJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F0D1F0089C;
	Wed,  7 Oct 2026 20:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791405913;
	bh=av7HPMg0FOA+6BLrURZ0j95m8qlcOOsH3TbSzrP39Qo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hwJAORjJpY+zsO+QQrRkodry1Qb8M3CB1olDkShEc4+PGmTdWsICo5HbyQ+vSRBxE
	 lYRoIlef/SyyyY/Z/8bHzO9kdb6wU1xO+SsZatcNak1ciWAWhMAFWwrEM3aKkuNSdf
	 iGHDEEQqe/VfhhmaMnYg4lyRxd2dkmYOn8qRpqq8/g3WuwXoBzsXy3JWs4Iz2MfVbV
	 2KtpAYWAHBMmxkFfOxM+qkJqpK3TDCQBdE2hWv/7uixjhbd0H6RGfY4qapQsuzLUwW
	 5I7lxW4gRgQufNt6l2s5kf9/FCbR+ZBxseBPdZaWg13RaTPtDbbwAnjWFSp+4ndHgU
	 x3QaBdjWui2gQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2EAFFCE26CA; Wed,  7 Oct 2026 13:45:13 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Hemanth Selam <hemanth.selam@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 05/10] rcu: Fix typo "upto" in comment
Date: Wed,  7 Oct 2026 13:45:06 -0700
Message-Id: <20261007204511.1982646-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <df33a614-9c3d-423d-9d31-b1846cb1f1d6@paulmck-laptop>
References: <df33a614-9c3d-423d-9d31-b1846cb1f1d6@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hemanth Selam <hemanth.selam@gmail.com>

Correct "upto" to "up to", reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index ed204b3f4b844..01f19bb17dd6d 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -624,7 +624,7 @@ module_param(srcu_retry_check_delay, ulong, 0444);
 #define SRCU_UL_CLAMP_LO(val, low)	((val) > (low) ? (val) : (low))
 #define SRCU_UL_CLAMP_HI(val, high)	((val) < (high) ? (val) : (high))
 #define SRCU_UL_CLAMP(val, low, high)	SRCU_UL_CLAMP_HI(SRCU_UL_CLAMP_LO((val), (low)), (high))
-// per-GP-phase no-delay instances adjusted to allow non-sleeping poll upto
+// per-GP-phase no-delay instances adjusted to allow non-sleeping poll up to
 // one jiffies time duration. Mult by 2 is done to factor in the srcu_get_delay()
 // called from process_srcu().
 #define SRCU_DEFAULT_MAX_NODELAY_PHASE_ADJUSTED	\
-- 
2.40.1

