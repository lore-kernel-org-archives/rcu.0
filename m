Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9592253F1;
	Thu,  6 Feb 2025 08:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738830485; cv=none; b=Ncy0mhVPijec7SjxO++IAsxNdU0HQhO7gCSDP83N/0tXorUia56J7VnvXO78iAo2yvt4KQrjz5WKpIFC+ixK6L6PSflthNud0Xiz8I/I8vDJmXIngjPmsnqt+4dRK10650swVmZm7LHVIHFnNkGb3rEFAnUsYH7dCkUYMUzD058=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738830485; c=relaxed/simple;
	bh=+RP1Z8GHy5kNA7d6lUqlTXFw0Zdu/kI/rnKlO2DB6MU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QX0YEAEDwcuaNMxQXmYNxQSCmWRfQg3LYnnth/UT4SslQS9TxOjuj/Yj7KYllZloCIIeA/ucTTOfjqGijNUNSFnFEMswni9h92qNG+tMRp6PEzDi4zVCvCzsMF7zwaJhd450A3mNuav79vPgembhy0/L/lmcfX/YrOAvG+qjZ6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mEst8MIS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MxkS3eAF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mEst8MIS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MxkS3eAF"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738830482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7y1GAJTr6tIEGi2sGy3tq4QN5TnoACwjL3i2EMoYxKw=;
	b=mEst8MISnt/GG3DFXcUfoWmm7X7CC1GbDA+eU+E47xnxg08t1i5J9b+yYAl0d3j1gKDV3A
	pkksrh8oboVofBp6XAv+c7sLgzlyRFAxb0rEiucLsgBtqi8sgK3DDMpx26EFJgoACed7FS
	sa8KyuBqaSW7qkudJ0trImmR6C2BrrdQRQ+9FPMqlNdzUKxBr39BMcTuhqqI/fqiMctBxH
	KbOqH9gLc2HRtDVkemJ//2uB0ccsMCryhwTMr4TohWDjnKhKJzYY9mXyuV0Yfo/TCCt+HA
	/pvCJOFb+XFjozPMNXZOdFyK/OJb6KhehO5cVDmveZOqEUH2ZlRZl5V7XLhAfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738830482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7y1GAJTr6tIEGi2sGy3tq4QN5TnoACwjL3i2EMoYxKw=;
	b=MxkS3eAF45Q0tUdfF+4Wy8Q6CLWOuUIDmVCouLRzMfe5PKJ+zAq7WjTg31XOUtQy/nMZDT
	WbzW8ADcMt52dhCA==
To: paulmck@kernel.org
Cc: Petr Mladek <pmladek@suse.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org,
 Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH rcu v2] 4/5] rcu-tasks: Move RCU Tasks self-tests to
 core_initcall()
In-Reply-To: <2a7774e4-a3fc-48d5-97b0-6f74396e7f93@paulmck-laptop>
References: <20250204163409.ueObHFje@linutronix.de>
 <9ed4e0fd-75c4-400a-9a0b-74c68286bad3@paulmck-laptop>
 <a68e2e94-b4c6-4791-b581-ecbf3fee28e9@paulmck-laptop>
 <84pljwi2w0.fsf@jogness.linutronix.de>
 <3a0ceabe-d5a0-4cb3-8343-ec56bc9bd0fd@paulmck-laptop>
 <af84eb57-2da2-461c-82bb-36312bbb49b0@paulmck-laptop>
 <84ed0c1401.fsf@jogness.linutronix.de>
 <efef835a-d2dd-4f03-bb02-c0cf873433e1@paulmck-laptop>
 <841pwc11ae.fsf@jogness.linutronix.de>
 <84y0ykyqf6.fsf@jogness.linutronix.de>
 <2a7774e4-a3fc-48d5-97b0-6f74396e7f93@paulmck-laptop>
Date: Thu, 06 Feb 2025 09:34:01 +0106
Message-ID: <84ed0bmq9a.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-02-05, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> commit 35679c18b062368855e183ee6712ca5c16145d8c
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Wed Feb 5 12:27:23 2025 -0800
>
>     printk: Flush console log from kernel_power_off()
>     
>     Kernels built with CONFIG_PREEMPT_RT=y can lose significant console output
>     and shutdown time, which hides shutdown-time RCU issues from rcutorture.
>     Therefore, make pr_flush() public and invoke it after then last print
>     in kernel_power_off().
>     
>     [ paulmck: Apply John Ogness feedback. ]
>     
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

Reviewed-by: John Ogness <john.ogness@linutronix.de>
