Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D39D2F7EE9;
	Sat, 19 Sep 2026 00:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789777746; cv=none; b=CwA0zqyc1NvuzUPnuA8r7AWsa01hyyp8cg4eNuwFvrUkInkdTRfLifOp8fiq4r8/aWFJOmUyPK5sL3PqgFaEnHm/vW0K5gfAFrbEr6b1EikVclz4jieJnL/H97ynaigCDl0CGJ4IEM+kx2/pP135GVH7XGnAnLUfdFuQuipWUD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789777746; c=relaxed/simple;
	bh=fLALTx4M9S9CVaAKkup4u/TZSyLZ1BEF/G9ECyv8Y4c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FASkE5c7MiVoR8Rp1dhNPy7jwDYiZ6S7ziaW41xl8Mn9nQdxe44onO8btnXGV46v7lSsngQb22vZIuvHo8vh584hyeUQRNNfqTjFXTdKPlVTzOJR8551WXpD7FEDG+BV/tvdL/cWZj8c9hKkqCKOhDbFRUusZ8+Z6YRGJP5NWew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RyuyYi1C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RyuyYi1C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C26801F0089F;
	Sat, 19 Sep 2026 00:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789777741;
	bh=TACMRejCPDhtXToM+8XpnHSGuigYkCvPM7LCQenAW/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RyuyYi1Cat4GQjsH/xcmDmZVOJPzy8P2GRGtS9jW/zgx/lyZbXIjoMqK1v4r7So34
	 9hGy3uHeBhHtoRezHUiCgQ+23tZK7UCOGHS8KagaY5i6T5Gaj56xLat4YC4Cx+4PAu
	 crexQ+Cp59zVne2kqtYieKjzKPxYbb39xX57m9uRIruStOztOLauVhJmbuZ3RZQZAz
	 liVtarJfnecZVRZwcaPw2AEw/PFTOXjv5RZdkUg9MGH4pQlemCTmYwZDWaXMQWvU9E
	 emu/rm5wEKZq+oOo4ldBpWbYmmwigMI18TTugH2ClNiLERK5Lyy1BXuB0tC20IY+6/
	 QSGbyXoIC7Ydw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5530DCE1854; Fri, 18 Sep 2026 17:29:01 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Bradley Morgan <brads@mainlining.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 6/9] rcu: Drop the private tick-internal.h include from tree.c
Date: Fri, 18 Sep 2026 17:28:57 -0700
Message-Id: <20260919002900.3134117-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <7dc2d858-44cc-4efa-8e94-1fe27d691f2b@paulmck-laptop>
References: <7dc2d858-44cc-4efa-8e94-1fe27d691f2b@paulmck-laptop>
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
index 96848fc1f02b..338737b9781c 100644
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

