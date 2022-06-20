Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9CCC433EF
	for <rcu@archiver.kernel.org>; Mon, 20 Jun 2022 22:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344964AbiFTWy2 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 20 Jun 2022 18:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344502AbiFTWyR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 20 Jun 2022 18:54:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363161D0EB;
        Mon, 20 Jun 2022 15:54:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D253061451;
        Mon, 20 Jun 2022 22:54:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D059CC341D5;
        Mon, 20 Jun 2022 22:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765653;
        bh=U+2Od+3kkx/tjrgdBOLOykLShILOs3AVur3xwrkvwAg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nsckDQ5DFo0AQeTUlOHQwEKvHtXtQBS33xQl7AQH1nC2e8Ilr+BsoCKLQ9Nqc//R1
         rajT6vNf2ogQuFdKyXyKbgbsxMDxPqNmhKqedgOyJD4B9bDXE124rj3o89EkKFmLEK
         rjFrHzLjo6n/7PtwrO1LN2IiwrIhNj+TEwob0Jnq/Nz2RrR5N/Z/WdnjifKdYu7RBc
         8W0ToHT5JVlXspHj/O0LdIdD2Gq0S45X26rAYZX9m50Nz5ASx7sQrVFLz20bbF2dLY
         ebDaxhk8vm6NQKzpEseevTuk/d3ia+No9ixoFuTJCGa5AjzpjxjVUF7/I6cnpHvVj9
         AhHCuzybX2HdQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 42C465C0E52; Mon, 20 Jun 2022 15:54:13 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Eric Dumazet <edumazet@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>
Subject: [PATCH rcu 14/32] rcu-tasks: Flag offline CPUs in RCU Tasks Trace stall warnings
Date:   Mon, 20 Jun 2022 15:53:53 -0700
Message-Id: <20220620225411.3842519-14-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620225402.GA3842369@paulmck-ThinkPad-P17-Gen-1>
References: <20220620225402.GA3842369@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This commit tags offline CPUs with "(offline)" in RCU Tasks Trace CPU
stall warnings.  This is a debugging aid.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: KP Singh <kpsingh@kernel.org>
---
 kernel/rcu/tasks.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 1cfbebf2b5977..93096188d3631 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1502,14 +1502,14 @@ static void show_stalled_task_trace(struct task_struct *t, bool *firstreport)
 			 ".I"[t->trc_ipi_to_cpu >= 0],
 			 ".i"[is_idle_tsk]);
 	else
-		pr_alert("P%d: %c%c%c nesting: %d%c cpu: %d\n",
+		pr_alert("P%d: %c%c%c nesting: %d%c cpu: %d%s\n",
 			 t->pid,
 			 ".I"[trc_rdr.ipi_to_cpu >= 0],
 			 ".i"[is_idle_tsk],
 			 ".N"[cpu >= 0 && tick_nohz_full_cpu(cpu)],
 			 trc_rdr.nesting,
 			 " N"[!!trc_rdr.needqs],
-			 cpu);
+			 cpu, cpu_online(cpu) ? "" : "(offline)");
 	sched_show_task(t);
 }
 
-- 
2.31.1.189.g2e36527f23

