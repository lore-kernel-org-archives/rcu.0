Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FFD13DDB8;
	Thu, 25 Jul 2024 14:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721917970; cv=none; b=o+pabZk/OZcfotSwFMpYfCavF3qwYiKW8Yl0Yyqj0lJW/4kGGy5BrKx0R313RZ9kE4fX1XbB6FTHWIFZ4A2Hn/tVhDXBJFWbKdIKQWJLWTWbK8mYF+F0QuFQsJGu6d0KxfaTllnD/4Fl8i6PIXECLFzeEUeqrLoKcC6OIS1Qoc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721917970; c=relaxed/simple;
	bh=gRG/qvxmmX+tjMdoviAWFPeoyK0O/GATVHTiw+M8o24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y61qKwbq+7uuNEo1Pt1W1ssCKk9FjRQVxLKpKKJB7v0i+IOvzxRJa2niYlFqTWsL2UKRmIVGE+VuZ2jtFlf9qKCJ+VEzztLd41ehAEWL96TbFCEYSZSnqw3meYaIyIB70+2MQA2ASfk/LR4gmW5ZZD1lzmRGgYm/6gS33YWQlQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZiZc5fiN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZiZc5fiN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D628C32782;
	Thu, 25 Jul 2024 14:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721917970;
	bh=gRG/qvxmmX+tjMdoviAWFPeoyK0O/GATVHTiw+M8o24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZiZc5fiNIho7dTeJeJ3MgZ9SHChsj6MLWUEcRJnP5hpv45Cfpx7RX0ERomJpFjd16
	 VZmdfdHP+IrtAXgVRkZ0+SqTpfb3PPfNeoAjsWVsAQLeFMO7pzOp7j+UXIdd+6YUC/
	 pBHYMDja+dZ2zu7SfKRFNpbe5nSLULYrfQCuw6kPVPEsfPO7/r5vhOP3uSQqSuqweu
	 F9wPNLKHWUDBZEB6Y72IykhKOmBrs3K+NJX6WQsMOaeYYKa/Xw8hoVRBO9htEjrhQV
	 kz4UtF9pGQl6UeUSLJCwhhd8iRpbHu3I/Ir0MesUf138iEV4+YE2ZgYk8W4CBxPTDu
	 78oLUkW9Q/1sw==
Date: Thu, 25 Jul 2024 16:32:46 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: RCU-Task[-Trace] VS EQS (was Re: [PATCH v3 13/25] context_tracking,
 rcu: Rename rcu_dynticks_task*() into rcu_task*())
Message-ID: <ZqJiDlKtD4wvsv1j@localhost.localdomain>
References: <20240724144325.3307148-1-vschneid@redhat.com>
 <20240724144325.3307148-14-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240724144325.3307148-14-vschneid@redhat.com>

Le Wed, Jul 24, 2024 at 04:43:13PM +0200, Valentin Schneider a écrit :
> -/* Turn on heavyweight RCU tasks trace readers on idle/user entry. */
> -static __always_inline void rcu_dynticks_task_trace_enter(void)
> +/* Turn on heavyweight RCU tasks trace readers on kernel exit. */
> +static __always_inline void rcu_task_trace_exit(void)

Before I proceed on this last one, a few questions for Paul and others:

1) Why is rcu_dynticks_task_exit() not called while entering in NMI?
   Does that mean that NMIs aren't RCU-Task read side critical sections?

2) Looking further into CONFIG_TASKS_TRACE_RCU_READ_MB=y, it seems to
   allow for uses of rcu_read_[un]lock_trace() while RCU is not watching
   (EQS). Is it really a good idea to support that? Are we aware of any
   such potential usecase?

Thanks!
   
