Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1536C208A1;
	Mon, 13 May 2024 16:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715619397; cv=none; b=nEeF9fIY+d1auGty3ptQF37v0h8liMY1onwMo0m1xRTbXeHx5q2eNH+ASAon349NIZnR90sa7VBnky+SYmdd+cBQO4RiWhmsFiNqBRPmp+PsTIZfy9ZN2ylXa05bpnZ+CWVOQKZj9LrwQ/0KlhmkMQ+rxoK3ZXQlUhyyMa7Z3e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715619397; c=relaxed/simple;
	bh=kDUE2YBSI6XESDuJs1tvY4S5ix6CLVxPpXG0bXiNekg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KgqU6DCVhLcx/RzgQEHlaCDGSlFeRzY9+bqC/Pp5ZCadApp1jUeNB9CHakrHytVwr5gggHoYwVLEqFygrG2XCPrchwq44tBi/s1TFou7vxCTMAVIFX//UUnj1MfHQ+KuK86ER/f86SfKsC8s89rUQP+Tv0S4erVipfRAekweUXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qJruhOoP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJruhOoP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABD28C113CC;
	Mon, 13 May 2024 16:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715619396;
	bh=kDUE2YBSI6XESDuJs1tvY4S5ix6CLVxPpXG0bXiNekg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=qJruhOoPJb/wCT7/9Viy63KOzw7Ku992k6DXPKg2B2bosXApsfTDrkD0bVScLe3CH
	 ppHdY4Jl+6gd5IFAu5GLhqlt+8yoWr/6Klxbytru/fI+ru1ovzb2Kyiot+pUheOzzS
	 9cQ53WKz/vzYOS+Z+qR50tOnMGAe3E1clpenhiJSPRisR0HKV5KvgFgkq+fGMyJZO6
	 iQv1fVEsRdCEuLwGBpp18TKFmfw0+p1XqDlzZjvS45utDFSOriY/IS6rYLdF9YufK1
	 Az3d6Tby3FZtK0V4IVS0GBfu0JzcCAz7wNheiTvWZn4Vm93TpMH8/xa5tM5VBKorIN
	 Qhl4EIU+k6yqw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A6A8BCE0448; Mon, 13 May 2024 09:56:29 -0700 (PDT)
Date: Mon, 13 May 2024 09:56:29 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Johannes Berg <johannes.berg@intel.com>,
	Nikita Kiryushin <kiryushin@ancud.ru>, linke li <lilinke99@qq.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Zenghui Yu <zenghui.yu@linux.dev>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [GIT PULL] RCU changes for v6.10
Message-ID: <925ad012-ba28-48dc-8498-1721954e902e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240510183049.312477-1-urezki@gmail.com>
 <CAHk-=wh=HgEeyKVKGXTKiLdhvs-5t9pFxUkK6ED+zsby=quBdA@mail.gmail.com>
 <e35bf672-88d9-4a00-8237-99298392e55f@paulmck-laptop>
 <CAHk-=wjLr_c_7N0rTOD2eBd=WFydas-Z+_9ucwO_YkegYxrw+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjLr_c_7N0rTOD2eBd=WFydas-Z+_9ucwO_YkegYxrw+Q@mail.gmail.com>

On Mon, May 13, 2024 at 09:48:47AM -0700, Linus Torvalds wrote:
> On Mon, 13 May 2024 at 09:46, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > Yes, this is intentional, nothing odd is going on, and Uladzislau's pull
> > request is legitimate.
> 
> If this is more than a one-time thing, maybe Uladzislau should be in
> the MAINTAINERS entry too?

I queued a patch for this (admittedly embarrassingly few days ago)
in -rcu:

e3838cb87bb4 ("MAINTAINERS: Add Uladzislau Rezki as RCU maintainer")

Unless you tell me you want it sooner, we will sending this into the
v6.11 merge window.

							Thanx, Paul
