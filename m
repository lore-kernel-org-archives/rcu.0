Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD56299948
	for <rcu@vger.kernel.org>; Sun, 14 Dec 2025 10:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765707319; cv=none; b=G9TViIId/DBtaIcauftuptTqZisYxT7xRYi4UYIBm6s2JdVrWt/G5IcQsgjqUB7eMU9VEwJqPV8hXAV2a+xlXu1nav5ojMLcZ/mxk3vZGw8FyhJrjJu3rsxLOPy+uFLht/y7rXtkWKO6feSo2x4++GL2M91sxUEn8he1WToEJw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765707319; c=relaxed/simple;
	bh=xjqd878eeFZCgALnSgFxtTmJ2SEHSOjDdg0S1yWWP2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kXdHtgQQZ0bHnaH2mbKgPN78OsM3+SRkE72pmhH5y+YdxXsqnP1wwrXddAXknN3jLhGRS5ooSmK1Ue7Nkhme58tStpHvITT/cwYUXdWK4C6wl+DAW7adZ7wmClqMMNo6L9LcKwCwCx6HWLh4/Qe8ptdmtwfFhfyUYynj+4nb3FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z6a8Wrxb; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z6a8Wrxb"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765707305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ylV6FAzOdPNUm0jB7PShLpljCGUQxGCmSRzpgxLcUwI=;
	b=Z6a8Wrxb4Ea28E+FByd4e/UBr8SRHeg2PLdVDwpkL5aFec+uU4IjtheNeatOL3TzZ8Lo32
	F/vGl9jpc+63N9ie/7oWYDKDIXz8pGsoKVK9ZtD9FJHIN157vm1/M3TAwM/xNsA5L5GCs+
	RiTF6mDkH8rVj56a6pfkeZY0Q0eIjhs=
From: Zqiang <qiang.zhang@linux.dev>
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com
Cc: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	qiang.zhang@linux.dev
Subject: [PATCH v2] srcu: Use suitable gfp_flags for the init_srcu_struct_nodes()
Date: Sun, 14 Dec 2025 18:14:33 +0800
Message-ID: <20251214101433.126434-1-qiang.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

For use the init_srcu_struct*() to initialized srcu structure,
the srcu structure's->srcu_sup and sda use GFP_KERNEL flags to
allocate memory. similarly, if set SRCU_SIZING_INIT, the
srcu_sup's->node can still use GFP_KERNEL flags to allocate
memory, not need to use GFP_ATOMIC flags all the time.

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
---
 kernel/rcu/srcutree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index ea3f128de06f..c469c708fdd6 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -262,7 +262,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 	ssp->srcu_sup->srcu_gp_seq_needed_exp = SRCU_GP_SEQ_INITIAL_VAL;
 	ssp->srcu_sup->srcu_last_gp_end = ktime_get_mono_fast_ns();
 	if (READ_ONCE(ssp->srcu_sup->srcu_size_state) == SRCU_SIZE_SMALL && SRCU_SIZING_IS_INIT()) {
-		if (!init_srcu_struct_nodes(ssp, GFP_ATOMIC))
+		if (!init_srcu_struct_nodes(ssp, is_static ? GFP_ATOMIC : GFP_KERNEL))
 			goto err_free_sda;
 		WRITE_ONCE(ssp->srcu_sup->srcu_size_state, SRCU_SIZE_BIG);
 	}
-- 
2.48.1

