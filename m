Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C696AA93A;
	Thu, 25 Jul 2024 12:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721910747; cv=none; b=RBniJstDrN8HCQmom58sj5uZYevZv569NX4HJXBDUSzasBqAolhYMepOgbzLWtWbo67V+fL1f5XhP29KfnPhy0exjNjWZu80r5lqfKOODSkjQNSWcdWY8LEx20ph5Z9lBHmVD+rr6wlIWMGjOwycWStoLtkeWgNsZHisxLbtNRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721910747; c=relaxed/simple;
	bh=IlVUQnBfI+tK2Ugzsl+I4CGCrhCC9yDN0Rz9CTi9/6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o6APNEvSdSek63r4Qlppysdc6SXTt4m1u80kIxN2Q89sIcvZAmaeIf8rYQrXyDRex3UGun9bTS9gIvLb+k+T6R++CCzZ44+RuxPX8IREA7eiKfIPZuOpXq+HpjNCdWeTdOJiU5YuTuZLvhil6NOTNUMOa3Yy0mIQN/+/mimgKtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVs7dkUc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVs7dkUc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D14FC116B1;
	Thu, 25 Jul 2024 12:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721910747;
	bh=IlVUQnBfI+tK2Ugzsl+I4CGCrhCC9yDN0Rz9CTi9/6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EVs7dkUcHPL4h0NXk1aGQC8gb8svZjVjUUtCU1+OrrRK7HtL1xuavkdXFywXV02jk
	 dOan+znK+IzxgqGo5ol866bTEeT7hpqwUoUwoucvLKn3EfAMJwp4I9ofGJruAuSCTh
	 Fats8ec8YbtF+p1jyB2YYH9HVjKFeNzQRVTfu+VWUFKRYbT+4JSBRQuDV/AG5/Fpio
	 mwl/OyfRepLDuAYrA1jQ/kQhNTttU+QOd4fS5JaFu4Ti9x8BuuVC6+H7t0zAsfszgJ
	 TQBTqp0j8dpkn5DR0GOJnOQiZLKPSnNiwiw5mSP+DMlUUOHnUpkSYHKKOoJf7Us+ry
	 DkdUkneDHikNw==
Date: Thu, 25 Jul 2024 14:32:24 +0200
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
Subject: Re: [PATCH v3 24/25] rcu: Update stray documentation references to
 rcu_dynticks_eqs_{enter, exit}()
Message-ID: <ZqJF2Ev4QIWbR-Cq@localhost.localdomain>
References: <20240724144325.3307148-1-vschneid@redhat.com>
 <20240724144325.3307148-25-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240724144325.3307148-25-vschneid@redhat.com>

Le Wed, Jul 24, 2024 at 04:43:24PM +0200, Valentin Schneider a écrit :
> rcu_dynticks_eqs_{enter, exit}() have been replaced by their
> context-tracking counterparts since commit:
> 
>   171476775d32 ("context_tracking: Convert state to atomic_t")
> 
> Update the stray documentation references.
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
