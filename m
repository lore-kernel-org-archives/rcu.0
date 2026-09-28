Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43E72DB7BB;
	Mon, 28 Sep 2026 00:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790555765; cv=none; b=pI3UGx29Knxwa9yoyASMANpiRaUqGJnBplt9WX0aS2lojcB4XYyDteZPonymYbyWhWJs8ccvSPriOWs3HUB9BmQMmRwEVx+EA0oPBx41lQuExw/pMHJyYoJBUdNhI5/8tCcTfQLI3gzUU/lK6t4Y/Zto7acscwWDhoGYQtS19AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790555765; c=relaxed/simple;
	bh=qwWQ8DsyxhPXkDTrJNoop7kbw/cHx7z6fQZu/tqgqX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nExMoUEpPBNFqM3t2UXDiOAEnLJx562sY2vX+dBADRpzirRsSXHivjHgU7Btb+0idu43yBQlWSONmz585RpkCvstrFaMjCHLuUAEK2wMoIkmP3qW/aN3S1d7+OvFpWbgYjlGwUlG+NR0t6xr7NtCZ55cQ1i/Cx101GMa65a3Ueo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fu09JXj2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fu09JXj2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FEE11F000FF;
	Mon, 28 Sep 2026 00:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790555764;
	bh=whNyt3uPuxdg5uJ61JFDxXT5Zqw5hYPkMqMEyCJwgKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fu09JXj2IrM+2ZeM7sDwWVj5mCUPDQWbcLvgHjjtYdkEPkRMBjgro50rh2Om8zKY3
	 58Y3AKMGNiO9klxhc6fVuiH/yrEjIod/ZXIsSlk5bV5W7u0PWlmzz87jLDOl1fsVz2
	 83d3A2xjAE4oX8gcvnHiQAOavEaKF6DZDKmBBqcWY8LtKb4wa4a2EcBwPFL+wsJNWR
	 GrTk9TYOVDUvfVzBTMOlsKTsQocNjDGtILUGSQ7zYFnFcIPLHwypHT+FJD1gJXj/iC
	 eDGu/rEZWSRnzhUjX/JHICGe0SV4BE/EAutM+WxyACqHI2mvvc6aK9Jgw3rxUy1+bQ
	 X50PQ/dAn4ikQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Subject: [PATCH] fprobe: Protect fprobe_return() with guard(rcu)()
Date: Mon, 28 Sep 2026 09:35:59 +0900
Message-ID: <179055575973.241711.6618845269004184577.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179055575009.241711.6358052647499787191.stgit@devnote2>
References: <179055575009.241711.6358052647499787191.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

In fprobe_return(), the shadow-stack iteration and exit_handler
invocations were protected by preempt_disable_notrace().
However, unregister_fprobe() and unregister_fprobe_async() (used
by BPF kprobe-multi) rely on standard RCU grace periods (synchronize_rcu()
and call_rcu()) to wait until the fprobe is no longer in use before
freeing it.

In preemptible kernels (CONFIG_PREEMPT_RCU=y), standard RCU grace
periods do not wait for pure preempt_disable_notrace() critical
sections. Consequently, an unregistered fprobe may be freed while
a concurrent CPU executing fprobe_return() is still running
fp->exit_handler(), causing a use-after-free.

To resolve this, protect fprobe_return() with guard(rcu)() matching
fprobe_fgraph_entry(). This ensures both synchronous unregister_fprobe()
and asynchronous unregister_fprobe_async() safely wait for in-flight
exit_handlers to complete via standard RCU grace periods.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-e46bcd68-4a56-4f19-a255-e3772980e5e3
Fixes: 657b594b2084 ("fprobe: Fix unregister_fprobe() to wait for RCU grace period")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/fprobe.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 9f2d98181779..c3e1580bc648 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -671,7 +671,7 @@ static void fprobe_return(struct ftrace_graph_ret *trace,
 	size_words = SIZE_IN_LONG(size);
 	ret_ip = ftrace_regs_get_instruction_pointer(fregs);
 
-	preempt_disable_notrace();
+	guard(rcu)();
 
 	curr = 0;
 	while (size_words > curr) {
@@ -687,7 +687,6 @@ static void fprobe_return(struct ftrace_graph_ret *trace,
 		}
 		curr += size;
 	}
-	preempt_enable_notrace();
 }
 NOKPROBE_SYMBOL(fprobe_return);
 

