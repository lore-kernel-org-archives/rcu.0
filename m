Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF261A3029;
	Mon, 28 Sep 2026 00:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790555755; cv=none; b=j8ZYDrL9dTXYAcMCJ8bT1gl0CPkASQG9GKT2fQQJGkmn6dp6KNPoDPnFkimLLWX2cvNHgtLP1oeOhkLcJ3XjqKhKIFIZ1Upj8YHLYM//39dF7llBm7Yk+oZcLCVtA1O9FRhAvnDCdrLMyfiPn2pKfdtA5KKE+JfVEuFNfPGpde4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790555755; c=relaxed/simple;
	bh=FzL9+EMsQmtiY7FPXdXgVsdpZYILyXqEVANO57jY5HI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jIBoO6Qvi/qwPuqtSBkjZ13v6U8IXSNPxJB2oV4L29397aUPOfNMlffp+snnoorXmqlN79qC3wUmxqdsEsc0nkzcxI5b+C2bOTrnwv8U8EccEaFyYLq4wIAzVeEmZa9nGNEPLO5k33wXRuOes3PlJj1g1WUDSgmcZk47kgJpdyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6R2/L3O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6R2/L3O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51DC71F000FF;
	Mon, 28 Sep 2026 00:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790555754;
	bh=sEuUCYZwmFhW/BxFoKDyvH66RCQWGwiTPtKnmvbsaa4=;
	h=From:To:Cc:Subject:Date;
	b=B6R2/L3OyXoW59cXJKLTXaMBHv8jnMTx3yZi/JOnJe6Mly0fnvqGbnhTFrSaUROme
	 I3Vp2c7H/ZV1hRJ5cTQNzee5quFjlUvR9ocFRf7r1ulL+Tb0hp/kqDuLCEKr0dPq2B
	 bQL8XnOdBgeVud5pgk43VdcxAL9vz5oQ03y/MShnZkiFr6bro3ceMWcVnzFYF/Fzb0
	 gZQ0qd+NN3Nga/e/DzNfp62jDTx4YiotNMCqzyvwTZ/nQpTw9D6d5J1WEXJMk6Jr76
	 Pw6VmTpLH8yTs6FMaRzsyBj/6VcY89T08c8ReTGWfqYF9EhcGe5gF+IB9AIXB93aMF
	 XSSlexeJ3hOZQ==
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
Date: Mon, 28 Sep 2026 09:35:50 +0900
Message-ID: <179055575009.241711.6358052647499787191.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi,

Here is a bugfix (possible UAF) for fprobe found by Sashiko[1].
[1] https://sashiko.dev/#/bug/linux-e46bcd68-4a56-4f19-a255-e3772980e5e3

I think this fix is a short-term fix to make it safer. Eventually
I would like to replace all guard(rcu)() from fprobe with
preempt_disable_notrace(), because currently it introduces unneeded
overhead to fprobe.

- Introduce new call_rcu_tasks_rude() for async call.
- Add special non-preempt mode flag to rhashtable, which
  uses call_rcu_tasks_rude() instead of call_rcu() 
- Switching to use synchronize_rcu_tasks_rude() for unregistering.
- Replace call_rcu() with call_rcu_tasks_rude() in BPF.

But this is heavy depends on Tasks RCU, so I would like to check
with the RCU maintainers whether this idea aligns with the concept
behind Tasks RCU updates.

Thanks,

---

Masami Hiramatsu (Google) (1):
      fprobe: Protect fprobe_return() with guard(rcu)()


 kernel/trace/fprobe.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
