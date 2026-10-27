Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793085106;
	b=pNSz7uV3e2tOldPN4/r7h6+Z34S6W2NFQ17NkioazOfw1lwq4b4VTLY5bvrUrQy2poxI
	 04P9No/Gy07uVjVWAUEmRabLW3l6MV8Cz3qrsceXNxI/fdmddjPUvif6p8LP7ai0FJj8l
	 U3uEhxM1fdYRDmHxvRXdoA8ETierEIIW3SnoVi7pZ+26vuSq1lCxlRHnNoOsbicGH3RbC
	 esLXxzy5a2lkdtJ1wyfzYlEOLwss5+Q6Tyj8h5qusn3vq1EbgdR6alnkHJJOxyHjRU18a
	 0fAFsX1RCtX02Y8pPbm1bY+RHKRmxefpmKnrlnaZMCUVQpAeXoXCVFh1N7q1kKFB7HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793085106;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=A0PZdMuRaPuxrFktKEqu16aYTR0a+VKbukOtArUVV0U=;
	b=sxxPOhFmcyv2ch13yZuJU7BuircI/s3nKTjC5m6E3EITBl2CnIIEA+kcfeA/IOzACz5y
	 RmFm/dt8ZX8bf7l/AeHiW6AyUJtK3d/gvNhUVZmN6O2Ilf2605yhtQgE9thGlQlo8jpV3
	 vMTrR9ae6xPgrycZHVq6p09OykWIK0TXLJKNpzArCiMgnYwIBwaRX7x8tzVUtcSkCrtY7
	 Ko836iDt9xQCNt4IZZzThXYGsKWywP2hnTxtK8Z5qkp4eqBybrtjhS1IImO3Qj6YS+fg7
	 ty6Dvpw83CgKYO2cHHujNfuzfaMl7oveZJ7CCIlVh7Sy2lZpzwkxI0pP8tzV8jVmmHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Jik7A2vp;
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7E0606A31A
	for <rcu@vger.kernel.org>; Tue, 27 Oct 2026 07:11:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B7E0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Jik7A2vp
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8a06b27bf9bso1997751b3a.2
        for <rcu@vger.kernel.org>; Tue, 27 Oct 2026 00:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793085105; x=1793689905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A0PZdMuRaPuxrFktKEqu16aYTR0a+VKbukOtArUVV0U=;
        b=Jik7A2vp3a8DxHlOpMaXpyKknv7ORvGbKPPLW479LXSs7vv53qGBPZ84i+NZCDZhPe
         r3hfkCaCZ4aOh/Al3jxAlmvVlSbLcjAc6hkX1TblTa0TtBkt9ZLzNBejNj769KZ0/Vde
         nEVIz48TwL4ERW+Hs2XDJxKMK/sLfG7QwSb5HKN+9tUQJLm+wigkhnk3+wkd1YDJsy9R
         bVu/cbxXaDEvl0XoRf10ZLLo82M20ioUHAk0wzN9N40PoYSnOscvkYKl7l79/JKyAr+Q
         q1QkCkQ7wVfXevHkXQ0VxTIchmrWtj0Wfx1PMYh3EGkxybgFyQXFDyCixV8BeoOCz4PM
         NfYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793085105; x=1793689905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A0PZdMuRaPuxrFktKEqu16aYTR0a+VKbukOtArUVV0U=;
        b=tkvJNsUUquDOHSFxwN0PVE/z9cK/yYfcxhQkpVWyr1FgMCAHoNJC+MVGkyVQk0Vq0D
         YY5o71duH/AHxL5xBn9L2+VhVIyfY74fpt/TkSyYEogjlk4Ds6PiP7AHe+/cUqJK5s7P
         qN5ZNtopqCodA07ir4ggWd1ZDP+FhThTvWyEI/5yV92ycoSOxkZjJNX9wFL2VPnEFI4F
         jKrt4ki321x4LJ2MIukJEy35Ado25nb2cDDautO3kqFzYf9KfAut3kb+lPDdObKmHXqA
         ReaDFgt0n0WFSwcStSSlNx98fRCFopJxdZXpdAK0ELU2yhzCMUo7v4ofh3Qf35iHOCdd
         af3w==
X-Forwarded-Encrypted: i=1; AKwUvByc4ZO+EUv/pEhkXIqSbPuQqHE1gjh0LYnh4dKRogoB/fKp9oncUnEIzJ+cj+O4PVlPcms=@vger.kernel.org
X-Gm-Message-State: AFq9FYKgIljVikCj/IWmLzhCfqXV9i9exoakACpTgbB1IsVugNq+NtZ6
	y1EoZRplcBr3UN8AYbyEoaXsOvi/kTe0G5qbgi/pTti2iufU9WVfBA9/
X-Gm-Gg: AYBFou2Bgpe9v9Rzv11Oznekk96fJcgpz+B+lDMy7YqahH3r58MuOCJGPDYtD4pzk1P
	OBe+eY82BAoQtBR9kXeDaUvsOwb7Xat6Z9KgIOLflt+zgaklvzt/htUL3H3+ImZg/BotAIB2vD2
	OXG+XhcbDlyzsMZywZyfP6SbLdIA+d1aBbqbST/AvzW4MCSkrW+UQIOk1fScUryNeBPzcCv9hCT
	/ZD3NJulHyMLSkQ+DdhCoUK+VzootwLIfumG1ls3+AOF7VAvcdsBOrEl+syZeUJdzZyiKbsOCyZ
	rXmBYQea3NHpwydAGtiBA9RHR3ZO8HxS+yVVomOo7HTu2b1peRbVp6aSkHFNXrMXNh7Mc8tRndy
	vFussqE6ma4MIABeOjNWj8XeERafhtH3EXsYRPOnNBkpY+bSnnhtKy/v5qmB3XO+uWjhA08wBQv
	M6zIk4GpQe5EyjDvmGIUXiv0iNOvKI86Pn3di9z2TWWp5+uk9UWxofpPvxczE4LgnTTiLiAWA/N
	nV8/lZClvm+rOIZXvKMp2MUFtpKNFE22YIHD8IkU7oB0LNInZv8GkTDmWoYV94nRiLuGYb2/8Ag
	fqb46yKIMBR0P+9S6PMLqyJ/bsCswqL1WLN7/d6RaWhEXB4=
X-Received: by 2002:a05:6a20:258d:b0:3e1:de28:8ebc with SMTP id adf61e73a8af0-3e7bfaaea6emr6520063637.49.1793085104791;
        Tue, 27 Oct 2026 00:11:44 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.37])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8ccc21274sm2277512a12.8.2026.10.27.00.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 00:11:44 -0700 (PDT)
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
Subject: [PATCH v2 10/10] rcu: Improve duplicate callback diagnostics
Date: Tue, 27 Oct 2026 15:09:23 +0800
Message-ID: <20261027070923.3054462-11-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027070923.3054462-1-kunwu.chan@gmail.com>
References: <20261027070923.3054462-1-kunwu.chan@gmail.com>
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

Use ratelimited diagnostics with dump_stack() for duplicate
callback detection in rcu_do_enqueue().

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 kernel/rcu/tree.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index aea3aef7397e..a8ede50dbeff 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -25,6 +25,7 @@
 #include <linux/rcupdate_wait.h>
 #include <linux/interrupt.h>
 #include <linux/llist.h>
+#include <linux/ratelimit.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
 #include <linux/nmi.h>
@@ -3154,9 +3155,12 @@ static void check_cb_ovld(struct rcu_data *rdp)
  * already disabled, and a drain of a remote CPU re-issues onto the draining
  * CPU.
  */
+static DEFINE_RATELIMIT_STATE(rcu_dup_rs,
+			      DEFAULT_RATELIMIT_INTERVAL,
+			      DEFAULT_RATELIMIT_BURST);
+
 static void rcu_do_enqueue(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
 {
-	static atomic_t doublefrees;
 	unsigned long flags;
 	bool lazy;
 	struct rcu_data *rdp;
@@ -3167,9 +3171,10 @@ static void rcu_do_enqueue(struct rcu_head *head, rcu_callback_t func, bool lazy
 		 * Use rcu:rcu_callback trace event to find the previous
 		 * time callback was passed to call_rcu().
 		 */
-		if (atomic_inc_return(&doublefrees) < 4) {
+		if (__ratelimit(&rcu_dup_rs)) {
 			pr_err("%s(): Double-freed CB %p->%pS()!!!  ", __func__, head, head->func);
 			mem_dump_obj(head);
+			dump_stack();
 		}
 		WRITE_ONCE(head->func, rcu_leak_callback);
 		return;
-- 
2.43.0

