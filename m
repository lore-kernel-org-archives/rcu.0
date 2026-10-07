Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29904119F5;
	Wed,  7 Oct 2026 20:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791405916; cv=none; b=pB1zWbWXVmS1m3crBajcLfZpkBdKmDhNpcApDFIsCS4W0GlnCftKERVWgno5ZCULPBJ73seA5U6BnbIQTUWB/DHngM/E5DQBfbj+0Iu3xKRPX2MBLJIVMdqGOX3ezAvwPaxs+6Ts6COtWHj/IzsXqeLEdo1dl+3Q+ghwFZT68M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791405916; c=relaxed/simple;
	bh=xXfTzV1vDVtm8Rk1kjIbTQgHDgbmKU2dToP4kwfdcGo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=scjpSjGR3pldLf2CjohQ07CU5S4gZFsN+7L9oEEIEGpnkF28UEBG1EnNUoZJaph39fh6MXXELV0kTr+RoZcc+KC0NvcVYr3sEmsQMJB9ehZbuC82sxRA83PZq2XeuzXd1MPQbrjk5tmPfVfdnU1oIZyovgxLTonQKOiQl9RyFjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTQan2sy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTQan2sy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3B151F0089D;
	Wed,  7 Oct 2026 20:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791405913;
	bh=BWZL952mYyD29BPCpeWOSZK0WyZlsW743mT28mjCFk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZTQan2symxvprPjYkvvf5hnwffo3oTG1R+ecFHHYZrk3rjAaQ6r302hZ8bIx1d7Qq
	 8FbrXSmnFJKMoVxnEqLG0JLrLH9dl1787oIXLQRH6A/rUAQZ3Og7r7FXcO8wur3cSh
	 p8LmfkhKTQpoHG7KtUln9HQ4+5ZXle06SOGvw4mLHUnei3TphzNDhfeKAireGIKjXA
	 BNBc18zdEagquV3VdghsCY558z/49H6b1XgzkX72AgqfVisOAk3o2wIDD6TeAU0lsf
	 Vk+Ls7j4qyxSx6wOwFmsYSDkYzJmYOOfN43gLw9UWZ0stcFewshVGl1he7zUv1JxB+
	 Yktb0Y8t3J2eg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 311F4CE2724; Wed,  7 Oct 2026 13:45:13 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Bradley Morgan <brads@mainlining.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 06/10] rcu: Drop the private tick-internal.h include from tree.c
Date: Wed,  7 Oct 2026 13:45:07 -0700
Message-Id: <20261007204511.1982646-6-paulmck@kernel.org>
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

From: Bradley Morgan <brads@mainlining.org>

Nothing in the tree.c translation unit uses anything from the
private timekeeping header ../time/tick-internal.h, included
since commit 48d07c04b4cc ("rcu: Enable elimination of
Tree-RCU softirq processing"). The tick symbols RCU uses,
tick_dep_set(), tick_dep_clear(), their _cpu and _task
variants, tick_nohz_full_cpu() and TICK_DEP_BIT_RCU, are all
declared in the public linux/tick.h, which tree.c already
includes.

Drop the include.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 96848fc1f02b8..338737b9781cb 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -64,7 +64,6 @@
 #include <linux/mm.h>
 #include <linux/kasan.h>
 #include <linux/context_tracking.h>
-#include "../time/tick-internal.h"
 
 #include "tree.h"
 #include "rcu.h"
-- 
2.40.1

