Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794596384;
	b=ILYiUm5VUC/MtIpvo9oRcD19yTZY/53pY6tURqKZMPYUddf5YPtQSNpwIDDaTc4FfrvY
	 re7HhCh4fZ3OKcrhGtazc6px6rz1p6fLMzeTsjj6yBYLeYwNhS1plc0fdsX0hN92mc+vQ
	 +ZENhoHo0L/BFk3NaVHTUPGvoMpcn6ftkiwPx7Fay841YcPXJAxI6HDNp0as76kHhlTr9
	 5fUaDr9iedeDj51amoEgEUpn+vpjGSBMr34tRkZl8ytXzSVoFf491wKzKN+E6NrzFZp92
	 hJGEeT1Bz+kavSeHqsjtkJGrk8wVYoJWo4y5EC81ueYAcQB1lZ+hzW05ozT1EfA2TXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596384;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=dui1W7jk+v6MWpOHawIjDQi5dY/oJUeQXewkO5tAW9o=;
	b=rDP/haek00xhTsnkUbDyIZiF91wJRrz3UBev4yWUj/Fxal+cfbaEWGYOgBLnjtMey/pg
	 Kfn99QOwg9b419npP0sJICmfA7efLIoDRsjU8cOZ9TwA6AUDeh9gKW5WcRfxMGlITGTGi
	 yLq2KYifesvF1R77U228NUTduAbLM7bdfeaoLlTd3tsg0OAnAkcoxpBgkgg/FtYsnTq2X
	 QZfGGW0x46CiTS0CpKd7zUlFQWOf6JGuwB7OrEwGrfx1tazj/W1XEXzTVRVtsAq7d8Am8
	 IAYXgyaAXUCe4rqp7XZEebyR2XEjQa3J8XITo/+q9/gb6vZ3+Yuz3bA8IScrTA200KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="KUuVOs//";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0DC606A896;
	Fri, 13 Nov 2026 18:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KUuVOs//
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA6A31F000C4;
	Fri, 13 Nov 2026 18:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794596383;
	bh=dui1W7jk+v6MWpOHawIjDQi5dY/oJUeQXewkO5tAW9o=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=KUuVOs//0rZ7FQWLItFJ2fh7oZ89jOKKvECSOTk2JuBLE68NLyqv1d+//Ub96airj
	 gQyFMVP4EKEu9TBAEdXqf6dXdByYPoFMr8KeGp0MGpL/gRKfeU2u7CZTQxPHBsZ79b
	 +u0nuBGE7fHI1Zk0EG9QYoiJsxHHdFsz/mOTk54/4wElKB7lhm2uKsFRyvSAo+DIyB
	 TrSnnkTg9NQDlgy2Y3QUClABuAoBySwrCA3tk/0s5M6iYJ+ikYI8xfk0Izr+LIQsnU
	 LYdrgRvZnGyMZ5cWGPvALPmQYior27ElXEFxuc393KvmFRTMmBZdbalH04t9WDwLdc
	 1BDjBc0RCEBOQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9C8DFCE0B59; Fri, 13 Nov 2026 10:59:43 -0800 (PST)
Date: Fri, 13 Nov 2026 10:59:43 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Andrea Righi <arighi@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>,
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH] rcutorture: Don't try to disable to RT throttling.
Message-ID: <db990dbe-e76d-494c-be87-6759f097adb0@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <5970553A-3833-43F1-A013-21757664FB8F@nvidia.com>
 <auzXjQfYXs_gzx1y@gpd4>
 <c81d8243-c130-44d8-bef6-e678ecb088ac@paulmck-laptop>
 <20261106140401.90MH_6qt@linutronix.de>
 <5f5ffa5b-9fa5-4359-87fc-7558f37ff0eb@paulmck-laptop>
 <20261110080942.QxKXirzI@linutronix.de>
 <e58e48c3-ac62-40cd-b5d3-2de87db12496@paulmck-laptop>
 <20261111154319.2Iu5wbqr@linutronix.de>
 <3e7f1b45-7163-4abd-b686-a17f137ecab9@paulmck-laptop>
 <20261113153737.cXtBKIEl@linutronix.de>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113153737.cXtBKIEl@linutronix.de>

On Fri, Nov 13, 2026 at 04:37:37PM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-11-11 09:30:37 [-0800], Paul E. McKenney wrote:
> > I hesitate to disable CPU hotplug during RCU priority boosting...  Yes,
> > one could argue that real-time workloads shouldn't be doing CPU hotplug.
> > Except that others seem to be working towards making CPU hotplug more
> > friendly to real-time situations.
> > 
> > But what fix did you have in mind?
> 
> I was thinking about skipping sched_init_dl_servers() in the built-in
> case. But now that Joel started to reworking the test, it looks like a
> better solution.

Thank you both for your work towards making the scheduler more able to
handle this sort of thing and for your support of Joel's approach.

You know, RCU priority boosting seemed *so* simple when I first started
working on it!  ;-)

							Thanx, Paul
