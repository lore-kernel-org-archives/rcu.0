Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEF0186A;
	Tue, 20 Jan 2026 00:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768867656; cv=none; b=MC7SS5fw8283bNjePTKyG7wjKBdXEUKCRGCOwtPKzDpmoPX2DpczvAtqvF51lCny3TIIp8u5ZrY0QuRZV/onv/eRqnexnGTTIdn+R1fNss1R/ESk5YaTBrdcUQXbo+8W572Pio9zB+nH8GunKVX/2ebf8rKGu++lpaO1glENUqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768867656; c=relaxed/simple;
	bh=VGVnPdVnoCWv+tGq6yfSvbHFQlqR4mKiZMmPbhwFbl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QSXHhtOnQK3FBo7oMk4KaCJc4Ur/wcLwDu4SeDDaiP9RuaCNTiBJIbhrJNQP9jGUoFW6ucGJV2w1XWe+1V8CvdFh/K4Lsia2+Yr6Wf2pJc2fhd9P98U0W5AeSNU09Uh1ZYdOOew+dgKjpo9JbcI9ukjlWtjlXLPq5CKLlwNzc18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uicOfMoY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uicOfMoY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 383EFC116C6;
	Tue, 20 Jan 2026 00:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768867656;
	bh=VGVnPdVnoCWv+tGq6yfSvbHFQlqR4mKiZMmPbhwFbl4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=uicOfMoYB3ua5it4JTzrjL1RQIW5gcYp9ukVEhzonwaSlFDWgPznxFsdyjKAyIiav
	 5jbnj/PDUsrtclHUEFFNjzp5hPKK8Kq53Mtaj+68sIKFj4lOwVsOs9z1awdvjB1rz4
	 b2D4z1g6qGmkt4m4MuJM+GqIaUY74G8tdDygreYeo+cbMhxKWwLn8jBPjBcGlOBAo1
	 TtO3IXq3tUD++IsOkBc5qvn2JhtrRzPdoNdRYGJdMH05Ulv3DBxdi3n+IGYAsPR/Hj
	 Lb8vkHuArPWr5NTy9m+yvdEH1eI4x4IrzEGsKELjZbzf4ZdE2/kdFsPPEeQf+YIJHj
	 0FfO0V2BUze3w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CE9EBCE128F; Mon, 19 Jan 2026 16:07:35 -0800 (PST)
Date: Mon, 19 Jan 2026 16:07:35 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org,
	Boqun Feng <boqun.feng@gmail.com>, rcu@vger.kernel.org,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>
Subject: Re: [PATCH -next v3 2/3] rcu/nocb: Remove dead callback overload
 handling
Message-ID: <3d6e5ca7-5944-4add-90d5-97b672447b5e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260119231223.989409-1-joelagnelf@nvidia.com>
 <20260119231223.989409-3-joelagnelf@nvidia.com>
 <aW7D9ghPFdplSBII@localhost.localdomain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aW7D9ghPFdplSBII@localhost.localdomain>

On Tue, Jan 20, 2026 at 12:53:26AM +0100, Frederic Weisbecker wrote:
> Le Mon, Jan 19, 2026 at 06:12:22PM -0500, Joel Fernandes a écrit :
> > During callback overload (exceeding qhimark), the NOCB code attempts
> > opportunistic advancement via rcu_advance_cbs_nowake(). Analysis shows
> > this entire code path is dead:
> > 
> > - 30 overload conditions triggered with 300,000 callback flood
> > - 0 advancements actually occurred
> > - 100% of time blocked because current GP not done
> > 
> > The overload condition triggers when callbacks are coming in at a high
> > rate with GPs not completing as fast. But the advancement requires the
> > GP to be complete - a logical contradiction. Even if the GP did complete
> > in time, nocb_gp_wait() has to wake up anyway to do the advancement, so
> > it is pointless.
> > 
> > Since the advancement is dead code, the entire overload handling block
> > serves no purpose. Remove it entirely.
> > 
> > Suggested-by: Frederic Weisbecker <frederic@kernel.org>
> > Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> 
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> 
> Would be nice to have Paul's ack as well, in case we missed something subtle
> here.

Given that you are good with it, I will take a look.  And test it.  ;-)

> Also probably for upcoming merge window + 1, note that similar code with
> similar removal opportunity resides in rcu_nocb_try_bypass().
> And ->nocb_gp_adv_time could then be removed.

Further simplification sounds like a good thing!  Just not too simple,
you understand!  ;-)

							Thanx, Paul
