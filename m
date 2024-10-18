Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B83E13A244;
	Fri, 18 Oct 2024 21:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729285822; cv=none; b=OmMKGdmkanHjJbNpbU21rQnuquZyJyuZNgoSD8ONXEPDrS58syDpTQVEhvCoMqA8hU5jeAKxmpAb9rBSOc5dQSEgUnOfWHktMcHmOhLQ88gpmi4FaiwB1iNkxLJiVN53nLQe+phPDJZKMff0m6rH8hnxEfbBSO+qJcoV+gPexg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729285822; c=relaxed/simple;
	bh=sDLVES6Qpp5v9wZpIWk49SzdhUbTPBMmUtLjZBfD5ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icfbP7HoQJP0p0cOTr9/clsE/cxCEq3duhlzr6pQ5xNvVWq59BCLXSHkA5SCNoln3YIrLQuIUXjXnQI067/71XnSa4RxSn3/lLEyDjA/i3pu1ZPIlXZsQIr17LU53OW2wNt/yP2IixqaKjBoU8QHNtS6omWtSFtyVeei/TV2nxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFKp3L6t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFKp3L6t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4E4C4CEC3;
	Fri, 18 Oct 2024 21:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729285822;
	bh=sDLVES6Qpp5v9wZpIWk49SzdhUbTPBMmUtLjZBfD5ng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dFKp3L6tvF/jmRXDSdq97OMjRN8cpyHuU7ci4r/7/O1iBh/LOi4WsTSAkIqfF1ks6
	 kwXyQKbW9Q+xNuWQbXfcvE9kLMYU9l6UbYP6hla9zqODmm11Sp8EOUS+v6qPJFQyQ7
	 O30I7NpX0oLk/UUePL/qBsUTkL5t3lf/yBKyCOHeLW+QUWGxhWbY4XwQFBSQT7iWyL
	 BzMirrkUiPoAU2vpIJ+8KKZMn9JQ2zSzrX9Vv2scXPPMuaFVM6muDXdBA0BWqpFD29
	 dw9553bCpeCQLWvPiSc5VFIqjpZqycxPrLGfeR60Fak9mCscdsT4/trOoJF5xn4NXS
	 87kb+53gShDpg==
Date: Fri, 18 Oct 2024 23:10:18 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Michal Schmidt <mschmidt@redhat.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/srcutiny: don't return before reenabling preemption
Message-ID: <ZxLOut9zT_pfBWAO@pavilion.home>
References: <20241007101415.466155-1-mschmidt@redhat.com>
 <6c9dde7f-271b-4342-8ce9-8f363b341c0d@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6c9dde7f-271b-4342-8ce9-8f363b341c0d@paulmck-laptop>

Le Wed, Oct 09, 2024 at 10:19:01AM -0700, Paul E. McKenney a écrit :
> On Mon, Oct 07, 2024 at 12:14:15PM +0200, Michal Schmidt wrote:
> > Code after the return statement is dead. Enable preemption before
> > returning from srcu_drive_gp().
> > 
> > This will be important when/if PREEMPT_AUTO (lazy resched) gets merged.
> > 
> > Fixes: 65b4a59557f6 ("srcu: Make Tiny SRCU explicitly disable preemption")
> > Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
> 
> Good catch!
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

Applied!

Thanks.
