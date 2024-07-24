Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969F7161924;
	Wed, 24 Jul 2024 20:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721852446; cv=none; b=QON+KJvGfRR7fWm0WqE4YPft3J1bNzWfJcHoenf8u7emg9OnxDjj7ACOaEST74GH8kqJ0ldIPbR9qOgtUD2/hBx3gqTMsg1XOd3NNjve880f6+LDc0855DbdKh215zYMs6pv6Q9PBSNC7RUpcBckPJyuFLlq5fknvZRJ+k/0Lnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721852446; c=relaxed/simple;
	bh=F0g1untX23cPOeTUVYa3X2pXrcAV8uQMF7JEupfXIEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vud1BWCL6HlZGmtafsFItK+yo6QQaX1CV0mcIoBCsWImyKyf6QMEIeXkuJitl3jACgs5bNvcn/tAgGBwoN/M2xG0oWx8qDzkEXjx+l4SFp0q92nVf2y8nYoAmE6GM547ZPQMsoXsBChn/IR7tmUNkRH6nhD0BTYqwZLqnhu+OPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ii4JXV/b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ii4JXV/b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2621FC32781;
	Wed, 24 Jul 2024 20:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721852446;
	bh=F0g1untX23cPOeTUVYa3X2pXrcAV8uQMF7JEupfXIEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ii4JXV/bE04l4ZCVjRUuGda4gWWAlId/4pHwtAnEOrwJHq+P4L0EDnQOiQPxf0tOE
	 mz67udpWer7aKS91Qx7wX5B46Wz+oCZleECrObos7DY/q9QEuDrXtNXIEAuLKI1WZ9
	 vDy744Dqp69mwzJPFXCebWrHlA4/f4+swJwCE6QvL+BvozpZRGkLifD5V35jLJozCd
	 XIe+JgOQDkdUQZmmUNxz2dv0tFWeB/i2+8/J0qlTqGNUmNdbP4F2KSg7JREMbdoi62
	 Ypr556U0ZrhZlmq57BpdtA6xYtwp7hn7toTQnGlilbJHJcXlJRG6o1lKk7BaLxsajr
	 AFMmwOQcKB6bw==
Date: Wed, 24 Jul 2024 22:20:43 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH v3 05/25] context_tracking, rcu: Rename
 ct_dynticks_cpu_acquire() into ct_rcu_watching_cpu_acquire()
Message-ID: <ZqFiG87Il9xqipj5@pavilion.home>
References: <20240724144325.3307148-1-vschneid@redhat.com>
 <20240724144325.3307148-6-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240724144325.3307148-6-vschneid@redhat.com>

Le Wed, Jul 24, 2024 at 04:43:05PM +0200, Valentin Schneider a écrit :
> The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
> RCU_WATCHING, reflect that change in the related helpers.
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
