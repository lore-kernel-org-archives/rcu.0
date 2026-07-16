Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528DA26B95B;
	Thu, 16 Jul 2026 00:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784161526; cv=none; b=sgt+7TA0fQRY8vjOkQ946VXDhhD9TGDZPqfNrWFbB0p30uSL2lGwvlMHp7ykZpX6ZWIb/cbScp2EKU//Z0VMrnGJAkFelijZfkY0+sevnItndXjy+P5r7gi9K/yihRcPbCbYYeXLZdruSY0Cm5qFoPUihJmIbOoV0drd6xOG5Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784161526; c=relaxed/simple;
	bh=jKYmTWVVL10o+NufIsoR8Is111BlNfKDFScrak8F2FU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FNSLNXXmL4Jp/b/c29GL4+8Q24GEMLMJJNx7GP0wKtJydomr/D4W0RlD8b4ZOSZsPzz8WQmUJJVo72ctcQ+gsSxSqGcvAtAPHrPyNm8xFflsyL+OaTegB1YPekEwy04zLFg2IdaaMXROcaKWJgXAgCSo1saGSUsbtZU7vnuvNXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2Jgv79Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2Jgv79Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA0E1F00ACA;
	Thu, 16 Jul 2026 00:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784161522;
	bh=+PPBNj++Jf4jIxy0AW9k3sg9cYh/s+9GRNT/n/1Y7Ck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i2Jgv79Qs6f38tk5XvGyhZy9Z9XK4MxyzpXrhJbHIXf1VyxDrDC0667AvtIbrbRhJ
	 UTZ4ea2UxpIZ7LxFWXetH31gMeoSifVESIaOq3VhNXO0jGUj5w2XDbnYot0nlocACc
	 wxRJTg+NPtYqlG05YBDGfQXAqz3F/qXzLknkhYYYKNl6wCINqRkKlvx6WrDmbziNAX
	 36if7p8FOJfFAJmcTs+G7new8XK1WUUMbBOfbF5T/evaMchc1pV5BZuyzHz5rLoCMi
	 hsY4j9ekjtmgK8+kLnRBMTV80UQvFxpa2Dsdqk82b0wtSKQ+2wB7+hBfwl+rUXMyat
	 WFWQNsq1OAL3Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 79B6DCE0C57; Wed, 15 Jul 2026 17:25:22 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 05/11] rcutorture: Use cpumask_next_wrap() in rcu_torture_preempt()
Date: Wed, 15 Jul 2026 17:25:14 -0700
Message-Id: <20260716002520.11895-5-paulmck@kernel.org>
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

The rcu_torture_preempt() function uses cpumask_next(), and if that
returns an out-of-bounds result, re-invokes cpumask_next() on -1.
Which is exactly what cpumask_next_wrap() does.  This commit therefore
saves a couple of lines by instead using cpumask_next_wrap().

This was reported by metacode when asked to look for opportunities
to use cpumask_next_wrap() in kernel/rcu.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 2f510743722fce..64b56ec823c1af 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -4183,9 +4183,7 @@ static int rcu_torture_preempt(void *unused)
 		// Wait for preempt_interval ms with up to 100us fuzz.
 		torture_hrtimeout_ms(preempt_interval, 100, &rand);
 		// Select online CPU.
-		cpu = cpumask_next(cpu, cpu_online_mask);
-		if (cpu >= nr_cpu_ids)
-			cpu = cpumask_next(-1, cpu_online_mask);
+		cpu = cpumask_next_wrap(cpu, cpu_online_mask);
 		WARN_ON_ONCE(cpu >= nr_cpu_ids);
 		// Move to that CPU, if can't do so, retry later.
 		if (torture_sched_setaffinity(current->pid, cpumask_of(cpu), false))
-- 
2.40.1

