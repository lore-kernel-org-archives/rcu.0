Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50219480978;
	Tue, 21 Jul 2026 12:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784635610; cv=none; b=Ias9my1S4NE8tJ9Vx6mOZow/Q1ybynAOO+05F8YQnxKBo0YF9BK41a/cu6vohJyzKu3shUVsaneKhiMBYHwNw9yA0L3uqdvUBhPa5xF0go6t3JNDNV2a95jIdqgfhp1vLMp7RfZiCVcCVFFaA1syQtO2tZzrb4EQz1d8w3kr5Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784635610; c=relaxed/simple;
	bh=0xTjoRQ1Wr1zypivmWlxZfm7mUXFCPaCT2D0d/7viTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHKpnmy2Bq2PKcDQFVnAqunN0zkYOqDyTH1caa+eNj0e9dCSioyECzYCAHR9mOzzDgiWBks4c3w48bpaHWwyemthbrUfIMFO47S22VkEgjlw7e9vCndYNzwbl4l7DFl0ZigTNH/g2Gy28Ep2NzE4tpmXiSLXMdam8r8qRUYpqSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=crzaN3CN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="crzaN3CN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 514281F000E9;
	Tue, 21 Jul 2026 12:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784635608;
	bh=61jYVANBvB7v2o9ArsK0xxnnG5wRNzmTKO9igEhginc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=crzaN3CN0wKTWsuSiGgX2ronFs+TT7Q3dPUCpvUZz0rv53yEkPW8FrPVwLL5i+7NY
	 Ly6cILTrD+NaGBxyoWuDoGELWc2L35Xhyw1eJKqaoHooUqaNbfpaHHYQIKw6hzyeXQ
	 St2Sp3fGxNhMUpDHdt8rTB6YqrAt3vAQrvvzfltB0lTP9T1WWQo4N74XaHZupyUb5R
	 F7DeAlQE0R7/ReqjSBf15qZn/xs6apm+FAzF80TiLmfM0S0tveLO9Zg0PnSFmVl70y
	 IJDz5raWBtsj+HntAulvi9H/ebJ9shhi8Ee9onqhZlvWNln034hMF/+CmI6J89dibS
	 u6TIndxhevAJw==
Date: Tue, 21 Jul 2026 14:06:45 +0200
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
Message-ID: <al9g1Zq4_MkGD0I0@localhost.localdomain>
References: <20260624132356.516959-1-puranjay@kernel.org>
 <20260624132356.516959-7-puranjay@kernel.org>
 <alD6o01ukyliCS37@localhost.localdomain>
 <6c683413-8e8b-4888-ba01-9d79c3867432@paulmck-laptop>
 <al4vKQ02tBYyYANk@localhost.localdomain>
 <cf1a3ffc-ed2a-41f4-bfd2-cbeab9d06861@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cf1a3ffc-ed2a-41f4-bfd2-cbeab9d06861@paulmck-laptop>

Le Mon, Jul 20, 2026 at 09:55:42AM -0700, Paul E. McKenney a écrit :
> On Mon, Jul 20, 2026 at 04:22:33PM +0200, Frederic Weisbecker wrote:
> > Le Tue, Jul 14, 2026 at 11:48:08AM -0700, Paul E. McKenney a écrit :
> > > > I have similar concerns about the three smp_mb() in
> > > > get_state_synchronize_rcu_full(). It could be just two (rcu_seq_snap()
> > > > has a barrier that could be just one). Not sure if that matters but,
> > > > just wanted to point that.
> > > 
> > > We need the one at the beginning of get_state_synchronize_rcu_full(),
> > > but from what I can see, not the ones in the calls to rcu_seq_snap().
> > > I blame laziness.  We could make an rcu_seq_snap_no_ordering() that
> > > didn't have the smp_mb(), but I didn't believe that the overhead would
> > > be visible at the system level.
> > 
> > It isn't so much about performance than being clear about ordering
> > expectations. Though we could argue that grace period polling can be
> > about performance.
> > 
> > But in general rcu_seq_snap() advertizes:
> > 
> >    READ seq
> >    smp_mb() /* Above access must not bleed into critical section. */
> > 
> > This doesn't tell much. Which critical section? That's not used on
> > read side.
> 
> Fair question!
> 
> And the answer is "any critical section that might later be executed by
> the current task."

But why does it matter, what could go wrong for example?

> 
> Would it help if I made that comment read as follows, separately from
> Puranjay's series?
> 
> 	// The above access must not bleed into any later RCU read-side
> 	// critical section executed by the current task.
> 
> 							Thanx, Paul

-- 
Frederic Weisbecker
SUSE Labs
