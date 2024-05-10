Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795A612D1F9;
	Fri, 10 May 2024 14:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715350266; cv=none; b=auBHmpRdln4w6BjH1uXu600ww4laRDDaqAlE4+5EtIgS270m3RiOIcz0qFOvQOd5oaOb/m1m3D6/ZPWAkvizFW5D/FlTIL1EV4gU0PFamnROaD6AE3gvURo9jDjX32tIBefilmMu+vzUZlaVeouWqXzEF5QgW+vkrUnMIdF5GWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715350266; c=relaxed/simple;
	bh=wjUxPSTMW89KBClswX64bM+rAjzGGEFKiWOsJ850sZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hz0L3qvVsl/3RxlBpnmhkTKZ4bIyRWwd/15PDpXMkZOfkZrNOgNkXahqKhg1pO59V6JjmpvUvJGEbRbEdJMTtSqglOVZkOgmonkqyKtKdiyblgHg6g9G5crIWZdByZCJH5tTd3LX1S5oj3vEP0RoA0qzTZYf+Im97O/IiUENq4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TkcHxrTT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TkcHxrTT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9506C113CC;
	Fri, 10 May 2024 14:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715350266;
	bh=wjUxPSTMW89KBClswX64bM+rAjzGGEFKiWOsJ850sZg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=TkcHxrTTHfnOnE0M4aFK5HDY8QY5FicBJftqHLd+AWdFnP4yymUYgfYrG1OA5DAzh
	 09Z8zJQr1FBd0uYnULg3WakTx2a/ft+fAWvFnAX+O8JFyuvnhppKRD1YlZVNsklZNt
	 t6Tao9G6QUpwqCjoIBfZmidnC5XUysalSzed9jopbMjLEJMaDpRmrOdNiAmsDWULnE
	 FWu7XCFpwQTTXm6HjKVa2FBzBH2lfmJWhBX8LEMPAnE6BcdHaZBbO6cstPu6BSWL55
	 ch3XkOi5sUkwZeKqtw/4KHMiy22Lq6k3Vz7iKsz34C9VMMoS1IRYkkgZf+bbe30DN7
	 /VGjlk7H8AVXg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 826ADCE08A1; Fri, 10 May 2024 07:11:05 -0700 (PDT)
Date: Fri, 10 May 2024 07:11:05 -0700
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
Message-ID: <474ae55c-fe9e-4668-8f9b-23f819c76d10@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240507093530.3043-1-urezki@gmail.com>
 <20240507093530.3043-26-urezki@gmail.com>
 <ZjpAsYJIfzYSKgdA@redhat.com>
 <4c9e89b5-c981-4809-8bc2-247563ce04e9@paulmck-laptop>
 <20240510131849.GB24764@redhat.com>
 <20240510135057.GC24764@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510135057.GC24764@redhat.com>

On Fri, May 10, 2024 at 03:50:57PM +0200, Oleg Nesterov wrote:
> On 05/10, Oleg Nesterov wrote:
> >
> > On 05/07, Paul E. McKenney wrote:
> > >
> > > By the stricter data-race rules used in RCU code [1],
> > ...
> > > [1] https://docs.google.com/document/d/1FwZaXSg3A55ivVoWffA9iMuhJ3_Gmj_E494dLYjjyLQ/edit?usp=sharing
> >
> > I am getting more and more confused...
> >
> > Does this mean that KCSAN/etc treats the files in kernel/rcu/
> > differently than the "Rest of Kernel"? Or what?
> >
> > And how is it enforced?
> 
> I can only find the strnstr(buf, "rcu") checks in skip_report(),
> but they only cover the KCSAN_REPORT_VALUE_CHANGE_ONLY case...

Huh, new one on me!  When I run KCSAN, I set CONFIG_KCSAN_STRICT=y,
which implies CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=n, which should
prevent skip_report() from even being invoked.

Which suggests that in the rest of the kernel, including "rcu_"
in your function name gets you stricter KCSAN checking.  ;-)

							Thanx, Paul
