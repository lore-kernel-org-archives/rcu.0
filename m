Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F391E89A
	for <rcu@vger.kernel.org>; Tue, 30 Jan 2024 00:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706575229; cv=none; b=Yg1dlrbGJNkk24WZQ3JTMsA6iLTmBGTdatXQtZIOqbEg+O4r/TxFZhrqvnysYd6bGAyPjQEwp+H5fNcWEPwUF73OKjfkmiXTHHuwbZmY2FAyMqOEYvMYa/lrTxV2mIKXlPeiSY7vRlq2h1hXkVs764UYSaaq70o1ycqia5NEaRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706575229; c=relaxed/simple;
	bh=sN4wU33gamjODQf60QJg3NJBo1vaoDX3noLyyGY+N9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJhIeM9uSmsfflvFJOcyNgkEzlOPloQiM0m9QvWsePJ00jJkLhzTzJhF/js+k8rE7qg7nP5NGNZGxTEd3UB6DZ1JS7JTk4bKTC4fJ8t+oTNZ1oN6guwEY3rNsmvy1fIwTsov7kleqgbXWTxoJ89/YNBnSTjGF3hBZGZBOSe/kJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxc1rp30; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxc1rp30"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20515C433C7;
	Tue, 30 Jan 2024 00:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706575229;
	bh=sN4wU33gamjODQf60QJg3NJBo1vaoDX3noLyyGY+N9Y=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=lxc1rp30/WCTdzc91S/MBnDJnTL4n9gUZWFmcONlVQb6VE3utcijp40CYxIeNmIE2
	 Kv3FHNzEThAe6rWJuSLF6PZq9a+zpD4558dR8YgdMkbnHskMw08L6SPQhzTiFzdLWJ
	 V/fHBHHgKwYlmM+cgeek77b080z7Q2/KOnuB+RmO555Y0MRfU+txK2HvBalMP22KZo
	 4Zrj9uxXG9DkNwcccpKzZyqXzW1sngRjILetuysp+NNP0cuyYnvu6koQwTmaBOmIix
	 LpQncnCjiUC2/MahfZpvhYa/cJQmcHQ7BPzHqFp6VlO5CVxtdt5tbTMljTJuPw/Edb
	 MfAapvOi0YQvQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B83F3CE0B02; Mon, 29 Jan 2024 16:40:27 -0800 (PST)
Date: Mon, 29 Jan 2024 16:40:27 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Joel Fernandes <joel@joelfernandes.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Joel Fernandes <joelaf@google.com>, rcu@vger.kernel.org,
	"Cc: Frederic Weisbecker" <fweisbec@gmail.com>
Subject: Re: Observation on NOHZ_FULL
Message-ID: <39fb0feb-27ec-4b25-9205-11fd5901d00c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CAJWu+oo8w6zc=m7f9vkz66xYZnoCqs1FrgmLtcWxEpE5QCJgig@mail.gmail.com>
 <ZbgPL0Rg_on4kOBf@pc636>
 <b6672b7b-fed4-449b-90e5-216f8294c1c3@joelfernandes.org>
 <Zbgp_JJvdczGccV3@pavilion.home>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zbgp_JJvdczGccV3@pavilion.home>

On Mon, Jan 29, 2024 at 11:43:08PM +0100, Frederic Weisbecker wrote:
> Le Mon, Jan 29, 2024 at 05:20:23PM -0500, Joel Fernandes a écrit :
> > > If i do not miss something
> > > the NO_HZ_FULL will disable the timer if there is only one task on CPU
> > > so that running task benefits from not being interrupted thus gets more
> > > CPU time.
> > 
> > Yes, that's right. I believe it is well known that HPC-type of workloads benefit
> > from FULL, however it has led to want to try it out for constrained system as
> > well where CPU cycles are a premium, especially if the improvement is like what
> > the report suggests (give or take the concerns/questions Paul raised).
> 
> I'll be unable to suggest anything related to that Bogomips calculation but
> I must add something about HPC.
> 
> I have long believed that HPC would benefit from nohz_full but I actually never
> heard of any user of that. The current known users of nohz_full are workloads
> that don't use the kernel once the application is launched and do their own
> stack of, for example, networking, talking directly to the device from
> userspace. Using DPDK for example. These usecases are for extremely low latency
> expectations (a single interrupt can make you lose).
> 
> HPC looks to me different, making use of syscalls and kernel for I/O. Nohz_full
> may remove timer IRQs but it adds performance loss on kernel entry, making it
> probably unsuitable there. But I might be wrong.

Some IBM clients made use of nohz_full for HPC workloads, and claimed
to see significant benefits.  (Single-digit percents, if I remember
correctly, but still...)

							Thanx, Paul
