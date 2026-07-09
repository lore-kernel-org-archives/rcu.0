Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB70413220;
	Thu,  9 Jul 2026 13:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783604941; cv=none; b=mxxpv8xy+McnL0wJIaxt4f/A6heXZ34DvqbsJ7KoTJ/dvY9g33dP9opkokHRwPH47g0xamMVupz526KNdog04ZiziUQbaMCjBU1jbqZ1Q00Z25NbM6vVlS/hP7I6cm0+qiggg4J/Ai7R9VePVtDU6FIPDBy+R74QnfQzDjrccVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783604941; c=relaxed/simple;
	bh=eRMcAiOuqwRJ9E/b60wmYk87uBAXfk02+DExZWtKDFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSn15c6a/nEv/9g7Hn2XJQ9PPwC+kEm4KN1xlt8cfLm4Mvvv7c3pUE/AF2Is2OCEafd2pqDQyHlMn55mk+tbKWBQKR74mlfgUPiA8YXNQFD88ryuCIlMk0mPUBg0xKOt732VZTyoG1iKpTIDfIK+mkOL5BAvHp2hORa1HW8Ksfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOVzGtrc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOVzGtrc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5FDB1F000E9;
	Thu,  9 Jul 2026 13:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783604939;
	bh=eeVdWmPK2iRcl9KZ4593Orxhq2UxRdJT3z1nhO/WGzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SOVzGtrcs6/I1aTFaU8Nb6SK9PtITqFnn7E74dwpVKeMa1T3v4JQBPBiUVm3S+OCu
	 Mo8hoQvl6UGaMW8qq9cLVB84fch68lNctHJgHAapsskV9zbsfkH1HXXBGY48CCBIM0
	 CSicDs7d1/+a+BfOyrgidEXjU+2szj9t0Oeg2ucaVDXq2+HEnw8xzJMYF7JEpsdOA0
	 kqz8577/+UIcOEnvbCJqP/LZFaqf1Yw/wIhbcJL/C5JXel47oUF17odJMXOoc2IdnG
	 jTxwb+Zv2KPgSUDepxHbSj5CgFe1NbTFL6ZCWodgBO93sm/uw5gQj4o2QqCKb9VnyW
	 77avilrYcznvQ==
Date: Thu, 9 Jul 2026 15:48:56 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH v1 05/11] rcu: Add RCU_GET_STATE_NOT_TRACKED for
 subsystems without expedited GPs
Message-ID: <ak-myISHF71WaH33@localhost.localdomain>
References: <20260624132356.516959-1-puranjay@kernel.org>
 <20260624132356.516959-6-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260624132356.516959-6-puranjay@kernel.org>

Le Wed, Jun 24, 2026 at 06:23:47AM -0700, Puranjay Mohan a écrit :
> SRCU and Tasks RCU do not track expedited grace periods. When their
> callback state is checked via poll_state_synchronize_rcu_full(), the
> uninitialized or zeroed exp field could cause false-positive
> completion detection.
> 
> This commit adds an RCU_GET_STATE_NOT_TRACKED sentinel value (0x2) that
> these subsystems can place into exp to indicate that expedited GP
> tracking is not applicable. The expedited sequence check in
> poll_state_synchronize_rcu_full() is guarded to skip entries marked with
> this sentinel.
> 
> This is needed to allow rcu_segcblist_advance() and rcu_accelerate_cbs()
> to work with both normal and expedited grace periods via
> get_state_synchronize_rcu_full() and poll_state_synchronize_rcu_full().
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs
