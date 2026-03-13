Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB33E3CAE96;
	Fri, 13 Mar 2026 17:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773423854; cv=none; b=tKoAJxIEA61KCZdzQeho9NiZTRUS7wfsXjXo59VWz56IrRvCwlbWusxjVyqu8A9c9XD0L5EojC9jUXMk/FAai40eDv8zVGP/ay4xNMfaR3zEOf5ZD79CjJ/m9B8+n6CY3D7zB2ex9c7rqTN+QCgw2Dfegc+KBiUI7rv/zOq4czQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773423854; c=relaxed/simple;
	bh=7vuf1+8ordyeq78+MIYdCekwu9lLhQ8kPMp971gXp7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KfyrUF5RjKYkP0SfHx5Vy3ny+nt3NLWoQAAYnRPoxFrhCs69blrXmfahLBkCwqEpSqB41JhASdKYI4zSOxCkzCPym92HUNV3SddWTI4cHTiOEOJW57vDRXMtpJeJ0HNh6PWunfkrnFqJHQFtfFfV/S4Za87YExnqbFyFMACDpfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=v4u846I3; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="v4u846I3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DkoCYKnA1t0f4+SjA9bMNxH6lOUsyJg63clTeyhGjRc=; b=v4u846I3MNVuWstBK12xVaEBJ8
	t5yEWNChSO27O1BJq+miZByFDfy+9KZjedD/IhrP5fnurDaSexaPxlvnCMaMSrn7rddpqukPmIs6M
	OFrjPt0x4sssiWIIIX3XKABEb5SuWm8Peg5VrrjG2JFvaRLEJp0HlCViEHmi6en5PVAS3QSX2EVLu
	NzfMJ5MjC264VzxQoqvEAmkSSGC5+fSaozH60JuhBBlw0iq3k7LqF623WyGLxieadWtmFZdZHJR6Y
	fkVSp1qfLjfa3JvEpgtGoGZW3+NxJLUsGyWO9wCvY/DfY6yp3fzsfaPywNR4pJvkiUmHGnl4hJCZ8
	qfYaFpdQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1w16YI-005UcS-Lz; Fri, 13 Mar 2026 17:43:58 +0000
Date: Fri, 13 Mar 2026 10:43:53 -0700
From: Breno Leitao <leitao@debian.org>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Add BOOTPARAM_RCU_STALL_PANIC Kconfig option
Message-ID: <abRMwB-Zens9vbt1@gmail.com>
References: <20260313-panic_on_rcustall-v1-1-a4f8fe54a4bd@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313-panic_on_rcustall-v1-1-a4f8fe54a4bd@gmail.com>
X-Debian-User: leitao

On Fri, Mar 13, 2026 at 09:56:49AM -0700, Gustavo Luiz Duarte wrote:
> Add a Kconfig option to set the default value of the
> kernel.panic_on_rcu_stall sysctl, allowing the kernel to be built
> with panic-on-RCU-stall enabled by default.
> 
> This is useful for high-availability systems that require automatic
> recovery (via panic_timeout) when a CPU stall is detected, without
> needing userspace to configure the sysctl at boot.
> 
> This follows the pattern established by BOOTPARAM_SOFTLOCKUP_PANIC
> and BOOTPARAM_HUNG_TASK_PANIC.  The runtime sysctl can still override
> the Kconfig default.
> 
> Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>

Tested-by: Breno Leitao <leitao@debian.org>
