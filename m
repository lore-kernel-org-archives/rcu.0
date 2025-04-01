Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7712040B3;
	Tue,  1 Apr 2025 13:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743514705; cv=none; b=nYIHlM67Yjt7/E5PzfVXmn3PtrmY4JyVbScBApCOBsDFwlSaAtk17cCJrtkbU8D/NlhkMASVvetmcsHZl8ZuOcKAWYo/w87NFMhJ9aEBgvns+tTrrU0y1KGOhW9Ji7iZ8unvcTIa14DHEM9oESAkRLpxmpwBqn0q6RDyxU0Aqiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743514705; c=relaxed/simple;
	bh=eMzqZZ4ouB/A3Kai+sS0srkKVYuWZO2KoLUK8DItKmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdlCnZW+2I7WqmF0kRca+p4hFPGUdfp3IsRM9TNHkIC+NvZER5S5tR6xa0oVPt2ZmTi5Zqb/YsbeVpamoeoyiWPUaCpHtGDnCUcEN5tutbuPg7z7ROo5XcQXJBjIAbBAjJxU9/z1uUX486UzOFv9pD46fCm1XOvHT1jnbshP56I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M97X9m0N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M97X9m0N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7256EC4CEE4;
	Tue,  1 Apr 2025 13:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743514704;
	bh=eMzqZZ4ouB/A3Kai+sS0srkKVYuWZO2KoLUK8DItKmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M97X9m0Nc6Ewz9A8s6nsQyyQa8ZIJk1nAodpQkDMnNLGAshdW1Pa0B4GhQA+au36+
	 HwEqhkGZ9cvnRn4FT2vT33wtP2+AlKAC3FBEz1YFR2FW9bLxEfh01I0T9nOdYuGyAR
	 wCWr2nzYEW2dWS2fvKIyF4dF4Uqlohijs71FrTf1W0Zkr0v7qWgD8l+uMObt8Zadel
	 98d44G4pbcuAw5HplXgT1AI7dgNZTP4lMDZk6uvFvyAV5NZfFpmzYVFN3Bp4j7712v
	 WTBZjhY/W85wyss5w/jcphZLDDtBiC5lW9ZQV6ah0oCytYDjR4m4NiYtOf0f6ApLCO
	 +1OqeAwVMW9qQ==
Date: Tue, 1 Apr 2025 15:38:21 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: Re: [PATCH 1/3] rcu: Replace magic number with meaningful constant
 in rcu_seq_done_exact()
Message-ID: <Z-vsTRydjIAK-4-d@localhost.localdomain>
References: <20250324170156.469763-1-joelagnelf@nvidia.com>
 <20250324170156.469763-2-joelagnelf@nvidia.com>
 <eeda52c2-5397-4aad-ad01-ca04e5b0b80f@paulmck-laptop>
 <DDDD275D-1017-4189-9A8A-578021A33B4A@nvidia.com>
 <e47e5611-36de-4d12-9c07-57aa2a885299@paulmck-laptop>
 <Z-nBcg9FJqu5RzME@pavilion.home>
 <71fc9642-5fc7-45ec-8196-8fc89ed8e765@paulmck-laptop>
 <Z-sFonl2NrppdGQS@pavilion.home>
 <bc4d930e-60c2-4ff8-8995-d463b6365b00@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc4d930e-60c2-4ff8-8995-d463b6365b00@paulmck-laptop>

Le Mon, Mar 31, 2025 at 02:29:52PM -0700, Paul E. McKenney a écrit :
> The disagreement is a feature, at least up to a point.  That feature
> allows CPUs to go idle for long periods without RCU having to bother
> them or to mess with their per-CPU data (give or take ->gpwrap).  It also
> allows per-rcu_node-leaf locking, which is important on large systems.
> 
> Trying to make precisely globally agreed-on beginnings and ends of
> RCU grace periods will not end well from performance, scalability,
> or real-time-response viewpoints.  ;-)

The distributed disagreement is definetly a feature. The duplicate root
is more debatable.

> But simplifications that don't hurt performance, scalability, and
> real-time-response are of course welcome.

I'm not even sure my proposal is a simplification. Perhaps it is. Another
hope is that it could avoid future accidents.

> Indeed, this probably needs actual performance results showing that
> it is needed.  My guess is that only systems with a single rcu_node
> structure that is both leaf and root would have any chance of noticing.
> And those tend to have few CPUs, so they might not care.

Do you have any idea for a benchmark to test here?

Thanks.

> 							Thanx, Paul
