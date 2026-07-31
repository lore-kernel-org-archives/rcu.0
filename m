Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDF42652A2;
	Fri, 31 Jul 2026 01:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785460042; cv=none; b=MGa+rsS8kIq61ar1fPAvoxy9lyuvM7qaDBd/1E8oiffOMQVyghGFD4Tck/5hffDMB68tLkSgtaWjKjEhy//zwiNyCG7bSU1qykk4NuDASI49vJMTOsTnmL/rs5jW2cBLvMO5pG2FS5Wml4jLBs3VF0CeRuCt8aAXbWPL8LHymgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785460042; c=relaxed/simple;
	bh=X+zjpUTialN217GxINZjjxEnAThH7MrOoqISR1JfgSY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OB4y14/SkmfQpnrpMQRQVMXYdEuVANE+BHZuzGqwjdAlDOlDYvwpPInNALYcoDO6DRDvnGIzCKFdMim3EusasI+R2VhJDUN8qm93FoGznoXLM8nZQotlKntgXCV5UTXlIL7Pnh7OiSiXIzjsYpeQlntoIBP2ilpPWR2bbGS9f34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHZ9oXpr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHZ9oXpr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E961F00ACA;
	Fri, 31 Jul 2026 01:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785460040;
	bh=ZpVWw6bO0EhfE2mpGLcCRa9qeQ7ESRQGQv+cwEd4gFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NHZ9oXprkaF3wqLbeB5D7jkGTpmTHEK5w7wRjz7nM9IkO/XxInlpZw4vXPK2i49Zr
	 HYcTJGEMKkOI8bomJOZuzBXPdZCejh/XCETh/YtHGGlmM/FIUcIb4qlh2e56q92NDP
	 vSye1vRfWsgPMiEJuL5PNIaROOC0gLtSKihURy3l1E05/ZvJv3GMvz4YbBAj5HIg/j
	 VmsWGhn+z+Mrz1JVyEZ8hpbCxZzGivVJoQFWrTD/8Vh2Z/p4S2H+G4JzUEEiCpwRO8
	 Cx3T0X79rJ+kl4VVmsgCf04X+1kDDW888HYhT6a1WSQI+I8KgMg0gcycnuEScWGUZ+
	 3hBb4wKAMA5Bw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8CFA6CE100D; Thu, 30 Jul 2026 18:07:20 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Wang Lian <lianux.mm@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 05/13] rcutorture: Use task_state_to_char() for task-state reporting
Date: Thu, 30 Jul 2026 18:07:11 -0700
Message-Id: <20260731010719.3531912-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <d1db6e52-06c2-401d-b6fe-85aa588196d8@paulmck-laptop>
References: <d1db6e52-06c2-401d-b6fe-85aa588196d8@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kunwu Chan <kunwu.chan@gmail.com>

Use the kernel's standard symbolic task-state representation instead of
printing raw hexadecimal task-state values.

Suggested-by: Zqiang <qiang.zhang@linux.dev>
Co-developed-by: Wang Lian <lianux.mm@gmail.com>
Signed-off-by: Wang Lian <lianux.mm@gmail.com>
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index afd5045263be36..c9fb375701f893 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -3076,10 +3076,10 @@ rcu_torture_stats_print(void)
 		if (cur_ops->get_gp_data)
 			cur_ops->get_gp_data(&flags, &gp_seq);
 		wtp = READ_ONCE(writer_task);
-		pr_alert("??? Writer stall state %s(%d) g%lu f%#x ->state %#x cpu %d\n",
+		pr_alert("??? Writer stall state %s(%d) g%lu f%#x ->state %c cpu %d\n",
 			 rcu_torture_writer_state_getname(),
 			 rcu_torture_writer_state, gp_seq, flags,
-			 wtp == NULL ? ~0U : wtp->__state,
+			 wtp == NULL ? '?' : task_state_to_char(wtp),
 			 wtp == NULL ? -1 : (int)task_cpu(wtp));
 		if (!splatted && wtp) {
 			sched_show_task(wtp);
-- 
2.40.1

