Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C902AE7A;
	Tue, 21 Jul 2026 12:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784637940; cv=none; b=SXINq7JL0P6gyDN+xkglNrMKi1A9d1+q5EBejjzB+lmn33BzVayQ733oFvz2xuUPEkyyqVnL8vfl0lcbB+OSU6kflIYe/eYgAEEVnl76qmDTYrCwSheShOmROUgLXBvP4umoCVEx95f09z8SmY7hvT7uTAASQf8jXQ8Bmcckrj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784637940; c=relaxed/simple;
	bh=aaMkhiBFiu17GatSYEse632pcGcTPtmuR9L5kOmooYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b3c6n9EkyWHvcHnlSTwdR4NY38ihNZiMFA5rZcjfRhLygVHZbG0N/8xb6nwhysrDGVkTZz2fpKHOeQG88gyBa4yDS+pvGr3xUhNbxmUDPOrGOTPVYBsHdsdG9n/bUM83YOn56Zq78pOlrilhgbZcMWKyygbdnp02ZY5FVztTRTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STzXpxaB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STzXpxaB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA191F000E9;
	Tue, 21 Jul 2026 12:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784637939;
	bh=Ik7QVHXZ9oKI0kQC0nUb8YwWvsgFy3i7X6oSkaDdGQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=STzXpxaBVIH8F7QTLuysIYMtLR5v27J8uz3Z7/F/M4cYEXDpFBA45djy2+MNFNBQ7
	 RBTXhYL/jDgYlQcG9Wrt27A464ACvecKGTDhoA2BFxS6FPI0W/Wz3dwXQjskgSvJSp
	 a8EtVIhJlKhVYYkKlsdy6jt7/wfyRR3sxtfPfM/twmg1LhilLtsAl4VXKd3Z1rRUL7
	 I/QGShik0qNuJUoKfMeydL+3NMD6DRyyBOPORH8y0QvFUqJ5AzGrOfsLBW7uUeTeig
	 2yOuONgLlaCpr2ojJkimFzpXttbzkptal2CgyVe/+j06dfTu0QsncEFuVZHZmiyr+m
	 FMmq0tX3ZZyXg==
Date: Tue, 21 Jul 2026 14:45:36 +0200
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
Subject: Re: [PATCH v1 09/11] rcu: Detect expedited grace period completion
 in rcu_pending()
Message-ID: <al9p8MrcEdByrjfh@localhost.localdomain>
References: <20260624132356.516959-1-puranjay@kernel.org>
 <20260624132356.516959-10-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260624132356.516959-10-puranjay@kernel.org>

Le Wed, Jun 24, 2026 at 06:23:51AM -0700, Puranjay Mohan a écrit :
> rcu_pending() decides whether rcu_core() should run on the current CPU's
> timer tick.  It does not account for expedited grace periods: after an
> expedited GP completes, a non-offloaded CPU's callbacks remain in
> RCU_WAIT_TAIL (not yet advanced to RCU_DONE_TAIL) and rcu_core() is
> never invoked to advance them.
> 
> Detect that case via rcu_segcblist_nextgp() combined with a new
> memory-ordering-free poll variant,
> poll_state_synchronize_rcu_full_unordered().  This keeps rcu_pending()
> cheap: it runs on every tick that has pending callbacks, so it must
> not pay for the two memory barriers in
> poll_state_synchronize_rcu_full().  The check is only a hint to run
> rcu_core(); the ordered re-check and the actual callback advancement
> happen there.
> 
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs
