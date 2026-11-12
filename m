Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794502384;
	b=PsdCLGQiv8alWmy5prb1EuAz36B7E7xOuxeUE7tE0aUM5zKDMb75vd0lZuYC2IyoVBY6
	 +JEV4rMHsYH/Ps2YAtuPUbxnc9Uz7BKEyRxcTfMkH/L07J/A8hcdh+NgQXKZsAXgzdJrG
	 /xi/fnCB1ZFo2DE+ZnEwqK8DheTAJZbDgdEBOD7Ep5fjY8JZEE6FRufBpbDWGQTSYV2SC
	 C0nuphdCr10QB73NhbEqKv6ojVlJxi4usOqluiNvW7gmGipUH7aDJu/buPxp6kVa8wZOM
	 /HI2vU14xSFMbNu73B1sA1HGiwf6LYjlqm/KGI+FmKq7WBFrxN9VKZelXCGrZEh90PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794502384;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=asFgHiM+/zFlQO3jj4VCkwguOaK84DCxoqtHjpPBW6c=;
	b=2FGQoTa9UjPtc3ijFomiqR+SMLka6CPle0qd3a539K0G4Sece5mrPhX3kAr0LLSM+CmZ
	 IISAU48SxCIOMH1oHNYEv1VVCzWeBj29RwnmrUtow5hKkDYl3Jq87zgq3lItyqtSKbnol
	 TFmxbMHosUXF83iUr4ZmbrRh8pGWRxRzkEljb1W6w6grS6sTEiZTpd09Cnr5lp59uuvt4
	 4aRuny+pUKgpQJl2/lRmZPoO9Bk7qWwqJPcWhMsDqRMfMsrI6mUGJxg50YjtsUwW0WOl9
	 /UiNd6uG4ySNLHfmxkJ88p11tduYNOaISyhvXi3zXh9AGE0KzqXzbDtXPG3b34ZvL9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JpACac+e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A159606A31C;
	Thu, 12 Nov 2026 16:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JpACac+e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 669181F000C4;
	Thu, 12 Nov 2026 16:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794502383;
	bh=asFgHiM+/zFlQO3jj4VCkwguOaK84DCxoqtHjpPBW6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JpACac+eV9DQ1vly2Npn17XwTtqfo5UfF6+eLd9HSndgnCqeR5rcmiBGQEyIlLqjp
	 XVdAoj52ej+dy8y6VHsaSjNjMx3acYisBzdMzMdt+KgNvXcO5Xihj80KSUzi8ZpaKb
	 PLZoaGM5TB467FC4arux/D627zL4lOftzLGb4Xxd9fbOboxhWWoUUgKcRo+QUMQMB7
	 CEZh4dF0WZzPHhH0G2nIerLhPJc0odyjp4mGRgMSEe7RpME8doCR1+JxfTS06vicDh
	 tsv2f5/1/YIqXKp+BD9DFMX+ZdrJZGo4Z0H11RGrku0XNo5NdrRtro+hzOIRM1pYKt
	 /G5pPwFnCO1kg==
Date: Thu, 12 Nov 2026 17:53:00 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Davidlohr Bueso <dave@stgolabs.net>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>, rcu@vger.kernel.org,
	David Woodhouse <dwmw@amazon.co.uk>,
	Kunwu Chan <chentao@kylinos.cn>
Subject: Re: [PATCH v3 1/7] srcutiny: Do not call synchronize_rcu() from
 synchronize_srcu_atomic()
Message-ID: <avXu7COBJungJynA@localhost.localdomain>
References: <20261112133731.127221-1-mathieu.desnoyers@efficios.com>
 <20261112133731.127221-2-mathieu.desnoyers@efficios.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261112133731.127221-2-mathieu.desnoyers@efficios.com>

Le Thu, Nov 12, 2026 at 08:37:25AM -0500, Mathieu Desnoyers a écrit :
> synchronize_srcu_atomic() never blocks, so that it can be called from
> atomic context.  This includes interrupt handlers, and code within
> rcu_read_lock().
> 
> With CONFIG_PREEMPTION=y, the Tiny SRCU version first calls
> synchronize_rcu().  Tiny synchronize_rcu() does not wait: it only
> advances rcu_ctrlblk.gp_seq.  This is valid where the caller is in a
> quiescent state, in task context and outside of any RCU reader.
> 
> The callers of synchronize_srcu_atomic() need not be in a quiescent
> state.  An interrupt handler may have interrupted an RCU reader.  A
> caller within rcu_read_lock() is itself an RCU reader.  In both cases,
> synchronize_rcu() ends an RCU grace period while an RCU reader is still
> in its critical section.  poll_state_synchronize_rcu() would then
> report a grace period that did not happen.  The caller within
> rcu_read_lock() also gets "Illegal synchronize_rcu() in RCU read-side
> critical section" from lockdep.
> 
> srcu_drive_gp() has the same call.  There, it makes an RCU Tasks
> Trace grace period imply an RCU grace period.  RCU Tasks Trace uses
> call_srcu() and synchronize_srcu(), which are both forbidden on a
> srcu_struct that uses synchronize_srcu_atomic().  And the Tree SRCU
> version of synchronize_srcu_atomic() does not wait for an RCU grace
> period either.
> 
> Fix this by removing the call.
> 
> This was found by reading the code.  An rcutorture test added later in
> this series fails without this change.
> 
> Fixes: a48669f0c49c ("srcutiny: Add an atomic Tiny SRCU")
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> Tested-by: David Woodhouse <dwmw@amazon.co.uk>
> Reviewed-by: Kunwu Chan <chentao@kylinos.cn>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs
