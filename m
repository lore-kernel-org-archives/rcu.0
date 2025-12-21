Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD01F42050
	for <rcu@vger.kernel.org>; Sun, 21 Dec 2025 09:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766311156; cv=none; b=aIYhFycA9Z0owFgITkaoPZ6pqliT+mzyzawLxFNbRSPeEm35/f06qM+g+uVcUcVeI5h/M3u7+Jhk/XEp3o86IldTHgeJx9UlWyxuJbE4p9jnTAEeZuUNm/480IDuwRxy3vd2lklW2+U6LphO7q48jqg+INNoDeeNGLM9vtRvMsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766311156; c=relaxed/simple;
	bh=xwKCdQhBtY7sdy8Zz446mEtEqk90qmGnWtG0zOgftIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SSSmJSntO5PIRHVQrHOQy9ToxsGPRMyFwi5sWkU8jhVTju3rE6rc5HfQGEao1FhWzeaYhoM2K1UHLTHGcJDyAevc/f6VwtA4GL4HTbMrxwgVJkKt9mpUrgC570y3kLraFab1TsvWQ93xRlEzNYo9rgmnBqUA5QBd4Giyf+15tSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CwpdrKp0; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwpdrKp0"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4f4c89f8cc6so2806991cf.1
        for <rcu@vger.kernel.org>; Sun, 21 Dec 2025 01:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766311153; x=1766915953; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fjHwQCJ+WLLRT0TZamL7R6ZEjyOxsMVMPGjCn4Gr/2c=;
        b=CwpdrKp09xpRGbzH4Jv5EF8oQWpU7QngCBfwOhRxFVzv61X6VXGTwnjr9c0U3iRI3m
         wKmMvefPRORHajYyFoUJfkGMkCKmCJJzVYiHj0SVfGbtS1rgLZMNn1lIZiBFovOq348X
         dS1dan1yftJh2T5Gy6RaE+dlvruxZrmfRHNKKuDgQXEhJbb2TSpnDcnio65NfnnIsERJ
         L8scSrPEhybCRwA+RGLhmuYLh5GlQEeBVUq9IVEy7sQxV8/HxfpnIP98TI/UKzUG/yYw
         mJnwDKgL4Sn2I0I1JcXyrhnnsel1t3Ax/f9YUvwsn2sml/KI1qhk5pHUJ6MqeyaLSe/P
         92Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766311153; x=1766915953;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fjHwQCJ+WLLRT0TZamL7R6ZEjyOxsMVMPGjCn4Gr/2c=;
        b=PMTxcZygu4FO1Ua1xr4r0sATPXkVIl7AGhaZrnK7MKronLiUzWpK7Fp6fdzGF23VGy
         6kJo0yMQNo+wdsSvCypvv3XQjJI/03RIzoB3BvZW/aHnEQeq97D0ssuIT96WhP5VYpJQ
         IfwA8zfDhDeCzxJtqsj22m+QVnV0fXn65531lY088xgUOH/iZ0Q+tuEs0B/xvqIKN3Io
         JsiJQf0IzyOw6ABWGuhytw/NwEY8j3WkiKUVLHGrK6NAYx4XnBXzsfHHIELT1Kt7rAvf
         rQtd6ldmtUpegcAaNzdPIDi5zjprOBdOWHXxbdG3KEBO3TedwiXjmqjG0M0iwRthfOQm
         l2Ag==
X-Forwarded-Encrypted: i=1; AJvYcCWQLlLfjBdKIjgIu17PUi5djwZvxnGezH7m4br59/fllMna+H4LzCPILJq7xpAD2JC1IG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNEpG5ElTMwknJbTxtyBsrcxvKj1Ng6hQwWJ7W/BmnFyfdEGJF
	WiXG84e4j1GhHWoOQMXnnZxu5FqyG4QUJMaeSq/hrXq1OgLUO0jj4x86
X-Gm-Gg: AY/fxX5Sqy8081ZSQ8nZTvKJFi4mKdz9t1LqE63budjBv3cEbL0z++R8F5kopXA3PUH
	csi3cJ10/GDDiVhOsmU4VIBS63DfknFrLokf4bEKi6xp8xjgxp8lfrDoD+lH0UWO/elxNnMZgjV
	rF/98nmYd8xa7Caa7yel750QbLXJSYRUrHCkaJF+uvnQ4qTpww9F7RwPT229pjR2ry+XQoJGLgq
	wHqTi9fBzIFvoiTCzlIo+IRUxARFnqBFfsIShp3sb3sqO0c/es9THYjkmWjVHJARmG/lR8h7CeH
	42VuTdJPH2UjMuPdexMFLW6m3SMOg3c+uZmZhQ/tI5WZcPXSj4ZC6cwykPVPf2vtExtRzuiAjMi
	mnlb8CUfXF6uUQnPTiLV6CptUFuWcYZJcr2m6qxqE4DLQ/+JTD21iOZ9B/hYcdPDBYcS3Z30ukF
	CmPC9SBlEtG31S3IN3q/TBe0aCuPjPU5gK550EJBYhZvZYsHDrVN8LeAKzaqajyGgzOSYW7VsBT
	VVKad1ghNTXFOY=
X-Google-Smtp-Source: AGHT+IGkZ7YmQ4iCIVP39dS3Dspfdfd6jXXAiK+b4cBzlfzo3Zgdyb/boYNxk+mCnLQREZ4Jn+Teag==
X-Received: by 2002:a05:622a:250:b0:4f3:5346:5d54 with SMTP id d75a77b69052e-4f4abd78d8fmr113519801cf.50.1766311152615;
        Sun, 21 Dec 2025 01:59:12 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f4ac64e43asm54346251cf.26.2025.12.21.01.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 01:59:12 -0800 (PST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 06446F40068;
	Sun, 21 Dec 2025 04:59:11 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 21 Dec 2025 04:59:11 -0500
X-ME-Sender: <xms:7sRHaR2N2v5QV0zS7rTjGaMTxsDxXqevcMfxDYvckKrndiHr9nNznw>
    <xme:7sRHabBBkyoml_p8QsCSVUISTOCodrotwwrFVf2B7-gdeQo-11qe60ozt8uJk-u0T
    HNU-gARi0H5n7K7phSZiFSuAiofuMLm0OKicd7-IEHjM0akskKMcw>
X-ME-Received: <xmr:7sRHaaFsv_hcs8DZVZClK1YuwwoTNd4iBxKqdxkoSNNA8ZJmsbqidfjit9pE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehfeejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopeefvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepjhhovghlrghgnhgvlhhfsehnvhhiughirgdrtghomhdprhgtphhtthhopehmrg
    hthhhivghurdguvghsnhhohigvrhhssegvfhhfihgtihhoshdrtghomhdprhgtphhtthho
    pehjohgvlhesjhhovghlfhgvrhhnrghnuggvshdrohhrghdprhgtphhtthhopehprghulh
    hmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnphhighhgihhnsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepmhhpvgesvghllhgvrhhmrghnrdhiugdrrghupdhrtghp
    thhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpth
    htohepsghighgvrghshieslhhinhhuthhrohhnihigrdguvg
X-ME-Proxy: <xmx:7sRHadqKf0RTS3nOePlAQvUozbdkH1E35MAQvZyfuG_bq4zKpklFew>
    <xmx:7sRHaS1Y2epauX9OBV-y9l-R-Zk5Fbd6FmY3INiJFgdckMvEcL9nFg>
    <xmx:7sRHaRAPbAze_26JzP05OzQKeAn06Zg5nMbyWgmetanI2Ftb88lQ_w>
    <xmx:7sRHad_m279CbYEdXqv4sqfsQSdM2Z_3F2PEOvAtMVxacM33U0ReiQ>
    <xmx:78RHafNWcaktLFSnepHDt1H0rFJluyVrCqzHdfbKcufE0b2QeG9VpLXk>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 21 Dec 2025 04:59:09 -0500 (EST)
Date: Sun, 21 Dec 2025 18:59:07 +0900
From: Boqun Feng <boqun.feng@gmail.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,	linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Will Deacon <will@kernel.org>,	Peter Zijlstra <peterz@infradead.org>,
	Alan Stern <stern@rowland.harvard.edu>,	John Stultz <jstultz@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Waiman Long <longman@redhat.com>,	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,	Vlastimil Babka <vbabka@suse.cz>,
 maged.michael@gmail.com,	Mateusz Guzik <mjguzik@gmail.com>,
 rcu@vger.kernel.org,	linux-mm@kvack.org, lkmm@lists.linux.dev
Subject: Re: [RFC PATCH v4 3/4] hazptr: Implement Hazard Pointers
Message-ID: <aUfE61t5cITwolX7@tardis-2.local>
References: <20251218014531.3793471-4-mathieu.desnoyers@efficios.com>
 <aUO9KRaP0FXpm_l9@tardis-2.local>
 <fcbc99d0-b7c7-45f7-9cf8-f5d3bfad966e@efficios.com>
 <aURihbmjsKi8m7MO@tardis-2.local>
 <42607ed5-f543-41bd-94da-aa0ee7ec71cd@efficios.com>
 <aUSbhiMgluudbVEG@tardis-2.local>
 <edbe45b3-0f85-48d2-8d4f-784781a8dee5@efficios.com>
 <6353feeb-c2ab-4ff6-9ea6-04ae5102641d@nvidia.com>
 <6b27f3c3-47f7-402f-aa6c-b564e3db1d6a@efficios.com>
 <38d05c17-c28e-4ec1-be30-e77fd7015b5a@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38d05c17-c28e-4ec1-be30-e77fd7015b5a@nvidia.com>

On Fri, Dec 19, 2025 at 05:39:00PM -0500, Joel Fernandes wrote:
> 
> 
> On 12/19/2025 5:19 PM, Mathieu Desnoyers wrote:
> > On 2025-12-19 10:42, Joel Fernandes wrote:
> >>
> >> IMHO the overflow case is "special" and should not happen often, otherwise
> >> things are "bad" anyway. I am not sure if this kind of complexity will be worth
> >> it unless we know HP forward-progress is a real problem. Also, since HP acquire
> >> will be short lived, are we that likely to not get past a temporary shortage of
> >> slots?
> > 
> > Given that we have context switch integration which moves the active
> > per-cpu slots to the overflow list, I can see that even not-so-special
> > users which get preempted or block regularly with active per-cpu slots
> > could theoretically end up preventing HP scan progress.
> 
> Yeah, I see. That's the 'problem' with the preemption design of this patchset.
> You always have to move it in and out of overflow list on preemption even when
> there is no overflow AFAICS. My idea (which has its own issues) does not require
> that on preemption.
> 
> > Providing HP scan progress guarantees is IMO an important aspect to
> > consider if we want to ensure the implementation does not cause subtle
> > HP scan stall when its amount of use will scale up.
> 
> Sure. But if you didn't have to deal with a list in the 'normal' case (not over
> saturated slots case), then it wouldn't be that big a deal.
> 

With PREEPT_HAZPTR, the overflow list will be used if a task gets
preempted while using hazptrs, without PREEPT_HAZPTR, the overflow list
will be used if there are more than 8 slots used on the CPU (most likely
due to task being preempted with a hazptr slot being used). Therefore,
if this hazptr design it to have a few users and we want to support that
preemptible hazard pointer read-side section, soon or later we need to
resolve this scanning racing with readers (in context switches) on
overflow list issue.

Surely we don't need to have something perfect in day 1, but planning a
bit ahead won't hurt ;-)

Regards,
Boqun

> >> Perhaps the forward-progress problem should be rephrased to the following?: If a
> >> reader hit an overflow slot, it should probably be able to get a non-overflow
> >> slot soon, even if hazard pointer slots are over-subscribed.
> > 
> > Those are two distinct forward progress guarantees, and I think both are
> > important:
> > 
> > * Forward progress of HP readers,
> > * Forward progress of HP scan.
> 
[..]
