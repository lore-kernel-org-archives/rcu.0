Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7651F515976;
	Wed, 30 Sep 2026 17:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790791137; cv=none; b=rYSsh+taVRoWsdA3g1wkm8V6J8FXXfaAbKor+HYfTSbyi9NjCzLgFn0u/aNC+c1OP2JjWHjIT2etMJZnyCf1NjSs2rth4TqthBbuxdsAgr7red+7kBMXXwURB1FAXSux/hocreZH0XG3QXKgsfI5qqrb3bUgratNL2JsKynSo2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790791137; c=relaxed/simple;
	bh=OsEmx55lG94YSA/2UT51q4q8YPO7fZqp+ESHiK2i7Hc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKWL+Rmx7HGeX79Isy+73lXN7n4SxIhsRJ4wNkESi9dij56S5JFHGfo71p+YOKiqnP3fP7QMREtBzoZRtugseTTC7qCORUd3M8zbH4OBK4+OYw1E7NMBQKX277FhO95o0+se39PQ8gXmwcX5nsZBnFbiRpaRAIgP3lCWsIKPhQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CT+NuRpP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CT+NuRpP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F3141F00899;
	Wed, 30 Sep 2026 17:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790791136;
	bh=T/2dJsbTn/7UsYJLAxq+CoNqmXHIBWHGiLbuAsPyclw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=CT+NuRpPId5PTaMXijX+CZVKn29hRGGJ13ogiHio2ML95JEXWlAdB+moCf4k5934B
	 t3AN4eKsOKeMXDK5OWjP1M9ElmJAh9QnlNC/0c1YxQm/NQp3Wp9Z2E96D+3erWBPyW
	 l6fB0wwqq6B9vGJ86XXB6DDdV9bMTZtHhNVGV21I7IVimuB68ZtZ1/guD7lz7kxDx7
	 rYC1+ffi+8GBnIWLCD3c7dkYm2bnnaUt6TkX5xC8Y/5RTZgwqsE1RqPQEX4IZqtaAt
	 iQew2dEOvRLariXpcaMpiAF9GjFgAT6dPmxVJCAL32VX9/Gcp2F7DRzWPVI/lcYEpu
	 nUOTykg6rPUmQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B647ECE097C; Wed, 30 Sep 2026 10:58:55 -0700 (PDT)
Date: Wed, 30 Sep 2026 10:58:55 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Thomas Gleixner <tglx@kernel.org>,
	Tejun Heo <tj@kernel.org>, Andrea Righi <arighi@nvidia.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Gustavo Luiz Duarte <gustavold@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>, rcu <rcu@vger.kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: include rtmutex_common.h in tree_stall.h
Message-ID: <933cda87-1ff2-4c37-834b-541411d11420@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260925133922.1356404-1-arnd@kernel.org>
 <21dd141a-03d7-49e6-a83b-f4dda898cedf@paulmck-laptop>
 <b00b3c05-2faf-40fa-a978-7d7f35db47b9@app.fastmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b00b3c05-2faf-40fa-a978-7d7f35db47b9@app.fastmail.com>

On Wed, Sep 30, 2026 at 09:07:48AM +0200, Arnd Bergmann wrote:
> On Tue, Sep 29, 2026, at 23:07, Paul E. McKenney wrote:
> > On Fri, Sep 25, 2026 at 03:39:04PM +0200, Arnd Bergmann wrote:
> >
> > Good catch, and thank you!!!
> >
> > What I am going to do in the name of bisectability is to merge this into
> > the commit that added that call to rt_mutex_owner(), which attribution:
> >
> > 1eccf02fb8d5 ("rcu: Add running and boosted indications to RCU task stall dump")
> 
> Sounds good to me. Don't worry too much about attribution, you can always
> treat my oneline fixes as bug reports. I just try to make it easy to apply
> as-is in case you are not rebasing your patches.

Like this:

[ paulmck: Apply feedback from Arnd Bergmann and kernel test robot. ]

;-)

							Thanx, Paul
