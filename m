Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66901E32D3;
	Fri, 13 Jun 2025 15:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749828147; cv=none; b=TFpJ9jYubBvZfejd4UfNVbnrA/Zk0ycpeOsBUVTAZ50QLUNCN//vesDRIBLWQxlw21icWWhnbfViBdwh0ZT9JuVftLIiwMUdPfy4z+UYzedCPy5O8lvjFY+aGuhhLi1yUrwNyDDueZ23+eRwx1TqUDLrHEPS8iz2RYop6RTDF2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749828147; c=relaxed/simple;
	bh=wMvy6gkTPZlbJBO2tAOt3uXhlB/7b6M6Kc/5mW8MlnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b5NqKwcC2+x0z6aHcn3Yjgv1+Kao20qw8d3tCEBZKM7qPVfYIPK7nGn6LkQqz9IP7Otrieu4TyPQ7CgUzqbCzB6+OCgs0wXLCxxOQafv8puJMPlEqMVgJbOhmtlw7DQSbL3aottqzI/q4q1oq357nXQYN6ERWqsClx6d5azIehY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CU2/62Q3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Np94UAB5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CU2/62Q3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Np94UAB5"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749828143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PjT8ocJZ8brWOD8sQqNEE+jnldvhnA4/g6mdJ/EGG2g=;
	b=CU2/62Q3uUuF6vckCfIYuKAykdd3AQOV2KuXoxr4pG987/HNYUN54p+/PVkiWR1Zh732sM
	9u01cwHYoYUv/K/AFR6+XPHd5DM7G7C2f+RRrD0mSDU677Mz5HrsEa1ITMvzBtc5k+BUL4
	JkUU57BiNRwQIqkJF+P/4OU5YIFPj2xJgLTl6lmhNCRedmrwYcQ3aMjQ4guMgsMAoUlz3b
	WNoJg32Qis1PB1XrfKnqvgnvazV+jx7gLWTVwkf3TBZHe9LYzxztDcMekZm/E0RHu8Jtwn
	Mfeqo5NcpYqUfU41Hln9JQlobU+i8IhgcCAgsAtmDIgt8JAiTGGavCp17Rnqkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749828143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PjT8ocJZ8brWOD8sQqNEE+jnldvhnA4/g6mdJ/EGG2g=;
	b=Np94UAB5Sx832fNmHKvWG41dcLA9sA/RGRTBjKShvnILhO69mwv97PZiqo8/+vWVt4c2S7
	E7s8pBZ2Zvzf2FCQ==
To: linux-rt-devel@lists.linux.dev,
	rcu@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RFC PATCH 0/2] Switch tracing from sched-RCU to preempt-RCU
Date: Fri, 13 Jun 2025 17:22:16 +0200
Message-ID: <20250613152218.1924093-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This is a follow-up on
	https://lore.kernel.org/all/20241206120709.736f943e@gandalf.local.home/T/#u

The problem is that trace points disable preemption due to sched-RCU.
The arguments passed to tracepoints may used locks (yes, they should
not) and eBPF programs can be attached to tracepoints which may use
locks which become sleeping locks on PREEMPT_RT.

Mathieu said regarding the need for preempt_notrace:
| There are a few things to consider here about the constraints of the
| callsites where the tracepoints are inserted. In general, those need to
| be:
|=20
| - NMI-safe
| - notrace
| - usable from the scheduler (with rq lock held)
| - usable to trace the RCU implementation

This is covered by the here suggested rcu_read_lock_notrace().

Mathieu's suggested steps were:

| Well the first step would be to introduce a rcu_read_lock/unlock_notrace.

Patch #1

| This solves the problem at the tracepoint level, but requires that we
| initially move the preempt disable to the tracer callbacks. Then we
| can figure out within each tracer what needs to be done to further
| reduce the preempt off critical section.

Here I am stuck. Patch #2 is probably not correct due to "move the
preempt disable to the tracer callbacks". I didn't figure out where they
are=E2=80=A6

Sebastian Andrzej Siewior (2):
  rcu: Add rcu_read_lock_notrace()
  trace: Use rcu_read_lock() instead preempt_disable()

 include/linux/rcupdate.h    | 41 +++++++++++++++++++++++++++++++++++++
 include/linux/tracepoint.h  |  2 +-
 kernel/rcu/tree_plugin.h    | 14 +++++++++++++
 kernel/trace/trace_events.c |  8 +-------
 4 files changed, 57 insertions(+), 8 deletions(-)

--=20
2.49.0

