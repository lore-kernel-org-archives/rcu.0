Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79D3350A34;
	Tue, 23 Dec 2025 17:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766512280; cv=none; b=jxn/GTkOmqqbYL1IhLu6046ncqnH3EuiW/fo2ccFgM1wPeCPkkb0HY9HutMYXVoyAt9FE6PvERTPlTk/q2lkT5KJ1gM//LK6/epXLpy+VnT4h8Zf+2lbvFCN9Aa7nLE2wPOZvyRO1LGgDwa8pubKSUVahmN55ACrFGQZty2w/SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766512280; c=relaxed/simple;
	bh=zyktV06PI1K7ByTW0zDaBdIVbdMe3G0N0RYuFZXmJzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCSpvkNOvwOgS1GRvmCHntZnRfTpQkv/bYZKvR+WIWisD9wRI5lrjLV2KK9Ii8UWPkzhSx2IsZPD6UUHVA1Of2sVONYzPdusolXlSqLKXEKWV9BYY2WcpriXUe9ePEocykE2hs/eXD8IQrFnK8BkQyhqJrYdkNrHbXiwg77Fiwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mg4UgBcd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mg4UgBcd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FCA9C113D0;
	Tue, 23 Dec 2025 17:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766512280;
	bh=zyktV06PI1K7ByTW0zDaBdIVbdMe3G0N0RYuFZXmJzU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=mg4UgBcdoHlCLpOSC4ty+kUWJ5NEDrBeLZNHH/liYKueaVLv8aXtQZ5kBrpff8DU1
	 Py+XEbYmAGLF136LNW8Ewf1wGDyuiGngZvlUPHyuQpGQBiOZEy9KeY6osMFrKtRKWL
	 jzfSr6V+/mjRd2Lxs9rMqMmvwmwS1KPBGm0kyktLrplUXOaLwVS2aNe4GsxplDiYJR
	 AzMcYpIgm+XEu/LmhN2CAoVgAHe/qm4PnPdMN0VsnBWiYIY55ldiZAExmr0c6BDXbM
	 t8eaM1F40N4nLLvrz1GAY0sAr3fyYLyPKVux/tfsADyuX+3CMiMY0vfC7oUwN8YGEL
	 7o3KlIdlgDLLA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CEC04CE1A0B; Tue, 23 Dec 2025 09:51:19 -0800 (PST)
Date: Tue, 23 Dec 2025 09:51:19 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, rcu@vger.kernel.org, clm@meta.com
Subject: Re: [PATCH] rcutorture: Fix operator precedence bug in exp_current()
 invocation
Message-ID: <fa889e55-19f6-417b-9a25-676ecfcd39a7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20251223004407.61147-1-joelagnelf@nvidia.com>
 <4bbae00e-f078-4f1e-a1e0-b1cdc72981de@paulmck-laptop>
 <20251223113758.2c6bb15d@gandalf.local.home>
 <f99bbb2e-62bd-47fb-8cee-07716766c087@nvidia.com>
 <52bda0a7-5311-4e62-89c5-287c731548e4@paulmck-laptop>
 <086174f6-8bc9-4417-a878-ef665c0b0f10@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <086174f6-8bc9-4417-a878-ef665c0b0f10@nvidia.com>

On Tue, Dec 23, 2025 at 12:30:01PM -0500, Joel Fernandes wrote:
> 
> 
> On 12/23/2025 12:28 PM, Paul E. McKenney wrote:
> > On Tue, Dec 23, 2025 at 12:22:51PM -0500, Joel Fernandes wrote:
> >> On 12/23/2025 11:37 AM, Steven Rostedt wrote:
> >>> On Mon, 22 Dec 2025 17:12:18 -0800
> >>> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> >>>
> >>>> Good eyes, thank you!
> >>>>
> >>>> Unfortunately, Chris Mason beat you to it:
> >>>
> >>> Was it Chris or his AI? ;-)
> >>
> >> Does it matter? It is like saying, was it "Chris or his text editor". ;-)
> > 
> > Adding Chris on CC for his thoughts on whether it was him or his AI and
> > whether or not this matters.  Should he choose to share any thoughts on
> > either topic.  ;-)
> 
> "Was it Paul replying here, or was it his email client?" ;-)

"Yes!!!"  ;-)

> Sorry I couldn't help. :-) What is a Christmas holiday if not for poking some fun?

No problem!

I was half expecting something along the lines of "Is Paul an AI?" ;-)

							Thanx, Paul
