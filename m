Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792750760;
	b=oosyBrwAWr8YzFgCVNy8qraK6ibgqbIz7q4TjaydR/3583DmrCkkCab5wRSFvsoA2wv9
	 92u2q6I2fyaFq4XYxDoGFiaV7zh2/6HGO2jGkhRgcYe3a/xzvhyQij8Mp8KEDPMJa076N
	 SvDLLSDDOYIYNL4krAZW7TTynrkaPQjWLX9hezVJkmsHG1VKrM0+p/DaonHtl1bLYPbWe
	 sAWr7E9A9d+QfgxMIluIor4GfwlDpBk23fN9jIWRS7ylFlMwlQBri3RK7hLafvM1u+BB4
	 UcxQ4M1an6JH9PlrRrjSuh5+KOOyIguIUC7XkhLutOMGdaLa/0n6whdwPcdpfE7dgJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792750760;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=G49yOkjHll/OcWD0zAplg4x1BvQSWYpduHQ9gxRuz20=;
	b=1mZWBk15RV2cLduT7IXDlPA1opUcUUyUJxhLudKbtXkJocV4fiWR+U67jKGM7Xu+ZSum
	 Z+PgppQ+kZVhCpbIDHtTUvpNLEGUhDFqJc1OjFLxnHAc8wFFmu8UhI45EBSmyVtrsd9Li
	 OoEaDrGl3l0+exw5cpAtA8bifZNTLy7cAXpf+eyKVXX41nsHoLqEdnBUzNm6NApMeG+0l
	 uqmdD8JXKLWa0uGUI1MsfIk5W7gEt+nYf8O6IZxoQxG2P53piT8gOoUA9i+XHN9wbEIvE
	 4KYwyRXbB4zTznPpfR4I2VHYMasTflhgozIEKkPJEFgRBPL+KyCHKrja5POioPgIHKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GxKTl4Ni;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A978606A328
	for <rcu@vger.kernel.org>; Fri, 23 Oct 2026 10:19:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A978606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GxKTl4Ni
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso559528eec.0
        for <rcu@vger.kernel.org>; Fri, 23 Oct 2026 03:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792750759; x=1793355559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G49yOkjHll/OcWD0zAplg4x1BvQSWYpduHQ9gxRuz20=;
        b=GxKTl4NiT5VlWes1To8m5EiuGCyixml5Z/nlkvjLC43aUCUXu/l6mOr+/egw/Hzr/i
         +O0sLThydVEm2IX9WV1Zk+P0p/R6ZOaeL8vLuKl481/iDg40pvCNctwa3DlzcsYGQ51T
         z3tv/sQlJ+WPkfp8Gw81C7bXGP3fRj5ryNVhp3C7cLEkTsAnjYwbazJ4biDs1ZxqoyMe
         bwuc3kU39/UgkQ6ULOSbcg4sgZbO9MQ9iRsc2k76DPPsvWAsLtoB1/YYK6h1PjFhMlzT
         rtuC3gpbXlHKy3cy575X1UfM5Zk3Nrp9zxZJZ0piYKr75Ws78HpP6fToZ0kpcfEEGHQh
         uNPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792750759; x=1793355559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G49yOkjHll/OcWD0zAplg4x1BvQSWYpduHQ9gxRuz20=;
        b=n3LH4ntJ8c0P8igka1rU1O8mBhmGJmyE3oEejUL6SrFXyyvjJmb32n+iYpxaGhXmwP
         i95byVv4kVGWEuP6xKmzbg5TLDg27cSWUNdsDek8/GV8i5tfXtOP0f9JPe9heHpCKc+Q
         PdKw6VtI5Kk/DmTFS2oTZGn/AoU51qh2tVCdOa6NIAXUUajxq+tG1kHXnKUApWoxjTfB
         zM/4k5n5lCmyRwweEEDs9yU3oIWSQFU9yg/Nc1030iBJtsNinxd7WfN1DzgUp6nvgIwS
         HTFAYpYxUuzv/EUpn6zQ8Xv0c/uxONI4iQy0crrHtj1l0HPZLwnhAcfzasoy/KnEUVay
         o6fg==
X-Forwarded-Encrypted: i=1; AKwUvBx4LNeI5CmfX2ycwLhaKRVNc1Lz3XVYaKT+6P2a3EdboD5aBwPsz2qY7WfklkRe05O22/w=@vger.kernel.org
X-Gm-Message-State: AFq9FYLjBX7zYvoHfs4GAGRpV3vX4L0hago6CJnF5QhxTIlacWscq2Do
	Acf+ck1BJs/GOi4UmrU+85xVjt5pz8gNDq+d2m4gs5mK61bEwzuTG7rNL+qreXgA8MxhsA==
X-Gm-Gg: AYBFou329bVQdObc7zJ7Y11DVDOgakhj3a46VZvUkZKr/G+T7m+5xgyInghRfwIBXnd
	tnHYW/ZKa+XFYTkr2tpzXGg5omvBVfEpXoPy8gz+cn8Kyf+HinIg2W4AMBe8IFNpQP2bgntUVIJ
	WiR3Ewx3L5vII+zCF7OQveYxxJ0PcV9qhhn/xQo4PNrYaGplayQmH6PWY6/IM842z3u6Dt1Z7/Q
	zkaeYoTCZQD6oqlrZvn9o9PMSeN2G6gL3AZv4685o6Aysco32mWhHz/g0pjw2MCNxuhBnFKJrDk
	RBMt7T/GI8vFy4jd3V78yW847ZakVDzVkEROk3i1UtHs/OQkFW/jtMPOcjwEz9uHFE6Js62vTN+
	NId7xUM4az9Ktrczn818STHj1SATcQHYY9DWBzR8wOMZLo8ylIgNasinLyqaLsVRkdf/Z1F2Vzd
	JcZDopjxRCikXI0TNz2oy9ODN5Qj9bXukPpl5C7ukWa15vvsuc1kN1syS0QKUBZdSEePomZ1CVT
	SmR5JDdm3Whaxh0IJ0sh+2lKxAnD/frYINgATELibliNXpxyUxvel+pThBSUJIfKAjKX2CekA==
X-Received: by 2002:a05:693c:4195:20b0:35b:9f06:e383 with SMTP id 5a478bee46e88-369d971f26dmr2682188eec.8.1792750759159;
        Fri, 23 Oct 2026 03:19:19 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.37])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369d9deef9bsm5852176eec.22.2026.10.23.03.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 03:19:17 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: jiangshanlai@gmail.com,
	paulmck@kernel.org,
	josh@joshtriplett.org,
	work@onurozkan.dev,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	boqun@kernel.org,
	urezki@gmail.com
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	qiang.zhang@linux.dev,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH 3/9] rcu: Record callback registration stack for Tiny RCU
Date: Fri, 23 Oct 2026 18:18:35 +0800
Message-ID: <20261023101841.2910719-4-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023101841.2910719-1-kunwu.chan@gmail.com>
References: <20261023101841.2910719-1-kunwu.chan@gmail.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Record the callback registration stack in call_rcu()
for KASAN diagnostics involving Tiny RCU callbacks.

Suggested-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 kernel/rcu/tiny.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index 656b6a682e31..bd22fa43108d 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -12,6 +12,7 @@
 #include <linux/completion.h>
 #include <linux/interrupt.h>
 #include <linux/irq_work.h>
+#include <linux/kasan.h>
 #include <linux/llist.h>
 #include <linux/notifier.h>
 #include <linux/rcupdate_wait.h>
@@ -251,6 +252,9 @@ EXPORT_SYMBOL_GPL(synchronize_rcu);
  */
 void call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
+	/* Record the caller: the irq_work's stack says nothing about it. */
+	kasan_record_aux_stack(head);
+
 	if (should_rcu_defer()) {
 		call_rcu_defer(head, func);
 		return;
-- 
2.43.0

