Received: from mta0.migadu.com (out-16.mta0.migadu.com [91.218.175.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A0A2DECBF
	for <rcu@vger.kernel.org>; Sat, 10 Oct 2026 08:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791621078; cv=none; b=VasdcPMn+TA4DS4sv9S+CTjf9zZFJp2V+1xW20mDdNVLaU0IPRsCjH1HYfaNqfuJWA7A/KLZWf0KTIxEk1kgRdH1HQqJYtvjK9B7jSprZns4QR155dZHeBIuCmunw6fqtEX5dqkQ3GhfFOkGTW9MPT4jRlo69rzTS6Xjpv3L8Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791621078; c=relaxed/simple;
	bh=+aBw/Uh/lYMnXV37O+Qnv3JXe2Lmtk72St4UxUEy0+U=;
	h=From:To:Cc:Subject:Date:Message-Id; b=lfbyYXQGYFtKzUMJyrVpIW7s2S/QUlT6avzdhuHhI+syQzR4AT4aw4eB8TMxeOfwrVSQUduos10nB/mxhWsTdHybB7RvbFUSFEX61MMdFHz5igBtCpOy6eI321LLdRxJ0BIkjq2rkg6vlns098RvVOtPV2cbcIQ1J4tddGgAtGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=txxI/iGQ; arc=none smtp.client-ip=91.218.175.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="txxI/iGQ"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=+aBw/Uh/lYMnXV37O+Qnv3JXe2Lmtk72St4UxUEy0+U=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791621074; v=1; x=1792225874;
 b=txxI/iGQY2OnFxmZVrfWemJkF4j2hAO/K86egegRYH2HUZ4G0ISejSWjS0fAT6brbSAt13i9
 jQgCaEQfa0cJhWNHR5uNFaEultj7fvafGVtNPol3tw74JkRt8f5zcyDhdwgF2sZINIvSmVtxwmC
 91wk++FGfz2y5l2gfSxJfW5E=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0b0d23bfa1f9d4e9;
	Sat, 10 Oct 2026 08:31:13 +0000
X-Mizu-Trace-ID: 0b0d23bfa1f9d4e9
X-Migadu-Flow: FLOW_OUT
From: Zqiang <qiang.zhang@linux.dev>
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	urezki@gmail.com,
	boqun@kernel.org
Cc: qiang.zhang@linux.dev,
	kunwu.chan@gmail.com,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tools/rcu: Add new APIs to rcu-updaters.sh
Date: Sat, 10 Oct 2026 16:31:07 +0800
Message-Id: <20261010083107.15086-1-qiang.zhang@linux.dev>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>

The following commit introduces some new APIs:

commit 'dab06d6f9379 ("srcutree: Add an atomic Tree SRCU")'
commit '8df13f01608e ("rcu: Add full-sized polling for cond_sync_exp_full()")'
commit 'd96c52fe4907 (rcu: Add polled expedited grace-period primitives)'

synchronize_srcu_atomic(), cond_synchronize_rcu_expedited() and
cond_synchronize_rcu_expedited_full().

Sample output when running rcutorture:

@counts[synchronize_srcu]: 48
@counts[synchronize_rcu_expedited]: 74
@counts[synchronize_rcu]: 102
@counts[poll_state_synchronize_rcu_full]: 443
@counts[call_rcu]: 2498
@counts[synchronize_srcu_atomic]: 8717
@counts[poll_state_synchronize_srcu]: 14849

@counts[call_srcu]: 22
@counts[synchronize_rcu]: 103
@counts[start_poll_synchronize_rcu]: 1093
@counts[cond_synchronize_rcu_expedited]: 5339
@counts[cond_synchronize_rcu_expedited_full]: 5375
@counts[synchronize_rcu_expedited]: 8134
@counts[get_state_synchronize_rcu_full]: 17248
@counts[get_state_synchronize_rcu]: 17266
@counts[call_rcu]: 119168

This commit therefore add thems to rcu-updaters.sh script.

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
---
 tools/rcu/rcu-updaters.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/rcu/rcu-updaters.sh b/tools/rcu/rcu-updaters.sh
index 8a5df3f22550..a0f03a144f6a 100755
--- a/tools/rcu/rcu-updaters.sh
+++ b/tools/rcu/rcu-updaters.sh
@@ -34,6 +34,7 @@ bpftrace -e 'kprobe:kvfree_call_rcu,
 	     kprobe:synchronize_rcu_tasks_trace,
 	     kprobe:synchronize_srcu,
 	     kprobe:synchronize_srcu_expedited,
+	     kprobe:synchronize_srcu_atomic,
 	     kprobe:get_state_synchronize_rcu,
 	     kprobe:get_state_synchronize_rcu_full,
 	     kprobe:start_poll_synchronize_rcu,
@@ -44,6 +45,8 @@ bpftrace -e 'kprobe:kvfree_call_rcu,
 	     kprobe:poll_state_synchronize_rcu_full,
 	     kprobe:cond_synchronize_rcu,
 	     kprobe:cond_synchronize_rcu_full,
+	     kprobe:cond_synchronize_rcu_expedited,
+	     kprobe:cond_synchronize_rcu_expedited_full,
 	     kprobe:start_poll_synchronize_srcu,
 	     kprobe:poll_state_synchronize_srcu,
 	     kprobe:rcu_gp_init
-- 
2.17.1

