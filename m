Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8522C61FAF
	for <rcu@vger.kernel.org>; Tue, 12 Dec 2023 13:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sr2z4XKn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84000C433C8;
	Tue, 12 Dec 2023 13:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702388053;
	bh=CqD7IvbERxZ4/wzm3/NaR3i88J3fRY8NtJmzJVhqbuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sr2z4XKn/aPC45t6yzfw/5ANpdcntjra1JlEe+dVdQALiIXKTxl9CYMik8zyrEeLy
	 aOqknl3OCYMDn/6MU8bImm7VxV8Mq2zX6fTIRq3Bs5j7mZIS2ro7ovgI+tevmNDR/j
	 I4XWTpOs8r6XFJCi3EawQtyjrsa7DeFGSANw/D+64p6l3dQnvZyVflWmfMVvEk5X4k
	 00rmfWhg5BizqbGIWASqEewyT4HeniudXpNj4ZFt5H80uw20cgpfg6ywns8LuBvWJj
	 AQbyDXSwdEtbi+xZ8ztk6BOLARaaS2eAtigUb/9ID8hE+PyPvnNB7QdNHtZjI6y09J
	 uIRn1xlAWKZhQ==
Date: Tue, 12 Dec 2023 14:34:09 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 0/8] rcu: Fix expedited GP deadlock (and cleanup some
 nocb stuff)
Message-ID: <ZXhhUSmHl63Gp6EG@lothringen>
References: <20231208220545.7452-1-frederic@kernel.org>
 <0be847d6-804e-4f9d-9eb4-beee9efb6c78@paulmck-laptop>
 <ZXdrNJFCaXAFMITp@localhost.localdomain>
 <c429620e-53ab-4cd1-b1c2-ca83f4f3cea7@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c429620e-53ab-4cd1-b1c2-ca83f4f3cea7@paulmck-laptop>

On Mon, Dec 11, 2023 at 01:39:40PM -0800, Paul E. McKenney wrote:
> This one passes TREE01 and TINY01, but on TREE09 still gets this:
> 
> kernel/rcu/tree_nocb.h:1785:13: error: ‘__call_rcu_nocb_wake’ defined but not used [-Werror=unused-function]
> 
> Huh.  I suppose that there is always __maybe_unused?

Looks like a good fit indeed!

Thanks!

> 							Thanx, Paul
