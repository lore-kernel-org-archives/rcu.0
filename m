Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A45229405;
	Sun, 23 Mar 2025 22:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742769104; cv=none; b=F3lXAg3LpDa75XibDADPXg9fVZm0vG7J56iPh2WIN5j4n2TfJB/p0t5Vt9hmBvnSSgRVPNUqL3eurQJWZc8GwZjzzHwGrEmzqmU4COJhivtz+MNdY7Eux7jRfk7AVTeWE2LTUS6GmUYkEA+WOmMnF2KLfqJin5y4dlFwNHUIHT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742769104; c=relaxed/simple;
	bh=M5qEdawiRuveSixGB/wzDFfDRdI3zKbpgZcdVcwWvVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PO/QEaek39GpA1OrGx+xjsfTW+YtkpyNU1uuniXucSsHu9SGT+0KxGk2siQHIP18TGQOmxUgZSqF0G7Emhbl/MriaM6oayO7xC8genQJubCHUBKIXLmgZkohWjxlgCLB4kjKs6TdHpC5Pkz7j7KFXyVrZ9WpmUbK7kTav8IeZcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LyB4/Mmb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LyB4/Mmb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77B01C4CEE2;
	Sun, 23 Mar 2025 22:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742769103;
	bh=M5qEdawiRuveSixGB/wzDFfDRdI3zKbpgZcdVcwWvVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LyB4/Mmb/Twl/MNwDwvzAD9Cwg1hQkZC/rKwyHN7cdWa5vsf2bSD/GObbPUpxly+H
	 UwTpBcKEkTzcvMyRTYwAdpjfubc0xcTAten97iajTDynSHfGyhwAG1q9zMXXS0QGH2
	 DsCwTvRKVPh6q7RTgNfOcXwss8gkE2/WOASoKxnYdWLEyGUCX8/3a7VahHa5O4SeDd
	 LSia4exPz7gBMkZ7cle1dpm+MdJt5WO4GXKIJGzVd1i4Dk2JUM/lWUSTteRQY0B+Ax
	 kLma/LVI7FHGGSfG2kBNqTmc+EtdM4RaMQoWXoTUyK73o4ljMMpIVAB1vYljwnK+gE
	 TBoydYMnG7dNA==
Date: Sun, 23 Mar 2025 23:31:41 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 2/2] rcu: Robustify rcu_is_cpu_rrupt_from_idle()
Message-ID: <Z-CLzTk0BPQ82bfY@pavilion.home>
References: <20250318135619.4300-1-frederic@kernel.org>
 <20250318135619.4300-3-frederic@kernel.org>
 <2a67f99e-7afd-499f-855c-69ecffd7c390@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a67f99e-7afd-499f-855c-69ecffd7c390@nvidia.com>

Le Sat, Mar 22, 2025 at 06:00:13PM +0100, Joel Fernandes a écrit :
> 
> 
> On 3/18/2025 2:56 PM, Frederic Weisbecker wrote:
> > RCU relies on the context tracking nesting counter in order to determine
> > if it is running in extended quiescent state.
> > 
> > However the context tracking nesting counter is not completely
> > synchronized with the actual context tracking state:
> > 
> > * The nesting counter is set to 1 or incremented further _after_ the
> >   actual state is set to RCU not watching.
> 
> I agree with patch, but this line is a bit confusing ->nesting is set to 1
> *after* the RCU state is set to "watching".  Did you mean "watching" ?
> 
> But I think you meant "After RCU transitions from a state of not-watching to
> watching' instead of 'actual state is set to RCU not watching'..
> 
> ct_kernel_entry():
> 
> 	// RCU is not watching here ...
> 	ct_kernel_enter_state(offset);
> 	// ... but is watching here.
> 	WRITE_ONCE(ct->nesting, 1);

Oh I completely inverted the thing in the changelog!

> 
> >    (then we know for sure we interrupted RCU not watching)
> > 
> > * The nesting counter is set to 0 or decremented further _before_ the
> >   actual state is set to RCU watching.
> > 
> > Therefore it is safe to assume that if ct_nesting() > 0, RCU is not
> > watching. But if ct_nesting() <= 0, RCU is watching except for a tiny
> > window.
> > 
> > This hasn't been a problem so far because rcu_is_cpu_rrupt_from_idle()
> > has only been called from interrupts. However the code is confusing
> 
> Agreed, and I could also see the existing code's snippet:
> 	WARN_ON_ONCE(!nesting && !is_idle_task(current));
> 
> .. not working if this function were to be called from non-interrupt kernel
> context.

Right.

I'll reissue that one.

Thanks!
