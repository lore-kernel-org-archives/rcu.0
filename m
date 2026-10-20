Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792489758;
	b=Aj3c1Q6+YSNLrVjaRZ75bppidzM9kj29IUENhFC/9mZV0xvxY4ZbOJunJcxcxzkESkKK
	 kRW8JUkW9YMzLSEKKx3MMb2YM+rv3dmUaRnMIIVfjH27eBlPzCe3n5ZmIXMY/evw/3UoG
	 5oKjn3+WfilLcKDUq++USrPHxkOC1X+I+aeqdw0lbSTKdodID/S1gm0SXMkKgc66bOJx1
	 +lLr06H//SZtcOo5ks465hUJDPPVatuqKy53HD8GhIZeRq8ZmuNrQtLX1Dlqyjt6g/RXq
	 8psXeL376kDsNPWGUqKHlHIuGR/V7WLBVPmWlKwyIIvAizKBviRLVp/3M83DlqC4+sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792489758;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer;
	bh=hXWl60ZM47k49mNCyZREEqCqJyMP3dxlhN2Msqth25M=;
	b=iznENXVJUd9PRFsBRumzP0jzZrJbm4DYFi7DaB1gG0SpGRbKQv8i2mcKlWc2jS0jj+Du
	 Kh/pi8+QB4Dh7tKbo08QIBMZuxLMbt8TpkRVpMVHEXsg4ogaTwEdBuIfvegFAFQcHZaXX
	 ukQYV3z8bm5WZlvkN+jPIN5ZUr0MxZRkzJiAGJrhsgiRJIwkGoHdA9MDbzV9Wve2kUNN4
	 5QIfA0/TT6DgkhJraqfvFM/WfZcJG364HlObQ8xUgo15DZJhNkD/lypShCCgIq4HeG18/
	 UV8A5WzZpQ31ptlFYX9kXEpS3m/bB+Dl7jSSOVMVVOEcmJl9GBtBfEZ7y1d3pVfvelw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MLXvMFD9;
	arc=none smtp.remote-ip=91.218.175.151
Received: from mta0.migadu.com (out-151.mta0.migadu.com [91.218.175.151])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A4D606A31F
	for <rcu@vger.kernel.org>; Tue, 20 Oct 2026 09:49:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67A4D606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MLXvMFD9
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=mqDqnlOPqVENCit8mEeE+eXMdsC3agkh5ChP9WL1LDU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792489755; v=1; x=1793094555;
 b=MLXvMFD9TOTAhR26smDJM+TgaT+d4fMMBIuHioAwy1FwGozFJfef35s6WEOE5ZC8CGyMiqly
 lp42xXr/qY992ZINYb/0r8DgcGlqNqEwUHXi2qDZZjvssT6Y0yzDmmg/N/Qz9toS65FjrEGjW+N
 uK6pw8VHV2fJ+k0J+v4Py+0Y=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a6efb9e73a5e54c0;
	Tue, 20 Oct 2026 09:49:15 +0000
X-Mizu-Trace-ID: a6efb9e73a5e54c0
X-Migadu-Flow: FLOW_OUT
From: Zqiang <qiang.zhang@linux.dev>
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	urezki@gmail.com,
	boqun@kernel.org
Cc: qiang.zhang@linux.dev,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rcutorture: Fix suspicious rcu_dereference_check() usage for trivial-preempt
Date: Tue, 20 Oct 2026 17:49:07 +0800
Message-Id: <20261020094907.15781-1-qiang.zhang@linux.dev>
X-Mailer: git-send-email 2.17.1
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list

Running the trivial-preempt flavor triggers a lockdep "suspicious RCU
usage" warning from rcu_torture_one_read_start():

WARNING: suspicious RCU usage
kernel/rcu/rcutorture.c:2581 suspicious rcu_dereference_check() usage!
...
lockdep_rcu_suspicious
rcu_torture_one_read_start
rcu_torture_one_read
rcu_torture_reader

The trivial-preempt flavor .readlock_held is set to torture_readlock_not_held(),
which check RCU-bh/RCU-sched critical sections. however, it's read lock
just increments current->rcu_trivial_preempt_nesting, it's not also RCU
read critical sections. the rcu_dereference_check() condition is therefore
false, and lockdep report warnings. this commit therefore drop .readlock_held
callback to avoid this lockdep warnings.

Fixes: c6f4e552e1ea ("rcutorture: Add a textbook-style trivial preemptible RCU")
Signed-off-by: Zqiang <qiang.zhang@linux.dev>
---
 kernel/rcu/rcutorture.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 92ff197f4789..1bbf8192786a 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1164,7 +1164,6 @@ static struct rcu_torture_ops trivial_preempt_ops = {
 	.readlock	= rcu_torture_read_lock_trivial_preempt,
 	.read_delay	= rcu_read_delay,  // just reuse rcu's version.
 	.readunlock	= rcu_torture_read_unlock_trivial_preempt,
-	.readlock_held	= torture_readlock_not_held,
 	.get_gp_seq	= rcu_no_completed,
 	.sync		= synchronize_rcu_trivial_preempt,
 	.exp_sync	= synchronize_rcu_trivial_preempt,
-- 
2.17.1

