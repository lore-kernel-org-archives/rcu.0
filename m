Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F4B27E1C5;
	Fri, 23 Jan 2026 21:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769203667; cv=none; b=haEGK6JCigKzt40e45WJ404StiFqtEn1n7261esFY/NnG98vLDUHEHn9veRpqkhs2yLlp26jUOS9842I6cWVzkR20m9Cgiowq2fsXAvuBW45WcRZCBOhdzZ/shauvD89aVd+aSpQaPqtQo2j4tX/3D2LkV4kLlcfCZ//4qkyIgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769203667; c=relaxed/simple;
	bh=TwReG/EktPBpncHK7OeCSkOrmAeOzPZYdl3ZP1sUjYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ei+zJxZkneOC8ra4hndbqz9Ezx2Mn6PyYnw1kWxNXHGXI3I4HPrpIbm0WqhRSr879kCGbAw7HjhjoLOKwLr9xaP1ODSEbJJhpXbIlciUlc0+Z5zzU+eeaV8B+sQdW/wCQ1Ejo/9Y+bXJYPYiFLMq+ctAYcEft/2CMBLLp94j4Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEGbZMeb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MEGbZMeb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C4CC4CEF1;
	Fri, 23 Jan 2026 21:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769203667;
	bh=TwReG/EktPBpncHK7OeCSkOrmAeOzPZYdl3ZP1sUjYk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=MEGbZMeb+ER3vJjhbctvevipFPFEb/uitVTm78lUDy4c1X7dWPYbfqil2y3+XgWdE
	 MrevWPLuZ3MkMBCoExCvuH5vt/pkhOBkhQB6IU2deXDBq7wakeTAEMLiwZaTa68f9v
	 niX4qfMBq6ztfF3hH4T63bJ6CsEiRE30MJCn1nTTRA7rYj3QlIkW2PKvgZ5I97N/zM
	 nf5ByliyGSO0oYvsD8CfvqxXeQv9Xb6gMoUBuvDB7W8g41C2WRw+UhPSqKwhTWG/1H
	 8otbfNQCYBAOVXSn0B0r4XMg4ffFoXoYcyEaHeicJTf5qAisoWSLhzjowPF8Nme7qH
	 qfQ55dCs3IbVw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CE47DCE0B27; Fri, 23 Jan 2026 13:27:46 -0800 (PST)
Date: Fri, 23 Jan 2026 13:27:46 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
	rcu@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>
Subject: Re: [PATCH -next v3 2/3] rcu/nocb: Remove dead callback overload
 handling
Message-ID: <816a14e0-c06e-496a-9c84-512c76d98157@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <EBEF016B-721C-4A54-98E3-4B8BE6AA4C21@nvidia.com>
 <013102c7-a1c8-4f13-8dd9-5803e4d69aaf@nvidia.com>
 <68fd874e-ac9b-4d91-ab05-903bf45856fa@paulmck-laptop>
 <1737646200.reply.joelagnelf@nvidia.com>
 <735d16d4-f727-4cc1-91d8-16155135f550@paulmck-laptop>
 <6441f33d-b4ac-4483-87c6-236998803338@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6441f33d-b4ac-4483-87c6-236998803338@nvidia.com>

On Fri, Jan 23, 2026 at 02:36:37PM -0500, Joel Fernandes wrote:
> On 1/23/2026 11:49 AM, Paul E. McKenney wrote:
> > We could have one CPU flooding and the rest idle, and many other
> > combinations.  And, if I recall correctly, polling can burn extra CPU
> > and cause extra wakeups even when the system is fully idle.  Or has
> > that changed?
> 
> In my experience working on lazy RCU, if you have such a kind of overload on
> any CPU, then you're usually not saving any power anyway. The system has to
> be really quiet and idle with a low stream of callbacks for you to save
> power. Further, when the callback length increases too much, we don't turn
> on lazy RCU anyway because the idea is that we are overloaded and the
> system is busy - so we already have such assumptions baked in. I think a
> similar argument could apply here for dynamically enabling polling mode only
> when overloaded.

The concern is detecting overload quickly.  Any unnecessary gaps in
invoking RCU callbacks cannot be made up.  That time is gone.
And the polling does sleeps...

> I was coming more from the point of view of improving grace period performance
> when we do have an overload, potentially resolving the overloaded situation
> faster than usual. We would dynamically trigger polling based on such
> circumstances.
> 
> That said, I confess I don't have extensive experience with polling mode beyond
> testing. I believe we should add more rcutorture test cases for this. I'm
> considering adding a new config that enables polling for NOCB - this testing is
> what revealed the potential for grace period performance improvement with NOCB
> to me.

The main purpose of polling was to make call_rcu() avoid at least some
of its slowpaths.  If we are getting some other benefit out of it, is
polling the best way to achieve that benefit?

							Thanx, Paul
