Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA3A1A4F3C;
	Mon, 20 Jul 2026 14:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784557357; cv=none; b=p8YkH1UJeyT2mPWVXZLOpfG3TcK6FVQI4xiD8utWasYdRG1R1Vh6cYb1JbfErfogPytWM0nQiNQRNbj/tSiyr/COTQLew0ispxdI7aTmUpdXVPNTauFi2KR6bVOTKnmtQ2SeNdVWEUYzQRaldhZhMUGj8B06lmUmreds9JoFB24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784557357; c=relaxed/simple;
	bh=e4ShkY0fOjmYMLTXJuuDIB0nO1MlwzHCy3DlP6ePVY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMNfb1S7ywJWjbHqL3PuIP4ymcPZJu03GCxdmkUlT/NOzIc97ll4ZmYzhlqU2tPKo/zlLGgBAJeMA/w3LiEtGk8zF8U0apeyIshUq7VWxsi3o5RiB7FfjxJeV8PiueztDsG5M7oefvvDlJpJ8pid5JFEWQwj20ICJqqr6p4Nz5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZcySVioV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZcySVioV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E331F00A3A;
	Mon, 20 Jul 2026 14:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784557356;
	bh=Pg4VEI11tL6cZaF+rCWtAkKHA9kf+Lq96Oz8E8WHg1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZcySVioVpe1Hs66nBttwzLNP4f6A985e0K3kGxWzMCqjM2ajt5M4OVaIfHIic+Pzs
	 iE6H09BZYvKAE1d9A7uYvrFDyEvBcX5DyAl3JOpkLHCVBQ6g+nVEq5jO4ammP2S7XS
	 LIKjt80PE0+Jw1xyEt0tHlv/2d5pjL64y8RHgrqEYtMqP64HsvlsH4LMORVTjyiemJ
	 IlRl85jhV9AG2YzDe9LkzzLZZNUXXw/uKORmN2p2YPAXJvPRH1hJNIPLNg7raXTL6r
	 rAHc2DXLvD97Rl9AD/DeiWidWCPz+8RVckfY8z477Qk9FoLTTJb0k6uW9ffstTGQJq
	 mneM0a5s9w+YA==
Date: Mon, 20 Jul 2026 16:22:33 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Puranjay Mohan <puranjay@kernel.org>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH v1 06/11] rcu: Enable RCU callbacks to benefit from
 expedited grace periods
Message-ID: <al4vKQ02tBYyYANk@localhost.localdomain>
References: <20260624132356.516959-1-puranjay@kernel.org>
 <20260624132356.516959-7-puranjay@kernel.org>
 <alD6o01ukyliCS37@localhost.localdomain>
 <6c683413-8e8b-4888-ba01-9d79c3867432@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6c683413-8e8b-4888-ba01-9d79c3867432@paulmck-laptop>

Le Tue, Jul 14, 2026 at 11:48:08AM -0700, Paul E. McKenney a écrit :
> > I have similar concerns about the three smp_mb() in
> > get_state_synchronize_rcu_full(). It could be just two (rcu_seq_snap()
> > has a barrier that could be just one). Not sure if that matters but,
> > just wanted to point that.
> 
> We need the one at the beginning of get_state_synchronize_rcu_full(),
> but from what I can see, not the ones in the calls to rcu_seq_snap().
> I blame laziness.  We could make an rcu_seq_snap_no_ordering() that
> didn't have the smp_mb(), but I didn't believe that the overhead would
> be visible at the system level.

It isn't so much about performance than being clear about ordering
expectations. Though we could argue that grace period polling can be
about performance.

But in general rcu_seq_snap() advertizes:

   READ seq
   smp_mb() /* Above access must not bleed into critical section. */

This doesn't tell much. Which critical section? That's not used on
read side.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs
