Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442261FF5F9;
	Tue, 23 Dec 2025 20:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766523180; cv=none; b=ArjPCv7pCQxhIAN9Sl7aOt833do1RspHL3sdPSomM/RpGsUXwDR0wTl1EccbgI4PhEylH4mCU8RE/JlpnGAl1tFt03PW00F99VNH38gVJmD8pN9s+aqPBA/2VjoGCj6pOv73TpYHPzVx075OX4ECIlqzubw2aDWh06BNB3h4YiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766523180; c=relaxed/simple;
	bh=GpdNYB20IPNWXDgSRe14H4TtN7GeqwOsD+HGQoRTVxs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EXNrbVj3qwuCaE57woIgWYZK2/gPjhRIq0Ynv9vZewHcxSIyh4l5Nbmf/T5ALSGWsEkvqBT/E+lX0omWR0nrm8+tUJOkYB5Vo5pggmtRtIS28kzsECJYNO6lR5os52MOAGL3Bmx8dyr4+bDjLVTox343NO2HXLBAlM44rbUpP4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 0D00BC13B1;
	Tue, 23 Dec 2025 20:52:56 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 410E82E;
	Tue, 23 Dec 2025 20:52:53 +0000 (UTC)
Date: Tue, 23 Dec 2025 15:54:43 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org,
 Davidlohr Bueso <dave@stgolabs.net>, Josh Triplett <josh@joshtriplett.org>,
 Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Uladzislau
 Rezki <urezki@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang@linux.dev>, rcu@vger.kernel.org, clm@meta.com
Subject: Re: [PATCH] rcutorture: Fix operator precedence bug in
 exp_current() invocation
Message-ID: <20251223155443.7165adf9@gandalf.local.home>
In-Reply-To: <fa889e55-19f6-417b-9a25-676ecfcd39a7@paulmck-laptop>
References: <20251223004407.61147-1-joelagnelf@nvidia.com>
	<4bbae00e-f078-4f1e-a1e0-b1cdc72981de@paulmck-laptop>
	<20251223113758.2c6bb15d@gandalf.local.home>
	<f99bbb2e-62bd-47fb-8cee-07716766c087@nvidia.com>
	<52bda0a7-5311-4e62-89c5-287c731548e4@paulmck-laptop>
	<086174f6-8bc9-4417-a878-ef665c0b0f10@nvidia.com>
	<fa889e55-19f6-417b-9a25-676ecfcd39a7@paulmck-laptop>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 410E82E
X-Stat-Signature: qrqthrhc1mhxkz3omn1ae6hmkof7zn8b
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18ty0vUJKczJW6d8NGUFxMU/UmQSgJOTyc=
X-HE-Tag: 1766523173-499387
X-HE-Meta: U2FsdGVkX19LuFxZSaCMq+ifEFrjFToT1rWAgI6rAL3SfMuI0Ogku8no5/z/6IRKjYNWcj1wGjR4VQao/pwI9HtWD7goDqT2DgmsHahZdXCTS1ujwdycGHqfFSxlGX+7+wuU7wvA/CZ+alBWeW9y/JpoqmmYW4hG9jm5eCkBJ+BoRiBWcSJP1/qyF9vsKC5DHVWHNtjP+IGaThK5M26MrS5PdHkOPsAzCFF3CeruCQnMhBX3rSTZiKAjTEDzZ5AhZEVxU9z1GHjdjWAiSI2gpD8kydqSbiLQtepRRorFhGJDIEp+ShsLbr7g8FVCvpLznTsdBGO8CXj3e4yV2c92hBqvzvgJ7W+j

On Tue, 23 Dec 2025 09:51:19 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> On Tue, Dec 23, 2025 at 12:30:01PM -0500, Joel Fernandes wrote:
> > 
> > 
> > On 12/23/2025 12:28 PM, Paul E. McKenney wrote:  
> > > On Tue, Dec 23, 2025 at 12:22:51PM -0500, Joel Fernandes wrote:  
> > >> On 12/23/2025 11:37 AM, Steven Rostedt wrote:  
> > >>> On Mon, 22 Dec 2025 17:12:18 -0800
> > >>> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > >>>  
> > >>>> Good eyes, thank you!
> > >>>>
> > >>>> Unfortunately, Chris Mason beat you to it:  
> > >>>
> > >>> Was it Chris or his AI? ;-)  
> > >>
> > >> Does it matter? It is like saying, was it "Chris or his text editor". ;-)  

I think AI is a bit more powerful than a text editor. Unless you think
Chris is using emacs?

> > > 
> > > Adding Chris on CC for his thoughts on whether it was him or his AI and
> > > whether or not this matters.  Should he choose to share any thoughts on
> > > either topic.  ;-)  
> > 
> > "Was it Paul replying here, or was it his email client?" ;-)  
> 
> "Yes!!!"  ;-)
> 
> > Sorry I couldn't help. :-) What is a Christmas holiday if not for poking some fun?  
> 
> No problem!
> 
> I was half expecting something along the lines of "Is Paul an AI?" ;-)

I guess that begs the question. Is your intelligence artificial? ;-)

-- Steve

