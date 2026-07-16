Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CB72D876B;
	Thu, 16 Jul 2026 00:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784161526; cv=none; b=B6HsTfK2+yAiSnEz3edyhUE8/LBd+mwfNKKKygyweMzs6MeCzXpkhGorHYgB6eOVm8M8sul6UOj/DpX23zzE1E5/uTRwVzehMr4ZRJID/QSxsgI7gohtOL+1q3ci4eX9c2XYbAXv93P0+yrMSa5ATDDkhfEIixfeVoNe8hT8vE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784161526; c=relaxed/simple;
	bh=soARazhdETV/IcIoEarjnfAFvY4T4vxaTG3G8RT4xDU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nznfKMnhjGOkfeU+NGEzlUnSl5p4kzNMVfYjReab8R0Laga2mloVgf64VLNdG3CAKURwjQTCpASOxFcEvP8fYIlpJaTGfC4dFLkkJMUi16/oJpbjsSbjDYD9OjJvUipkVvdBoDXqDsaX95qZqFNtGIO/8nxK5uV8wJv2Prj3qcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDvfXFSC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDvfXFSC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A51F51F00A3D;
	Thu, 16 Jul 2026 00:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784161522;
	bh=RxhdemyKTyff1v8+uLGbIuPcBR7mfVc135xZvhUs8gA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hDvfXFSCE9SIQGaUAsJ9qk99VxPqCrT+/TQZAj7FxCBs4FaLrRaBRWtvnS1pP4/WJ
	 c2aLaLw58iH86DIXcA/4C2ESieu/aEZ8u5OfMNKuGtT1+/ji0CKXTQKuSgJkZxZX3f
	 J6FbIy4VDzSKXKDhrUPUAjjTneVlNB4EszLSj/E8GVDu6ommQ0YO9lSDSTRbzUiyFa
	 aX9eiNRXdU8fHjH/0282iCLW4g/mqlTT/CgWGU4NqeS6U7Q93IS/oNZtrB9s4LBhU5
	 JXBgvG7xQPYkngR//APWdOk2xT0F5t3RKTd3G/GEZGJsU59Z1C9D+zHISdsgQtZrB+
	 Kz1Q+qzL+bDBw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 74C4ECE0B8B; Wed, 15 Jul 2026 17:25:22 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 03/11] rcutorture: Make srcu_read_delay() check for disabled interrupts
Date: Wed, 15 Jul 2026 17:25:12 -0700
Message-Id: <20260716002520.11895-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <3f56c779-b900-40f9-9a24-6136fb28ddfb@paulmck-laptop>
References: <3f56c779-b900-40f9-9a24-6136fb28ddfb@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Once rcutorture starts invoking rcu_torture_one_read() from hardware
interrupt handlers, srcu_read_delay() will need to avoid invoking
schedule_timeout_interruptible() from such handlers.  Note that
in_hardirq() does not suffice because some architectures invoke what would
otherwise be hardware interrupt handlers directly from the idle loop.
Therefore, a simple irqs_disabled() is pressed into service.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 1a033ae1f1eb6a..0e0ad4cccc3644 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -767,7 +767,7 @@ srcu_read_delay(struct torture_random_state *rrsp, struct rt_read_seg *rtrsp)
 
 	delay = torture_random(rrsp) %
 		(nrealreaders * 2 * longdelay * uspertick);
-	if (!delay && in_task()) {
+	if (!delay && in_task() && !irqs_disabled()) {
 		schedule_timeout_interruptible(longdelay);
 		rtrsp->rt_delay_jiffies = longdelay;
 	} else {
-- 
2.40.1

