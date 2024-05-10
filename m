Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C05F12D1EA;
	Fri, 10 May 2024 13:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715349532; cv=none; b=u3MfLdWjPHUv8m8D+n3/6NRdE5z9AAai71e2aJL+JV1QiT0/tWmHnY5a5U9Kt7n5j9mFM3kc5UyttaByp+isUyvKvEDMTC/CX1XwtthlQJ6riB19Y4U0UKasmwZ7r66d8FryFBTyMJljOsCcKaODFSB6hA0PHk0McaPjzNgFfMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715349532; c=relaxed/simple;
	bh=0XXEEUOHL+7LPrufiDcnpSkHL/Ern7h0quNp6zLZrYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jeFYgnSvsV9thS5XeYbtsy+/vYQW8URpu96zx+KXcf63j8jOZq+KB5YVpVUMECeT5YeF4HkNQFWK3aK7sPf9bguMxXjXThlMLkS8I1JPV6GDCH+pqIdCn7YfCmJ7pRD+6MQWSbzHET5h86YdWbpr3DObe7/r1E/gpONutKZc8og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MuFSyZk5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MuFSyZk5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC769C32781;
	Fri, 10 May 2024 13:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715349531;
	bh=0XXEEUOHL+7LPrufiDcnpSkHL/Ern7h0quNp6zLZrYE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=MuFSyZk5SjDsq8v/bjji8pooG9FXGqiCY870znRYVx9HRkJmqmt6zGxA3rbq7NKNv
	 cwPj+IWVcMj6p9BFG06Zz6tcMeZSdZZKrzVBPGAslrvqOe+3NPi3jKiRwdoavJwW2a
	 3omvWOnDK+K0uIlBVz5/ZG/5KyNOoDSQXK90IwUljTJpYoXv8BUobIpCDCE1aeKaGN
	 miV5OCf3ZEwNQANllbNv0LAjeqdxq6dPVlgN7nWjUhO4CNrJlBhiy8jkn4RHCfJ63p
	 6JzQmEWOl7yvBtADrX5zOqeeTIQTQJSWVoamDaEW6j6mN+SUA8TQtJrA6EAA1ipJnq
	 KFXi2tebFVkbQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 661DFCE08A1; Fri, 10 May 2024 06:58:50 -0700 (PDT)
Date: Fri, 10 May 2024 06:58:50 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 25/48] rcu: Mark writes to rcu_sync ->gp_count field
Message-ID: <25a55ddc-caa0-4b5d-baa4-87782e0a002c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240507093530.3043-1-urezki@gmail.com>
 <20240507093530.3043-26-urezki@gmail.com>
 <ZjpAsYJIfzYSKgdA@redhat.com>
 <4c9e89b5-c981-4809-8bc2-247563ce04e9@paulmck-laptop>
 <20240510131849.GB24764@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510131849.GB24764@redhat.com>

On Fri, May 10, 2024 at 03:18:50PM +0200, Oleg Nesterov wrote:
> On 05/07, Paul E. McKenney wrote:
> >
> > By the stricter data-race rules used in RCU code [1],
> ...
> > [1] https://docs.google.com/document/d/1FwZaXSg3A55ivVoWffA9iMuhJ3_Gmj_E494dLYjjyLQ/edit?usp=sharing
> 
> I am getting more and more confused...
> 
> Does this mean that KCSAN/etc treats the files in kernel/rcu/
> differently than the "Rest of Kernel"? Or what?

Yes.

> And how is it enforced?

By me running rcutorture with KCSAN with the Kconfig options listed in
that docusment.

							Thanx, Paul
