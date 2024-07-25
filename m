Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8E5199EAA;
	Thu, 25 Jul 2024 12:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721909894; cv=none; b=VmbkD0nfINjINBi28I5SE+deJhcbfYsI2hdxb4JvVYIvl4/Z8gvZm6KT/1gMJRfXWpBucUN4esiNRaPCGvX4w+wDzuL210d04otqz2S6vE5cSh6hSn2EgncEfVTrnuDUEajp0WtFFDfbqvVWe2fuLoydjJpHBHy36MFHt2H58Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721909894; c=relaxed/simple;
	bh=XYk3y42vu6cQnDVMFKfyCqKt03gsfCS///KeJwqx/wU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7WSpoJ4coAERXQ172pVePKXP35RgNu7Liv2b2jw7amd9nOWLhZPBXm1KbCvbixj4/EvOMNATObLA+znhEJ3NBj0rHvMfSo5ENCpVClCX9OBaPzerr1QqFUZCCBAkfW0Q+ANWeAs/4BHt6JcwmpilO+t+0/sKglSndu1wYP+p3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJv9Erag; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJv9Erag"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33288C116B1;
	Thu, 25 Jul 2024 12:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721909893;
	bh=XYk3y42vu6cQnDVMFKfyCqKt03gsfCS///KeJwqx/wU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iJv9Erag/7bbwvMle3ePs7L0H6rMLvGamMLimkyZjZRsSFLPzB4ManF4D1iGjB3Il
	 YEPcBT0SW4bMPHvl+kz5+EwID5ys07Xp0v0YvN3F0NLjhD+RTVdCSa1Ya34kAJjTyC
	 9d+G5mQEzt7yBX6GGLR7bCTY3a2Z2bj+IJOfCuemfOfgQR8KzJ1lw7cWLARmR77lWH
	 zaaFcsEbYdatotqz8z11eYwOI2hp6okfhuTVFZKVqqB16mwyuwgs+lzMjYGzmX7g7V
	 sP5ogpVr8Pvj+zqR5mhIutgeEpMY0YJCq4tgCviNrSxtsU+AtB3WQyLXBja6LrhW0R
	 rCT2Vaw5scMog==
Date: Thu, 25 Jul 2024 14:18:10 +0200
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
Subject: Re: [PATCH v3 17/25] rcu: Rename rcu_dynticks_in_eqs_since() into
 rcu_watching_snap_stopped_since()
Message-ID: <ZqJCglpZ-_YsGjqi@localhost.localdomain>
References: <20240724144325.3307148-1-vschneid@redhat.com>
 <20240724144325.3307148-18-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240724144325.3307148-18-vschneid@redhat.com>

Le Wed, Jul 24, 2024 at 04:43:17PM +0200, Valentin Schneider a écrit :
> The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
> RCU_WATCHING, the dynticks prefix can go.
> 
> While at it, this helper is only meant to be called after failing an
> earlier call to rcu_watching_snap_in_eqs(), document this in the comments
> and add a WARN_ON_ONCE() for good measure.
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
