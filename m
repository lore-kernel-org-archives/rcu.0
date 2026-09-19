Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A475324B0A;
	Sat, 19 Sep 2026 00:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789776067; cv=none; b=hNxibTXuPHGAn9x5uBcrsXNEeh7gvehS2N7p7XbUBI+g0sGlAn5V9E18kCZXq41jZJeehjjKvdM8ZPOi+2jJ1NWy4qJJgMKmAFl21eNK8MxorZayaCdp8/rVlYcG3dYDnFcgbAiqc8rUePS0JAo7Fld7sHxm5Uptv+RBiorgoGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789776067; c=relaxed/simple;
	bh=JMzjlih0MjdiKv8hzDkJ8uuDMgzreg7ytdngYHiZucM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pD5c02IpNS3vOepPvRdXcpn83oaiP12CDxdZ2ehWTiAzlxmSx47cqsSXDtpQh1fGuTRxYnL37bYEcvSZJTKA35PCctet9VsVeS04z+GNU2+aVpnvxJg0NJInSvo6x/S81llvJWSYlM8pSTOEiaBTnVg4lDHWCqxq7BzfQqtvBiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=maVYbSLI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="maVYbSLI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7920D1F00A05;
	Sat, 19 Sep 2026 00:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789776060;
	bh=3yLandPwL21bNmWKJBESanpri9HwoYYRFq4Rerc3USU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=maVYbSLI7U/2fo6VenKcK2XYw/eipKEFCv06wrbI4ifQu77BWBqCKwp61vnwJDrLa
	 IO3MZ+DHElyvrGsIdepxLjx5tyqQJFCkw0TRL9x5V6GRCHiCcvCCTawDxpaPLS62+x
	 P6Y4eDX5GhGJ3f+XTjUq160Evhf/SBgUwxW/L0r9f08b/QoTMLTbx9pnsyoz0X223q
	 nDFg9Z3VwCrT4e7EqrT21qPLRv3mDoyEz0ZmGMux5mZ2pcMLyWiU/qpTyEu+6Q/SqY
	 sKoppGwn3yg2wijynfccjfv1624xHC5pHrTJLqvfh8tJUbOhx0wnPiBJzJ4gr9j68x
	 yEclgftECW6TQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 98478CE0F2C; Fri, 18 Sep 2026 17:00:59 -0700 (PDT)
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
	kernel test robot <yi1.lai@intel.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 27/28] hazptr: handle NULL address in hazptr_detach
Date: Fri, 18 Sep 2026 17:00:55 -0700
Message-Id: <20260919000056.3132131-27-paulmck@kernel.org>
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

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

When hazptr_acquire loads a NULL pointer, it sets:

- slot_item->slot.addr = NULL,
- slot_item->ctx.ctx = ctx
- ctx->slot = slot

And it returns NULL.

Then hazptr_detach is called on this ctx, it will act on the ctx as if
needed to be promoted to backup slot, even though it has a NULL addr.

Looking at what hazptr_note_context_switch() does before promoting
to backup slot, it checks for a NULL slot->addr, which is exactly
what is missing from hazptr_detach.

With this in place there would be no need to explicitly check the
hazptr_acquire() return value before calling hazptr_detach().

hazptr_release() has a early return check for NULL addr as well, so it
makes sense that detach does an early return (no-op) similarly.

Fixes: 6357ec235c59 ("hazptrtorture: Fix hazptr ownership issue")
Reported-by: kernel test robot <yi1.lai@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202608130915.62b53936-lkp@intel.com
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reviewed-by: Bradley Morgan <brads@mainlining.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>
Cc: Bradley Morgan <brads@mainlining.org>
Cc: <rcu@vger.kernel.org>
Cc: <lkmm@lists.linux.dev>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: kernel test robot <yi1.lai@intel.com>
---
 include/linux/hazptr.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/hazptr.h b/include/linux/hazptr.h
index 43122c5673bd..d1670121947a 100644
--- a/include/linux/hazptr.h
+++ b/include/linux/hazptr.h
@@ -160,10 +160,12 @@ void hazptr_detach(struct hazptr_ctx *ctx)
 	struct hazptr_slot *slot;
 
 	guard(preempt)();
+	slot = ctx->slot;
+	if (!slot->addr)
+		return;
 #ifdef CONFIG_HAZPTR_DEBUG
 	ctx->detach_task = ctx->detach_cpu = true;
 #endif
-	slot = ctx->slot;
 	if (unlikely(hazptr_slot_is_backup(ctx, slot)))
 		return;
 	hazptr_promote_to_backup_slot(ctx, slot);
-- 
2.40.1

