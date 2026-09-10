Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EE655C1AC;
	Thu, 10 Sep 2026 17:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789061170; cv=none; b=LECIGu06i6MoEBMQ7nv1Obd2Ixcfh9xe7XnMlv/x4cOtwPLdAOGuhBMe9ZhL74ETVFflRQfxJs82rNWgDX/OZzs0oFezVJEPKVNVRslsYxHg59Hz1nCmqDLVdzsU/ZptUh9Eco8Kbm2fNN9kmC/O6i8op6/S5r7LXId6ZaXmaEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789061170; c=relaxed/simple;
	bh=awh0q99JqWAY45skQrLJg5h5X/6YZWvnw8+tm6oFCEY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g2wKmXST2uWa6lMcJgVu3K3Cv1yFnBux1BUhs35H5/v2X7QZU1VsdYFuv6+C26SFPcdRNn7zslbjeHv7BCDvA+vt1w4RPCsH1Q30WPnKucJ7x6WNXNG5Mvq9h/XAxeu5voexNJ9oHEs8L+hsNXLCpyDPNS1e/dNz9V9EJAPSpdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=gKboDN1T; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=VIhX9AkF; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="gKboDN1T";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="VIhX9AkF"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1789061142; bh=Y5g57X2n9/Mk8YtiUyLef82
	BOGdDfW6HmB5wMMysl54=; b=gKboDN1T59I8ukA1PPMwHKNvTWORqEQfKYEai4QpGhORfuCGtC
	0l4uXlFqkMxhjNxv5GT4kxBM/VAXPqsIEDvHagySOm/AhWfdq2VDKRJ3JSwfRMAim5YvSCsqZy/
	5H1YV0DvIiKo8+WSnTYCzgwVKt0vqmg6ylUUDpzHgx68dPjW64Iv0p1vjb3pmWzkeczlRUiN32V
	HZnKqHhYgL21qmacue+92T3HfYcJLmZDgyK6B+q99H8NNeAu8WOBmXGrw0lu6tb7CheEV5yps5S
	FhDbttvVLNh0cmNYd+Yf2aO2pOSuxet8ruMvPQLIiWPdqev+4vcbvYrYo+evI+GSUSA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1789061142; bh=Y5g57X2n9/Mk8YtiUyLef82
	BOGdDfW6HmB5wMMysl54=; b=VIhX9AkFbvamPUBOpeF5Ofl9ij/QLJ2jHsrhkqILtLDUJRqwgW
	LDGCxpk2cLpnjETIztWOGoCJUKm9zBpEinAg==;
From: Bradley Morgan <brads@mainlining.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	josh@joshtriplett.org,
	boqun@kernel.org,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	brads@mainlining.org
Subject: [PATCH] rcu: Drop the private tick-internal.h include from tree.c
Date: Thu, 10 Sep 2026 17:25:37 +0000
Message-ID: <20260910172537.6562-1-brads@mainlining.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
2.47.3

